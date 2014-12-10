(package-initialize)
;; control backup files
;; (setq backup-directory-alist `(("." . "~/.saves")))
;; actually saving them all in temp folder
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))


;; load plugins 
;; (add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; tab lenght config
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(set-default-font "Bitstream Vera Sans Mono 11")
    

;; block annoying home screen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("3d568788393420c93d778df9a46c59b81dd5d9acabaf3b5962659bc0772012aa" "3d568788393420c93dg78df9a46c59b81dd5d9acabaf3b5962659bc0772012aa" "7ed6913f96c43796aa524e9ae506b0a3a50bfca061eed73b66766d14adfa86d1" "013e87003e1e965d8ad78ee5b8927e743f940c7679959149bbee9a15bd286689" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "0d19ff470ad7029d2e1528b3472ca2d58d0182e279b9ab8acd65e2508845d2b6" "758da0cfc4ecb8447acb866fb3988f4a41cf2b8f9ca28de9b21d9a68ae61b181" "acad05d1a9b0137b6866bb08c297b5ce22168f2feeccbbffcdb7f00d181eb8ad" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; dos2unix function
(defun dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; set windows title to file name
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;; define tabspace
(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode t)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; make emacs share clipboard with the system (nw mode)
(load-file "~/.emacs.d/xclip.el")

(setq x-select-enabme-clipboard t)
;; make emacs kill ring iteraction with system clipboard
(setq x-select-enable-clipboard t)
;; (setq x-select-enable-primary t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; set theme
(load-theme 'lush)

;; load auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; load tramp
(require 'tramp)
