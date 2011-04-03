;; (Utilities) ;;

;; CEDET
(if (file-readable-p (expand-file-name "~/.emacs.d/vendor/cedet/common/cedet.elc"))
    (load-file "~/.emacs.d/vendor/cedet/common/cedet.el"))
(when (featurep 'cedet)
  (global-ede-mode 1)
  (semantic-load-enable-minimum-features)
  (semantic-load-enable-code-helpers)
  (semantic-load-enable-gaudy-code-helpers)
  (global-srecode-minor-mode 1))


;; Close all open buffers
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))


;; Show row and column numbers
(setq line-number-mode t)
(setq column-number-mode t)


;; Browsable kill ring
(setq load-path (cons "~/.emacs.d/vendor/browse-kill-ring" load-path))
(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))


;; Support showing line numbers to the left of the code
(setq load-path (cons "~/.emacs.d/vendor/linum" load-path))
(require 'linum)


;; Show trailing whitespace and delete it on save in c- and c++-mode
(setq show-trailing-whitespace t)
(add-hook 'c-mode-common-hook
	  (lambda()
	    (add-hook 'before-save-hook
		      'delete-trailing-whitespace nil t)))
(add-hook 'c++-mode-common-hook
	  (lambda()
	    (add-hook 'before-save-hook
		      'delete-trailing-whitespace nil t)))


;; Magit advanced Git integration
(setq load-path (cons "~/.emacs.d/vendor/magit" load-path))
(require 'magit)


;; Yet Another Snippet extension
(setq load-path (cons "~/.emacs.d/vendor/yasnippet" load-path))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")


;; Enable both HippieCompletion and indent for tab
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (dabbrev-expand nil)
    (indent-for-tab-command)))


;; Tab completion
(let (modelist it)
  (setq modelist '(
		   'c-mode-common-hook
		   'lisp-mode-common-hook
		   'text-mode-hook
		   'java-mode-hook
		   'emacs-lisp-mode-hook
		   'LaTex-mode-hook
		   'Tex-Mode-hook
		   'python-mode-hook
		   'octave-mode-hook))
  (setq it modelist)
  (while it
    (add-hook (eval (car it)) (function
			       (lambda ()
				 (local-set-key (kbd "<tab>") 'indent-or-complete))))
    (add-hook (eval (car it)) (function
			       (lambda ()
				 (local-set-key (kbd "TAB") 'indent-or-complete))))
    (setq it (cdr it))))


;; The order that different completes are tested.
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev-visible
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-expand-all-abbrevs
	try-expand-line))


;; If running on windows load Outlook Edit
(setq load-path (cons "~/.emacs.d/vendor/outlookedit" load-path))
(if (eq system-type 'windows-nt)
    (require 'outlookedit))


;; LustyExplorer
(setq load-path (cons "~/.emacs.d/vendor/lusty-emacs" load-path))
(require 'lusty-explorer)
