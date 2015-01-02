;;; pde-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "compile-dwim" "compile-dwim.el" (21670 1193
;;;;;;  394163 979000))
;;; Generated autoloads from compile-dwim.el

(defvar compile-dwim-alist `((perl (or (name . "\\.pl$") (mode . cperl-mode)) "%i -wc \"%f\"" "%i \"%f\"") (c (or (name . "\\.c$") (mode . c-mode)) ("gcc -o %n %f" "gcc -g -o %n %f") ,@(if (memq system-type '(windows-nt ms-dos)) (list "%n.exe" "%n.exe") (list '("./%n" "cint %f") "%n"))) (c++ (or (name . "\\.cpp$") (mode . c++-mode)) ("g++ -o %n %f" "g++ -g -o %n %f") ,@(if (memq system-type '(windows-nt ms-dos)) (list "%n.exe" "%n.exe") (list '("./%n" "cint %f") "%n"))) (java (or (name . "\\.java$") (mode . java-mode)) "javac %f" "java %n" "%n.class") (python (or (name . "\\.py$") (mode . python-mode)) "%i %f" "%i %f") (javascript (or (name . "\\.js$") (mode . javascript-mode)) "smjs -f %f" "smjs -f %f") (tex (or (name . "\\.tex$") (name . "\\.ltx$") (mode . tex-mode) (mode . latex-mode)) "latex %f" "latex %f" "%n.dvi") (texinfo (name . "\\.texi$") (makeinfo-buffer) (makeinfo-buffer) "%.info") (sh (or (name . "\\.sh$") (mode . sh-mode)) "%i ./%f" "%i ./%f") (f99 (name . "\\.f90$") "f90 %f -o %n" "./%n" "%n") (f77 (name . "\\.[Ff]$") "f77 %f -o %n" "./%n" "%n") (php (or (name . "\\.php$") (mode . php-mode)) "php %f" "php %f") (elisp (or (name . "\\.el$") (mode . emacs-lisp-mode) (mode . lisp-interaction-mode)) (emacs-lisp-byte-compile) (emacs-lisp-byte-compile) "%fc")) "\
Settings for certain file type.
A list like ((TYPE CONDITION COMPILE-COMMAND RUN-COMMAND EXE-FILE) ...).
In commands, these format specification are available:

  %i  interpreter name
  %F  absolute pathname            ( /usr/local/bin/netscape.bin )
  %f  file name without directory  ( netscape.bin )
  %n  file name without extention  ( netscape )
  %e  extention of file name       ( bin )

The interpreter is the program in the shebang line. If the
program is valid(test with `executable-find'), then use this program,
otherwise, use interpreter in `interpreter-mode-alist' according
to the major mode.")

(custom-autoload 'compile-dwim-alist "compile-dwim" t)

(autoload 'compile-dwim-compile "compile-dwim" "\


\(fn FORCE &optional SENTINEL)" t nil)

(autoload 'compile-dwim-run "compile-dwim" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "help-dwim" "help-dwim.el" (21670 1199 777542
;;;;;;  690000))
;;; Generated autoloads from help-dwim.el

(autoload 'help-dwim "help-dwim" "\
Show help info for NAME.
TYPE is one of `help-dwim-active-types'.

\(fn NAME &optional TYPE)" t nil)

(autoload 'help-dwim-active-type "help-dwim" "\
Active type for current buffer.
If APPEND is non-nil, that mean the TYPE is an additional help command.
Use `help-dwim-customize-type' for active or deactive type globally.

\(fn TYPE &optional APPEND)" t nil)

;;;***

;;;### (autoloads nil "imenu-tree" "imenu-tree.el" (21670 1193 270829
;;;;;;  769000))
;;; Generated autoloads from imenu-tree.el

(defvar imenu-tree-icons '(("Types" . "function") ("Variables" . "variable")) "\
*A list to search icon for the button in the tree.
The key is a regexp match the tree node name. The value is the icon
name for the children of the tree node.")

(custom-autoload 'imenu-tree-icons "imenu-tree" t)

(autoload 'imenu-tree "imenu-tree" "\
Display tree view of imenu.
With prefix argument, select imenu tree buffer window.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "inf-perl" "inf-perl.el" (21670 1200 354213
;;;;;;  459000))
;;; Generated autoloads from inf-perl.el

(defalias 'run-perl 'inf-perl-start)

(autoload 'inf-perl-start "inf-perl" "\
Run an inferior perl process, input and output via buffer *perl*.
If there is a process already running in `*perl*', switch to that buffer.

\(fn &optional BUFFER)" t nil)

;;;***

;;;### (autoloads nil "pde" "pde.el" (21670 1200 174212 179000))
;;; Generated autoloads from pde.el

(autoload 'pde-tabbar-register "pde" "\
Add tabbar and register current buffer to group Perl.

\(fn)" nil nil)

(autoload 'pde-ffap-locate "pde" "\
Return cperl module for ffap.

\(fn NAME &optional FORCE)" nil nil)

(autoload 'pde-compilation-buffer-name "pde" "\
Enable running multiple compilations.

\(fn MODE)" nil nil)

(autoload 'pde-ido-imenu-completion "pde" "\


\(fn INDEX-ALIST &optional PROMPT)" nil nil)

(autoload 'pde-indent-dwim "pde" "\
Indent the region between paren.
If region selected, indent the region.
If character before is a parenthesis(such as \"]})>\"), indent the
region between the parentheses. Useful when you finish a subroutine or
a block.
Otherwise indent current subroutine. Selected by `beginning-of-defun'
and `end-of-defun'.

\(fn)" t nil)

(autoload 'pde-perl-mode-hook "pde" "\
Hooks run when enter perl-mode

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "pde-project" "pde-project.el" (21670 1193
;;;;;;  134162 132000))
;;; Generated autoloads from pde-project.el

(autoload 'pde-project-find-file "pde-project" "\
Find file in the project.
This command is will read all file in current project recursively.
With prefix argument, to rebuild the cache.

\(fn &optional REBUILD)" t nil)

;;;***

;;;### (autoloads nil "pde-util" "pde-util.el" (21670 1199 530874
;;;;;;  268000))
;;; Generated autoloads from pde-util.el

(autoload 'pde-list-module-shadows "pde-util" "\
Display a list of modules that shadow other modules.

\(fn)" t nil)

(autoload 'pde-list-core-modules "pde-util" "\
Display a list of core modules.

\(fn)" t nil)

(autoload 'pde-apropos-module "pde-util" "\
Search modules by name.

\(fn RE)" t nil)

(autoload 'pde-search-cpan "pde-util" "\
Search anything in CPAN.

\(fn MOD)" t nil)

(autoload 'pde-yaml-dump "pde-util" "\
Read Perl data from region and dump as YAML.
For example call the command on region:
    {
      'session' => {
        'dbic_class' => 'AddressDB::Session',
        'flash_to_stash' => '1'
      }
    }
will turn out to be:
   ---
   session:
     dbic_class: AddressDB::Session
     flash_to_stash: 1

\(fn BEG END REPLACE)" t nil)

(autoload 'pde-yaml-load "pde-util" "\
Read YAML data and dump as Perl data.
For example call the command on region:
   ---
   session:
     dbic_class: AddressDB::Session
     flash_to_stash: 1
will turn out to be:
    $VAR1 = {
      'session' => {
        'dbic_class' => 'AddressDB::Session',
        'flash_to_stash' => '1'
      }
    }

\(fn BEG END REPLACE)" t nil)

(autoload 'pde-generate-loaddefs "pde-util" "\
Create pde-loaddefs.el

\(fn LISP-DIR)" t nil)

;;;***

;;;### (autoloads nil "perlcritic" "perlcritic.el" (21670 1200 310879
;;;;;;  818000))
;;; Generated autoloads from perlcritic.el

(autoload 'perlcritic "perlcritic" "\
Call perlcritic.
If region selected, call perlcritic on the region, otherwise call
perlcritic use the command given.

\(fn)" t nil)

(autoload 'perlcritic-region "perlcritic" "\


\(fn BEG END)" t nil)

;;;***

;;;### (autoloads nil "perldb-ui" "perldb-ui.el" (21670 1199 720875
;;;;;;  620000))
;;; Generated autoloads from perldb-ui.el

(autoload 'perldb-ui "perldb-ui" "\
Run perldb on program FILE in buffer *gud-FILE*.
The directory containing FILE becomes the initial working directory
and source-file directory for your debugger.

\(fn COMMAND-LINE)" t nil)

;;;***

;;;### (autoloads nil "perldoc" "perldoc.el" (21670 1199 487540 628000))
;;; Generated autoloads from perldoc.el

(defvar perldoc-pod-encoding-list '(("perltw" . big5)) "\
*Encoding for pods")

(custom-autoload 'perldoc-pod-encoding-list "perldoc" t)

(autoload 'perldoc "perldoc" "\
Display perldoc using woman.
The SYMBOL can be a module name or a function. If the module and
function is the same, add \".pod\" for the module name. For example,
\"open.pod\" for the progma open and \"open\" for function open.

\(fn SYMBOL &optional MODULEP)" t nil)

(autoload 'perldoc-tree "perldoc" "\
Create pod tree.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "perltidy" "perltidy.el" (21670 1199 937543
;;;;;;  828000))
;;; Generated autoloads from perltidy.el

(autoload 'perltidy-region "perltidy" "\
Tidy perl code in the region.

\(fn BEG END)" t nil)

(autoload 'perltidy-buffer "perltidy" "\
Call perltidy for whole buffer.

\(fn)" t nil)

(autoload 'perltidy-subroutine "perltidy" "\
Call perltidy for subroutine at point.

\(fn)" t nil)

(autoload 'perltidy-dwim "perltidy" "\
Perltidy Do What I Mean.
If with prefix argument, just show the result of perltidy.
You can use C-x C-s to save the tidy result.
If region is active call perltidy on the region. If inside
subroutine, call perltidy on the subroutine, otherwise call
perltidy for whole buffer.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "tags-tree" "tags-tree.el" (21670 1199 894210
;;;;;;  186000))
;;; Generated autoloads from tags-tree.el

(autoload 'tags-tree "tags-tree" "\


\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "template-simple" "template-simple.el" (21670
;;;;;;  1193 67494 992000))
;;; Generated autoloads from template-simple.el

(autoload 'template-simple-expand-template "template-simple" "\
Expand template in file.
Parse the template to parsed templates with `template-compile'.
Use `template-expand-function' to expand the parsed template.

\(fn FILE)" t nil)

(autoload 'template-simple-expand "template-simple" "\
Expand string TEMPLATE.
Parse the template to parsed templates with `template-compile'.
Use `template-expand-function' to expand the parsed template.

\(fn TEMPLATE)" nil nil)

;;;***

;;;### (autoloads nil "tempo-x" "tempo-x.el" (21670 1197 37523 203000))
;;; Generated autoloads from tempo-x.el

(autoload 'tempo-x-space "tempo-x" "\
Expand tempo if complete in `tempo-local-tags' or insert space.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tree-mode" "tree-mode.el" (21670 1199 417540
;;;;;;  128000))
;;; Generated autoloads from tree-mode.el

(autoload 'tree-minor-mode "tree-mode" "\
More keybindings for tree-widget.

\\{tree-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "windata" "windata.el" (21670 1193 204162 630000))
;;; Generated autoloads from windata.el

(autoload 'windata-name-winconf "windata" "\
Save window configuration with NAME.
After save the window configuration you can restore it by NAME using
`windata-restore-named-winconf'.

\(fn NAME)" t nil)

(autoload 'windata-restore-named-winconf "windata" "\
Restore saved window configuration.

\(fn NAME)" t nil)

(autoload 'windata-display-buffer "windata" "\
Display buffer more precisely.
FRAME-P is non-nil and not window, the displayed buffer affect
the whole frame, that is to say, if DIR is right or left, the
displayed buffer will show on the right or left in the frame. If
it is nil, the buf will share space with current window.

DIR can be one of member of (right left top bottom).

SIZE is the displayed windowed size in width(if DIR is left or
right) or height(DIR is top or bottom). It can be a decimal which
will stand for percentage of window(frame) width(heigth)

DELETE-P is non-nil, the other window will be deleted before
display the BUF.

\(fn BUF FRAME-P DIR SIZE &optional DELETE-P)" nil nil)

;;;***

;;;### (autoloads nil nil ("pde-abbv.el" "pde-load.el" "pde-loaddefs.el"
;;;;;;  "pde-patch.el" "pde-pkg.el" "pde-vars.el" "perlapi.el" "re-builder-x.el"
;;;;;;  "tabbar-x.el") (21670 1200 682654 616000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; pde-autoloads.el ends here
