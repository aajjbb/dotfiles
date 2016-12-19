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
(set-frame-font "OfficeCodePro 11")

;; Adding flycheck support
;; C++ 11 in flycheck
(add-hook 'c++-mode-hook (lambda () (setq-default flycheck-gcc-language-standard "c++11")))
(add-hook 'after-init-hook #'global-flycheck-mode)


;; block annoying home screen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cdfb22711f64d0e665f40b2607879fcf2607764b2b70d672ddaa26d2da13049f" "930227e22122d1881db7c2c1ae712dcf715697a1c4d9864f8107a2c3c2da9f8b" "d69a0f6d860eeff5ca5f229d0373690782a99aee2410a3eed8a31332a7101f1e" "06fc6014871028d24b4e03db24b9efee48bd73dce0afdc15e9124f09fab64afa" "db9feb330fd7cb170b01b8c3c6ecdc5179fc321f1a4824da6c53609b033b2810" "e8e744a1b0726814ac3ab86ad5ccdf658b9ff1c5a63c4dc23841007874044d4a" "0b6645497e51d80eda1d337d6cabe31814d6c381e69491931a688836c16137ed" "09669536b4a71f409e7e2fd56609cd7f0dff2850d4cbfb43916cc1843c463b80" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" "fe1682ca8f7a255cf295e76b0361438a21bb657d8846a05d9904872aa2fb86f2" "eafda598b275a9d68cc1fbe1689925f503cab719ee16be23b10a9f2cc5872069" "83e584d74b0faea99a414a06dae12f11cd3176fdd4eba6674422539951bcfaa8" "49ad7c8d458074db7392f8b8a49235496e9228eb2fa6d3ca3a7aa9d23454efc6" "f1af57ed9c239a5db90a312de03741e703f712355417662c18e3f66787f94cbe" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "787574e2eb71953390ed2fb65c3831849a195fd32dfdd94b8b623c04c7f753f0" "26247bcb0b272ec9a5667a6b854125450c88a44248123a03d9f242fd5c6ec36f" "07fe4a500a4812c8fda390e0035aa322f7139d13cf6031bb0fb26ec909cfb67c" "fe243221e262fe5144e89bb5025e7848cd9fb857ff5b2d8447d115e58fede8f7" "456ac8176c7c01680384356cbdc568a7683d1bada9c83ae3d7294809ddda4014" "1934bf7e1713bf706a9cb36cc6a002741773aa42910ca429df194d007ee05c67" "e4bc8563d7651b2fed20402fe37b7ab7cb72869f92a3e705907aaecc706117b5" "569dc84822fc0ac6025f50df56eeee0843bffdeceff2c1f1d3b87d4f7d9fa661" "6209442746f8ec6c24c4e4e8a8646b6324594308568f8582907d0f8f0260c3ae" "0f002f8b472e1a185dfee9e5e5299d3a8927b26b20340f10a8b48beb42b55102" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "a233249cc6f90098e13e555f5f5bf6f8461563a8043c7502fb0474be02affeea" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "f0ea6118d1414b24c2e4babdc8e252707727e7b4ff2e791129f240a2b3093e32" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "3d568788393420c93d778df9a46c59b81dd5d9acabaf3b5962659bc0772012aa" "3d568788393420c93dg78df9a46c59b81dd5d9acabaf3b5962659bc0772012aa" "7ed6913f96c43796aa524e9ae506b0a3a50bfca061eed73b66766d14adfa86d1" "013e87003e1e965d8ad78ee5b8927e743f940c7679959149bbee9a15bd286689" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "0d19ff470ad7029d2e1528b3472ca2d58d0182e279b9ab8acd65e2508845d2b6" "758da0cfc4ecb8447acb866fb3988f4a41cf2b8f9ca28de9b21d9a68ae61b181" "acad05d1a9b0137b6866bb08c297b5ce22168f2feeccbbffcdb7f00d181eb8ad" default)))
 '(flycheck-perl-executable "/home/aajjbb/perl5/perlbrew/perls/perl-5.20.1/bin/perl")
 '(flycheck-perl-include-path
   (quote
    ("/home/aajjbb/perl5/perlbrew/perls/perl-5.20.1/lib/site_perl/5.20.1")))
 '(global-flycheck-mode t)
 '(haskell-mode-hook (quote (turn-on-haskell-indent)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (neotree haskell-mode zenburn-theme yaxception yaml-mode web-mode warm-night-theme underwater-theme twittering-mode tuareg sunny-day-theme sublime-themes spacegray-theme soothe-theme solarized-theme soft-morning-theme smyx-theme smart-shift slime-theme scala-outline-popup rainbow-mode php-mode perl-completion pde paper-theme org occidental-theme mustard-theme moe-theme minesweeper matlab-mode magit lush-theme lua-mode log4e leuven-theme js2-mode jedi jazz-theme grandshell-theme gotham-theme flycheck flatland-theme firecode-theme direx dark-krystal-theme darcula-theme d-mode cyberpunk-theme csharp-mode color-theme-solarized boron-theme bliss-theme base16-theme alect-themes afternoon-theme ac-octave ac-html))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
;; (load-theme 'base16-railscasts-dark)
(load-theme 'base16-pop-dark)


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
(set-frame-parameter (selected-frame) 'alpha '(92 92))
(add-to-list 'default-frame-alist '(alpha 92 92))

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
