;;;; Package manager stuff

;; As suggested by the book Mastering Emacs:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives
      '(("gnu"       . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa"     . "http://melpa.milkbox.net/packages/")))

;;;; Common lisp
;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;(setq inferior-lisp-program "/home/enfors/ccl/armcl")

;;;; ERC
(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;;;; General emacs stuff
(setq transient-mark-mode t)
(setq sentence-end-double-space nil)	; For filling
(setq next-screen-context-lines   3)

;;;; Faces
(set-face-foreground 'font-lock-string-face        "yellow")
(set-face-foreground 'font-lock-keyword-face       "magenta")
(set-face-foreground 'font-lock-comment-face       "cyan")
(set-face-foreground 'font-lock-variable-name-face "green")

;; This doesn't work for some reason (probably because terminal)
(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)

;; Key for opening journal file
(global-set-key (kbd "C-x j")       '(lambda ()
				       (interactive)
				       (find-file "~/plan/journal.org")
				       (auto-fill-mode)))

;; Switch windows backwards with M-o
(global-set-key (kbd "M-o") (lambda ()
			      (interactive)
			      (other-window -1)))


;; Load enfors-lib
(load-file "~/devel/elisp/enfors-lib/enfors-lib.el")

(require 'enfors-yasnippet-setup)
(require 'enfors-org-setup)
(require 'enfors-emlb-setup)
(require 'enfors-backup-setup)

(require 'ido)
(ido-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-nick "Enfors")
 '(org-clock-into-drawer t)
 '(org-log-into-drawer t)
 '(package-selected-packages (quote (markdown-mode flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
