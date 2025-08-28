;;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package exec-path-from-shell
  :init
  :hook
  (after-init . exec-path-from-shell-initialize))
