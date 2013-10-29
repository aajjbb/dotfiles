;; load plugins 
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; block annying home screen
(custom-set-variables
 '(inhibit-startup-screen t))
(custom-set-faces )

;; configs from auto complete
(add-to-list 'load-path "~/.emacs.d/plugins/autocomplete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/autocomplete//ac-dict")
(ac-config-default)

;; set windows title to file name
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;; set color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-emacs-nw)

;; define tabspace
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
