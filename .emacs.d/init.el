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
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))

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

(use-package rainbow-mode
	     :config
	     (rainbow-mode 1)
