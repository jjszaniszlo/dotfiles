(setq custom-file "~/.emacs.custom.el")

(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")

(load "~/.emacs.rc/org-mode-rc.el")

;; general
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)

;; misc
(setq-default inhibit-splash-screen t
              make-backup-files nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode `column-number-mode)

(setq vc-follow-symlinks t)

;; path
(rc/require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
          (exec-path-from-shell-initialize))

;; theme
(rc/require 'autothemer)
(require 'kanagawa-theme)
(load-theme 'kanagawa t)

;; font
(defun font-exists-p (font) (if (null (x-list-fonts font)) nil t))
(when (window-system)
  (cond ((font-exists-p "VictorMono NF") (set-frame-font "VictorMono NF" nil t))
    ((font-exists-p "VictorMono Nerd Font") (set-frame-font "VictorMono Nerd Font" nil t))))

(set-face-attribute 'default nil :height 220)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-doeverywhere t)
(ido-mode 1)

;; which key
(which-key-mode)

;; lsp-mode
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-keymap-prefix "C-c l")
(rc/require 'lsp-mode)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; odin-mode
(require `odin-mode)

(add-hook 'odin-mode-hook #'lsp-deferred)
(add-hook 'odin-mode-hook #'flycheck-mode)
 
;;; dired
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

;;; helm
(setq helm-ff-transformer-show-only-basename nil)

(rc/require 'helm)

(global-set-key (kbd "C-c h t") 'helm-cmd-t)
(global-set-key (kbd "C-c h g g") 'helm-git-grep)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h r") 'helm-recentf)

;;; Move Text
(rc/require 'move-text)

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; magit
(setq magit-auto-revert-mode nil)

(rc/require 'magit)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)
