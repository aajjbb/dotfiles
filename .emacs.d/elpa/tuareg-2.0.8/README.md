Tuareg: an Emacs OCaml mode
===========================

This archive contains files to help editing [OCaml](http://ocaml.org/)
code, to highlight important parts of the code, to run an OCaml
toplevel, and to run the OCaml debugger within Emacs.

Contents
--------

`README`         — This file.  
`HISTORY`        — Differences with previous versions.  
`tuareg.el`      — A major mode for editing OCaml code in Emacs.  
`ocamldebug.el`  — To run the OCaml debugger under Emacs.  
`sample.ml`      — Sample file to check the indentation engine.

Install
-------

See `tuareg.el`.

	

Configuration
-------------

Add the following line near the beginning of your ~/.emacs file:

    (load "/where/ever/you/put/tuareg-mode/tuareg-site-file")
  
The Tuareg major mode is triggered by visiting a file with extension
.ml, .mli, .mly, .mll, and .mlp or manually by M-x tuareg-mode. It
gives you the correct syntax table for the OCaml language.

Thanks to the work of Stefan Monnier, a new indentation engine based
on SMIE was written.  To deactivate it, add (setq tuareg-use-smie nil)
to the top-level of your `.emacs` file.

Usage
-----

See `tuareg.el`.

Customization
-------------

The standard Emacs customization tool can be used to configure
Tuareg options.  It is available from the Options menu and Tuareg's
Customize sub-menu.

You may also customize the appearance of OCaml code by twiddling the
variables listed at the start of tuareg.el (preferably using
`tuareg-mode-hook`, you should not patch the file directly).
You should then add to your configuration file something like:

    (add-hook 'tuareg-mode-hook
      (lambda () ... ; your customization code ))

Sample Customizations
---------------------

Here are random examples of customization you might like to put in
your ~/.emacs file:

    ;; Indent `=' like a standard keyword.
    (setq tuareg-lazy-= t)
    ;; Indent [({ like standard keywords.
    (setq tuareg-lazy-paren t)
    ;; No indentation after `in' keywords.
    (setq tuareg-in-indent 0)
    
    (add-hook 'tuareg-mode-hook
              ;; Turn on auto-fill minor mode.
              (lambda () (auto-fill-mode 1)))
    
Features, Known Bugs
--------------------

Cf. online help.

Thanks
------

Ian Zimmerman for the previous mode, compilation interface and
debugger enhancement.

Jacques Garrigue enhanced Zimmerman's mode along with an adaptation
to OCaml (and Labl) syntax. Although this work was performed
independently, his useful test file and comments were of great help.

Michel Quercia for excellent suggestions, patches, and helpful
emacs-lisp contributions (full, ready-to-work implementations, I
should say), especially for Tuareg interactive mode, and browser
capacities.

Denis Barthou, Pierre Boulet, Jean-Christophe Filliatre and Rémi
Vanicat for intensive testing, useful suggestions, and help.

Ralf Treinen for maintaining the Debian GNU/Linux package.

Every people who sent me bug reports, suggestions, comments and
patches. Nothing would have improved since version 0.9.2 without
their help. Special thanks to Eli Barzilay, Josh Berdine, Christian
Boos, Carsten Clasohm, Yann Coscoy, Prakash Countcham, Alvarado
Cuihtlauac, Erwan David, Gilles Défourneaux, Philippe Esperet,
Gilles Falcon, Tim Freeman, Alain Frisch, Christian Lindig, Claude
Marché, Charles Martin, Dave Mason, Stefan Monnier, Toby Moth,
Jean-Yves Moyen, Alex Ott, Christopher Quinn, Ohad Rodeh, Rauli
Ruohonen, Hendrik Tews, Christophe Troestler, Joseph Sudish, Mattias
Waldau and John Whitley.

Tuareg mode have been maintained by Albert Cohen until version 1.45.

Jane Street took over maintenance based on Albert Cohen's version 1.46
(later retracted by him), and released its first version as 2.0.

Reporting
---------

The official Tuareg home page is located at:
<https://forge.ocamlcore.org/projects/tuareg/>.

Bug reports & patches: use the tracker:
<https://forge.ocamlcore.org/tracker/?group_id=43>.
