;;; plsense-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (plsense-update-current-buffer plsense-delete-all-cache
;;;;;;  plsense-update-location plsense-reopen-current-buffer plsense-delete-help-buffer
;;;;;;  plsense-jump-to-definition plsense-display-help-buffer plsense-popup-help
;;;;;;  plsense-buffer-is-ready plsense-server-task plsense-server-refresh
;;;;;;  plsense-server-stop plsense-server-start plsense-server-status
;;;;;;  plsense-version plsense-config-default plsense-server-sync-trigger-ize
;;;;;;  plsense-setup-current-buffer) "plsense" "plsense.el" (21600
;;;;;;  56417 315732 296000))
;;; Generated autoloads from plsense.el

(autoload 'plsense-setup-current-buffer "plsense" "\
Do setup for using plsense in current buffer.

\(fn)" t nil)

(autoload 'plsense-server-sync-trigger-ize "plsense" "\
Define advice to FUNC for informing changes of current buffer to server.

FUNC is symbol not quoted. e.g. (plsense-server-sync-trigger-ize newline)

\(fn FUNC)" nil t)

(autoload 'plsense-config-default "plsense" "\
Do setting recommemded configuration.

\(fn)" nil nil)

(autoload 'plsense-version "plsense" "\
Show PlSense Version.

\(fn)" t nil)

(autoload 'plsense-server-status "plsense" "\
Show status of server process.

\(fn)" t nil)

(autoload 'plsense-server-start "plsense" "\
Start server process.

\(fn)" t nil)

(autoload 'plsense-server-stop "plsense" "\
Stop server process.

\(fn)" t nil)

(autoload 'plsense-server-refresh "plsense" "\
Refresh server process.

\(fn)" t nil)

(autoload 'plsense-server-task "plsense" "\
Show information of active task on server process.

\(fn)" t nil)

(autoload 'plsense-buffer-is-ready "plsense" "\
Show whether or not plsense is available on current buffer.

\(fn)" t nil)

(autoload 'plsense-popup-help "plsense" "\
Popup help about something at point.

\(fn)" t nil)

(autoload 'plsense-display-help-buffer "plsense" "\
Display help buffer about something at point.

\(fn)" t nil)

(autoload 'plsense-jump-to-definition "plsense" "\
Jump to method definition at point.

\(fn)" t nil)

(autoload 'plsense-delete-help-buffer "plsense" "\
Delete help buffers.

\(fn)" t nil)

(autoload 'plsense-reopen-current-buffer "plsense" "\
Re-open current buffer.

\(fn)" t nil)

(autoload 'plsense-update-location "plsense" "\
Update location of plsense process.

\(fn)" t nil)

(autoload 'plsense-delete-all-cache "plsense" "\
Delete all cache data of plsense.

\(fn)" t nil)

(autoload 'plsense-update-current-buffer "plsense" "\
Request updating about contents of current buffer to server process.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("plsense-pkg.el") (21600 56417 393311
;;;;;;  153000))

;;;***

(provide 'plsense-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; plsense-autoloads.el ends here
