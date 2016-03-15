;;;; Package manager stuff

;; As suggested by the book Mastering Emacs:
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


;;;; Org-mode stuff
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w@)" "VERIFY(v)" "|"
		  "DONE(d!)" "DELEGATED(e@)" "CANCELLED(c@)")))

;; Always display the empty line between headings
(setq org-cycle-separator-lines 1)

;; Capture
(setq org-default-notes-file "~/work/work.org")
(define-key global-map "\C-cc" 'org-capture)


;;; My own keyboard stuff
(defun ce-ins-tilde ()
  "Insert ~ at point."
  (interactive)
  (insert "~"))

(defun ce-ins-caret ()
  "Insert ^ at point."
  (interactive)
  (insert "^"))

(defun ce-ins-day (week-day)
  "Insert a day plan at point."
  (interactive "sEnter day of week: ")
  
  (insert "
**** ")
  (insert week-day)
  (insert "
	  
| Uppgift       | Pomodoros |
|---------------+-----------|
|               |           |
| Avsluta dagen | ()        |

"))


(defun ce-ins-week (week-num)
  "Insert a week plan at point."
  (interactive "sEnter week number: ")
  (insert "
*** Vecka ")
  (insert week-num)
  (insert "

| Dag     | Pomodoros |
|---------+-----------|
| Måndag  |           |
| Tisdag  |           |
| Onsdag  |           |
| Torsdag |           |
| Fredag  |           |
| Totalt  |           |

")
  (ce-ins-day "Måndag")
  (ce-ins-day "Tisdag")
  (ce-ins-day "Onsdag")
  (ce-ins-day "Torsdag")
  (ce-ins-day "Fredag")
  (forward-line -35)
  (forward-char 2))


(show-paren-mode 1)			; Always show matching parens.

;;; Elisp stuff

(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'org-indent-mode)

;; Load paredit
;; (load-file "~/lib/elisp/paredit.el")
;; (autoload 'enable-paredit-mode "paredit"
;;   "Turn on pseudo-structural editing of Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook                  #'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook                        #'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook                        #'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook            #'enable-paredit-mode)
;; (add-hook 'scheme-mode-hook                      #'enable-paredit-mode)

;; Load enfors-lib
(load-file "/home/enfors/devel/elisp/enfors-lib/enfors-lib.el")

(require 'ido)
(ido-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-nick "Enfors")
 '(org-clock-into-drawer t)
 '(org-log-into-drawer t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
