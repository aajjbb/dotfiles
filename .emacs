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
	("30dba2d97337684340fb2d478ce10f220d83d7a29aaa298b01b58dcb64b5989d" "569dc84822fc0ac6025f50df56eeee0843bffdeceff2c1f1d3b87d4f7d9fa661" "6209442746f8ec6c24c4e4e8a8646b6324594308568f8582907d0f8f0260c3ae" "0f002f8b472e1a185dfee9e5e5299d3a8927b26b20340f10a8b48beb42b55102" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "a233249cc6f90098e13e555f5f5bf6f8461563a8043c7502fb0474be02affeea" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "f0ea6118d1414b24c2e4babdc8e252707727e7b4ff2e791129f240a2b3093e32" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "3d568788393420c93d778df9a46c59b81dd5d9acabaf3b5962659bc0772012aa" "3d568788393420c93dg78df9a46c59b81dd5d9acabaf3b5962659bc0772012aa" "7ed6913f96c43796aa524e9ae506b0a3a50bfca061eed73b66766d14adfa86d1" "013e87003e1e965d8ad78ee5b8927e743f940c7679959149bbee9a15bd286689" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "0d19ff470ad7029d2e1528b3472ca2d58d0182e279b9ab8acd65e2508845d2b6" "758da0cfc4ecb8447acb866fb3988f4a41cf2b8f9ca28de9b21d9a68ae61b181" "acad05d1a9b0137b6866bb08c297b5ce22168f2feeccbbffcdb7f00d181eb8ad" default)))
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
(load-theme 'afternoon)

;; show line numbers
(global-linum-mode t)

;; load auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; load tramp
(require 'tramp)

;; remove menu bar
(menu-bar-mode -1)

;; remove tool bar
(tool-bar-mode -1)

;; remove scrool bar
(toggle-scroll-bar -1) 
