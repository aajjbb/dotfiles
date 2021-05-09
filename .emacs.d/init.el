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
			 ;;                       ("marmalade" . "http://marmalade-repo.org/packages/")
			 ;;                       ("Melpa" . "http://melpa.milkbox.net/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
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
(load-theme 'nord)

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
(global-whitespace-mode 1)

;; set background mode
(setq-default frame-background-mode 'dark)

;; set transparency to emacs client
(set-frame-parameter (selected-frame) 'alpha '(93 93))
(add-to-list 'default-frame-alist '(alpha 93 93))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package configuration section

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

(use-package all-the-icons)

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

;; show visual information about file indentation
(use-package indent-guide
  :ensure
  :config
  (progn
    (indent-guide-global-mode))
  )

;; set cc-mode
(use-package cc-mode
  :defer t)

;; use flycheck on c/c++ code
(use-package flycheck
  :config
  (progn
    (add-hook 'c-mode-hook 'flycheck-mode)
    (add-hook 'c++-mode-hook (lambda () (progn
					  'flycheck-mode
					  (setq-default  flycheck-g++-language-standard "c++14")
					  )))
    )
  :defer t
  :ensure t)

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
 '(custom-safe-themes
   '("197cefea731181f7be51e9d498b29fb44b51be33484b17416b9855a2c4243cb1" default))
 '(package-selected-packages
   '(flycheck indent-guide nord-theme all-the-icons powerline smartparens smartparens-config rainbow-mode company use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
