;;; init.el --- aajjbb emacs configuration
;;
;; Filename: init.el
;; Description: aajjbb's emacs configuration
;; Author: aajjbb
;; Created: Mon Oct 14 11:37:26 2013 (-0400)
;; Version: 0.0.1
;; URL: www.github.com/aajjbb/dotfiles
;; Keywords: emacs
;; Compatibility: emacs >= 25


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.

(require 'package)

;; Any add to list for package-archives (to add marmalade or melpa) goes here
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;;("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ;;("melpa-stable" . "https://stable.melpa.org/packages/")
			 )
      )
(package-initialize)

;; Load plugins
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; Control backup files by creating a folder to it.
;; This avoids annoying ~filename~ files being created
;; to the same folder of the original file.
(setq backup-directory-alist `(("." . "~/.saves")))
;; actually saving them all in temp folder
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; global configuration section

;; remove emacs's toolbar, menubar and scroolbar
(mapc
 (lambda (mode)
   (when (fboundp mode)
     (funcall mode -1)))
 '(menu-bar-mode tool-bar-mode scroll-bar-mode))

;; set the emacs theme
(use-package blackboard-theme
  :ensure t
  :init
  (add-hook 'after-init-hook (lambda () (load-theme 'blackboard t)))
)


;; force emacs to show line numbers
(global-display-line-numbers-mode)

;; remove emacs start up screean
(setq inhibit-startup-screen t)

;; force files to end with a new line
(setq require-final-newline t)

;; make emacs kill ring iteraction with system clipboard
(setq select-enable-clipboard t)

;; make unix unicode default
(setq-default default-buffer-file-coding-system 'utf-8-unix)

;; make whitespaces and line endings visible
;;(global-whitespace-mode 1)

;; highlight the current line
(global-hl-line-mode 1)

;; set background mode
(setq-default frame-background-mode 'dark)

;; set transparency to emacs client
(set-frame-parameter (selected-frame) 'alpha '(93 93))
(add-to-list 'default-frame-alist '(alpha 93 93))

;; start emacs server, in case we want to open clients later
(unless (and (fboundp 'server-running-p)
             (server-running-p))
  (server-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package configuration section

;; set ws-butler mode. it delete trailing whitespaces from
;; changed lines
(use-package ws-butler
  :ensure
  :init
  (add-hook 'prog-mode-hook #'ws-butler-mode)
)

;; package to smartly reason about parenthesis on code.
(use-package smartparens
  :ensure
  :init
  (progn
    (use-package smartparens-config)
    (smartparens-global-mode 1)
    (show-smartparens-global-mode +1)
    )
  )

;; (use-package all-the-icons-ivy-rich
;;   :ensure t
;;   :init (all-the-icons-ivy-rich-mode 1))

;; (use-package ivy-rich
;;   :ensure t
;;   :init (ivy-rich-mode 1))

;; setup ag search
(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

;; includes powerline
(use-package powerline
  :ensure
  :init
  (progn
    (powerline-default-theme)
    )
  )
;; emacs mode to show colors for #rgb variables.
(use-package rainbow-mode
  :config
  (rainbow-mode 1))

;; uniquify package improves default buffer naming
(use-package uniquify
  :config (setq uniquify-buffer-name-style 'forward))

;; set js2-mode as the default mode for *.js files
(use-package js2-mode
  :mode ("\\.js$" . js2-mode)
  :interpreter ("node" . js2-mode)
  :config
  (progn
    (add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))))

;; set web-mode as the default mode for *.html files
(use-package web-mode
  :mode ("\\.html$" . web-mode)
  :config
  (progn
    (add-hook 'web-mode-hook (lambda () (setq web-mode-markup-indent-offset 2)))
    )
  )

(use-package neotree
  :ensure t
  :defer t
  )

;; show visual information about file indentation
(use-package indent-guide
  :ensure
  :config
  (progn
    (indent-guide-global-mode))
  )

;; set cc-mode
(use-package cc-mode
  :defer t
  :config
  (progn
    (setq c-default-style "k&r")
    (setq tab-width 2)
    (setq c-basic-offset 2)
  ))

;; use flycheck on c/c++ code
(use-package flycheck
  :ensure t
  :defer 5
  :config
  (progn
    (global-flycheck-mode 1)
    )
)

;; set mode for markdown files.
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  )

;;
(use-package diff-hl
  :ensure t
  :init (global-diff-hl-mode)
  :config (add-hook 'vc-checkin-hook 'diff-hl-update))

;; set ido mode. tis enhace emac's search
(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (ido-mode 1))

;; set python configuration with elpy
(use-package python
  :config (progn
            (use-package elpy
              :config (elpy-enable)
              :ensure t))
  :defer t)

;; set cua mode, allowing C-c C-v for cop/paste.
(use-package cua-base
  :init (cua-mode 1)
  )

(use-package company
  :config (global-company-mode t)
  :defer 2
  :ensure t)

;;; this is added by the emacs package manager
;;; one should not change it manually.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vectorc__
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#263238"))
 '(custom-safe-themes
   '("4eb69f17b4fa0cd74f4ff497bb6075d939e8d8bf4321ce8b81d13974000baac1" "a325ba05dc3b5c2fa89af0ff354bbbe90251fb1a6e6d5682977cebe61ce72ab7" "7922b14d8971cce37ddb5e487dbc18da5444c47f766178e5a4e72f90437c0711" "197cefea731181f7be51e9d498b29fb44b51be33484b17416b9855a2c4243cb1" default))
 '(fci-rule-color "#37474f")
 '(hl-sexp-background-color "#1c1f26")
 '(package-selected-packages
   '(blackboard-theme tomorrow-night-paradise tomorrow-night-paradise-theme melancholy-theme zeno zeno-theme erlang tide elpy diff-hl material-theme magit helm markdown-mode ag flycheck indent-guide nord-theme all-the-icons powerline smartparens smartparens-config rainbow-mode company use-package))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
