;;;; .emacs

;; Load enfors-lib

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load-file "~/devel/elisp/enfors-lib/dot-emacs.el")

(require 'enfors-yasnippet-setup)
(require 'enfors-org-setup)
(require 'enfors-emlb-setup)
(require 'enfors-backup-setup)

(enfors-set-theme "black")


