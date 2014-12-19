Thanks to d87 <github.com/d87> for an idea of highlighting lua
builtins/numbers

Thanks to Vedat Hallac <github.com/vhallac> for sharing some of
his fixes and updates to core indentation logics

Thanks to Rafael Sanchez <rafael@cornerdimension.com> for patch
adding lua-mode to interpreter-mode-alist

Thanks to Leonardo Etcheverry <leo@kalio.net> for enabling
narrow-to-defun functionality

Thanks to Tobias Polzin <polzin@gmx.de> for function indenting
patch: Indent "(" like "{"

Thanks to Fabien <fleutot@gmail.com> for imenu patches.

Thanks to Simon Marshall <simonm@mail.esrin.esa.it> and Olivier
Andrieu <oandrieu@gmail.com> for font-lock patches.

Additional font-lock highlighting and indentation tweaks by
Adam D. Moss <adam@gimp.org>.

INSTALLATION:

To install, just copy this file into a directory on your load-path
(and byte-compile it). To set up Emacs to automatically edit files
ending in ".lua" or with a lua hash-bang line using lua-mode add
the following to your init file:

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

Usage

Lua-mode supports c-mode style formatting and sending of
lines/regions/files to a Lua interpreter. An interpreter (see
variable `lua-default-application') will be started if you try to
send some code and none is running. You can use the process-buffer
(named after the application you chose) as if it were an
interactive shell. See the documentation for `comint.el' for
details.

Lua-mode works with Hide Show minor mode (see ``hs-minor-mode``).

Key-bindings

To see all the keybindings for Lua mode, look at `lua-setup-keymap'
or start `lua-mode' and type `\C-h m'.
The keybindings may seem strange, since I prefer to use them with
lua-prefix-key set to nil, but since those keybindings are already used
the default for `lua-prefix-key' is `\C-c', which is the conventional
prefix for major-mode commands.

You can customise the keybindings either by setting `lua-prefix-key'
or by putting the following in your .emacs
     (define-key lua-mode-map <your-key> <function>)
for all the functions you need.
