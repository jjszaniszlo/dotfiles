;;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package exec-path-from-shell
  :init
  :if (memq window-system '(mac ns x))
  :hook
  (after-init . exec-path-from-shell-initialize))

(setq use-package-always-ensure t)

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

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setopt confirm-kill-processes nil)

(use-package dir-config
  :custom
  (dir-config-file-names '(".dir-config.el"))
  (dir-config-allowed-directories '("~/Development"))
  :config
  (dir-config-mode))

(require 'keychain-environment)
;; (load! "lisp/keychain-environment")
(keychain-refresh-environment)

(use-package ultra-scroll
  :vc (:url "https://github.com/jdtsmith/ultra-scroll" :branch "main")
  :init
  (setq scroll-conservatively 101 ; important!
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

(add-to-list 'custom-theme-load-path (expand-file-name "themes/" user-emacs-directory))

(use-package emacs
  :config
  (setopt custom-safe-themes t)
  (use-package autothemer
    :config
    (add-hook `after-init-hook (load-theme 'kanagawa))))

(defun font-available-p (font-name)
  (find-font (font-spec :name font-name)))

(let ((mono-spaced-font "VictorMono Nerd Font")
      (proportionately-spaced-font "iA Writer Duo S"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 220)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 0.8))

(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))

(use-package golden-ratio
  :diminish golden-ratio-mode
  :init
  (golden-ratio-mode 1)
  :custom
  (golden-ratio-auto-scale t))

(setq x-stretch-cursor t)

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

(use-package markdown-mode)
(use-package yaml-mode)
(use-package json-mode)
(use-package toml-mode)
(use-package conf-mode)

(use-package nix-mode)

(require 'odin-mode)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package editorconfig
  :hook
  (after-init . (lambda () (editorconfig-mode 1))))

(add-hook 'prog-mode-hook 'electric-pair-mode)

(use-package paredit
  :ensure t
  :commands paredit-mode
  :hook
  (emacs-lisp-mode . paredit-mode)
  :config
  (define-key paredit-mode-map (kbd "RET") nil))

(use-package origami
  :hook (prog-mode . origami-mode))

(use-package move-text
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

(setq ido-enable-flex-matching t)
(setq ido-doeverywhere t)
(ido-mode 1)

(defun fx/highlight-todo-keywords ()
  "Add custom keywords for highlighting TODOs and similar annotations."
  (font-lock-add-keywords nil
  		    '(("\\<\\(TODO\\|FIXME\\|BUG\\|HACK\\|NOTE\\|REVIEW\\|DEPRECATED\\):" 1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'fx/highlight-todo-keywords)

(use-package darkroom)

(use-package org
  :commands (org-mode org-version)
  :mode
  ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-adapt-indentation nil)
  (org-edit-src-content-indentation 0)
  ;; (org-fontify-todo-headline t)
  ;; (org-fontify-whole-heading-line t)
  ;; (org-fontify-quote-and-verse-blocks t)
  (org-startup-truncated t))

(use-package vterm
  :defer t
  :commands vterm
  :bind (("C-c t" . vterm))
  :config
  ;; Speed up vterm
  (setq vterm-timer-delay 0.01)
  ;; Free up F7-F9 to be used for popper mode
  (define-key vterm-mode-map (kbd "<f7>") nil)
  (define-key vterm-mode-map (kbd "<f8>") nil)
  (define-key vterm-mode-map (kbd "<f9>") nil))

(defun reload-init-file ()
  "Reload the user's init file."
  (interactive)
  (load-file user-init-file)
  (keychain-refresh-environment))

(bind-key "C-c r i" 'reload-init-file)
