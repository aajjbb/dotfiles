;;; package --- Summary This is my .emacs file

;;; Commentary:

;;; Code:

(package-initialize)
;; control backup files
(setq backup-directory-alist `(("." . "~/.saves")))
;; actually saving them all in temp folder
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))


;; load plugins
;; (add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; load requires
(require 'web-mode)
(require 'tramp)
(require 'uniquify)



;; set default font
;;(set-frame-font "Droid Sans Mono Slashed 11")
(set-frame-font "OfficeCodeProLight 11")

;; Adding flycheck support
;; C++ 11 in flycheck
(add-hook 'c++-mode-hook (lambda () (setq-default flycheck-gcc-language-standard "c++11")))
(add-hook 'after-init-hook #'global-flycheck-mode)


;; block annoying home screen
;; dos2unix function
(defun dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; set windows title to file name
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;; define tabspace
;; tab lenght config
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
;;(setq tab-stop-list (number-sequence 4 200 4))

;;(setq-default indent-tabs-mode nil)
;;(setq-default tab-width 4)
;;(setq indent-line-function 'insert-tab)


;;(setq-default c-basic-offset 4
;;			  tab-width 4
;;			  indent-tabs-mode t)

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

;; make emacs kill ring iteraction with system clipboard
(setq select-enable-clipboard t)

;; (setq x-select-enable-primary t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; set theme
;; (load-theme 'spolsky)
;; (load-theme 'lush)
;; (load-theme 'cyberpunk)
;; (load-theme 'spolsky)
;; (load-theme 'base16-default-dark)
(load-theme 'base16-railscasts t)
;; (load-theme 'base16-pop-dark)


;; show line numbers
(global-linum-mode t)

;; load auto-complete
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;; remove menu bar
(menu-bar-mode -1)

;; remove tool bar
(tool-bar-mode -1)

;; remove scrool bar
(toggle-scroll-bar -1)



;; web-mode mapping
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tt2\\'" . web-mode))

;; Defining js2 as main method for Javascript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))



;; show bracket and parenthesis matching
(show-paren-mode 1)

;;
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Emacs transparency
(set-frame-parameter (selected-frame) 'alpha '(80 80))
(add-to-list 'default-frame-alist '(alpha 80 80))

;; Rainbow minor mode (show real colors of rgb colors
(rainbow-mode 1)

;; binds C-C <arrows> using smart-shift mode
;; (when (require 'smart-shift nil 'noerror)
;;  (global-smart-shift-mode 1))

;; adding windmode support (move windows with shift-arrow)
;; (when (fboundp 'windmove-default-keybindings)
;;  (windmove-default-keybindings))

;; remap RET
;; (define-key key-translation-map (kbd "RET") (kbd "C-j"))

;;; .emacs ends here
