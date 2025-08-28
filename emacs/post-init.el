;;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

(setq use-package-always-ensure t)

(if (daemonp)
    (setq use-package-always-demand t))

(use-package compile-angel
 :ensure t
 :custom
 (compile-angel-verbose t)

 :config
 (push "/init.el" compile-angel-excluded-files)
 (push "/early-init.el" compile-angel-excluded-files)
 (push "/pre-init.el" compile-angel-excluded-files)
 (push "/post-init.el" compile-angel-excluded-files)
 (push "/pre-early-init.el" compile-angel-excluded-files)
 (push "/post-early-init.el" compile-angel-excluded-files)

 (compile-angel-on-load-mode 1))

(use-package exec-path-from-shell
  :init
  :hook
  (after-init . exec-path-from-shell-initialize))

(use-package no-littering
  :config
  (no-littering-theme-backups))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(add-hook 'after-init-hook #'global-auto-revert-mode)
(add-hook 'after-init-hook #'recentf-mode)
(add-hook 'after-init-hook #'savehist-mode)
(add-hook 'after-init-hook #'save-place-mode)

(add-hook 'recentf-mode-hook
          (lambda ()
            (add-to-list 'recentf-exclude
                         (recentf-expand-file-name no-littering-var-directory))))

(use-package dir-config
  :custom
  (dir-config-file-names '(".dir-config.el"))
  (dir-config-allowed-directories '("~/Development" "~/Documents"))
  :config
  (dir-config-mode))

(use-package ultra-scroll
  :vc (:url "https://github.com/jdtsmith/ultra-scroll" :branch "main")
  :init
  (setq scroll-conservatively 101 ; important!
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

(use-package kanagawa-themes
  :config
  (load-theme 'kanagawa-wave))

(use-package auto-dark
  :custom
  (auto-dark-themes '((kanagawa-wave) (kanagawa-lotus)))
  :init
  (auto-dark-mode))

(defun jj/setup-font-faces ()
  "Setup all font faces."
  (when (display-graphic-p)
    (let ((mono-spaced "VictorMono Nerd Font")
          (prop-spaced "iA Writer Duo S"))
      (set-face-attribute 'default nil :family mono-spaced :height 190)
      (set-face-attribute 'fixed-pitch nil :family mono-spaced :height 1.0)
      (set-face-attribute 'variable-pitch nil :family prop-spaced :height 0.8))
    (with-eval-after-load 'org
      (dolist (face '((org-level-1 . 1.3)
                      (org-level-2 . 1.25)
                      (org-level-3 . 1.20)
                      (org-level-4 . 1.15)
                      (org-level-5 . 1.10)
                      (org-level-6 . 1.05)
                      (org-level-7 . 1.0)
                      (org-level-8 . 1.0)))
        (set-face-attribute (car face) nil :font "iA Writer Duo S" :weight 'regular :height (cdr face))
        )
      (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
      (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
      (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
      (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
      (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
      (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
      (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
      )
    )
  )
(add-hook 'after-init-hook 'jj/setup-font-faces)
(add-hook 'server-after-make-frame-hook 'jj/setup-font-faces)

(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))

(defun fx/highlight-todo-keywords ()
  "Add custom keywords for highlighting TODOs and similar annotations."
  (font-lock-add-keywords nil '(("\\<\\(TODO\\|FIXME\\|BUG\\|HACK\\|NOTE\\|REVIEW\\|DEPRECATED\\):" 1 font-lock-warning-face t))))
(add-hook 'prog-mode-hook 'fx/highlight-todo-keywords)

(use-package golden-ratio
  :diminish golden-ratio-mode
  :init
  (golden-ratio-mode 1)
  :custom
  (golden-ratio-auto-scale t))

(setq x-stretch-cursor t)

(use-package emacs
  :commands jj/cursor-type-mode
  :config
  (setq-default cursor-type 'box)
  (setq-default cursor-in-non-selected-windows '(bar . 2))
  (setq-default blink-cursor-blinks 50)
  (setq-default blink-cursor-interval 0.75)
  (setq-default blink-cursor-delay 0.2)

  (blink-cursor-mode -1)

  (define-minor-mode jj/cursor-type-mode
    "Toggle between static block and pulsing bar cursor."
    :init-value nil
    :global t
    (if prot/cursor-type-mode
        (progn
          (setq-local blink-cursor-interval 0.75
                      cursor-type '(bar . 2)
                      cursor-in-non-selected-windows 'hollow)
          (blink-cursor-mode 1))
      (dolist (local '(blink-cursor-interval
                       cursor-type
                       cursor-in-non-selected-windows))
        (kill-local-variable `,local))
      (blink-cursor-mode -1))))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setopt display-line-numbers-width 3)           ; Set a minimum width
(setopt display-line-numbers-type 'relative)    ; Relative line numbers

(add-hook 'text-mode-hook 'visual-line-mode)

(let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
  (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))

(setopt x-underline-at-descent-line nil)

(setopt show-trailing-whitespace t)

(global-set-key [remap list-buffers] 'ibuffer)

(setopt use-short-answers t)

(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(global-set-key [remap keyboard-quit] 'prot/keyboard-quit-dwim)

(use-package which-key
  :config
  (which-key-mode))

(setq ido-enable-flex-matching t)
(setq ido-doeverywhere t)
(ido-mode 1)

(use-package org
  :ensure t
  :commands (org-mode org-version)
  :mode
  ("\\.org\\'" . org-mode)
  :custom
  (org-startup-truncated t)
  (org-agenda-files (list "~/Documents/Org/agenda.org"))
  (org-export-backends '(md))
  :bind (("C-c a" . org-agenda)
         ("C-c l" . org-store-link)
         ("C-c b" . org-iswitchb)))

(use-package darkroom
  :bind ("C-c d r" . darkroom-tentative-mode))

(use-package magit
  :bind (("C-c m s" . magit-status))
  :custom
  ;; Improve readability of diffs
  (magit-diff-refine-hunk 'all))

(use-package magit
  :if (eq system-type 'darwin)
  :custom
  (magit-git-executable "/opt/homebrew/bin/git"))

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (prog-mode . diff-hl-flydiff-mode)))

(unless (package-installed-p 'odin-mode)
  (package-vc-install "https://git.sr.ht/~mgmarlow/odin-mode"))
(use-package odin-mode
  :bind (:map odin-mode-map
	      ("C-c C-r" . 'odin-run-project)
	      ("C-c C-c" . 'odin-build-project)
	      ("C-c C-t" . 'odin-test-project)))

(defun reload-init-file ()
  "Reload the user's init file."
  (interactive)
  (load-file user-init-file)
  (keychain-refresh-environment))
