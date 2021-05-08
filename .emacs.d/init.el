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

;;; global configuration section

(global-display-line-numbers-mode)

;; force files to end with a new line
(setq require-final-newline t)

;; make emacs kill ring iteraction with system clipboard
(setq select-enable-clipboard t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package configuration section

;; package to smartly reason about parenthesis on code.
(use-package smartparens
  :ensure
  :init
  (progn
    (use-package smartparens-config)
    (smartparens-global-mode 1)
    )
  )

(use-package rainbow-mode
	     :config
	     (rainbow-mode 1))

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
 '(package-selected-packages
   '(smartparens smartparens-config rainbow-mode company use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
