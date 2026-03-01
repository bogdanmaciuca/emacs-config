;; TODO:
;; - toggle-term
;; - smart-beginning of line
;; - delete word in minibuffer
;; - word separators for word forward/backward
;; - hook for exiting region (pulse)

					; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

					; General
;; Bars
(menu-bar-mode 0)
(tool-bar-mode -1)
(scroll-bar-mode 0)
;; Font
(set-face-attribute 'default nil :font "SFMono Nerd Font-10")
;; Navigating between windows
(windmove-default-keybindings)
;; No backup files
(setq-default make-backup-files nil)
;; Start in fullscreen
(push '(fullscreen . maximized) default-frame-alist)
;; Disable welcome scren
(setq-default inhibit-startup-screen t)
;; Autosave
(auto-save-visited-mode 1)
(setq-default auto-save-visited-interval 1)
;; No bell
(setq-default ring-bell-function 'ignore)
;; delete-region
(delete-selection-mode t)
;; Tab for autocomplete mini-buffer
(setq-default tab-always-indent 'complete)
;; icomplete
(icomplete-mode t)
(icomplete-vertical-mode t)
;; No wrap
(setq-default truncate-lines t)

					; Packages
;; Theme
(use-package afternoon-theme
  :ensure t
  :config
  (load-theme 'afternoon t))

;; Autosave
(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))

					; Utility functions
(defun newline-above ()
  "Vim O"
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line))

(defun newline-below ()
  "Vim o"
  (interactive)
  (end-of-line)
  (newline))

(defun scroll-up-half-page ()
  (interactive)
  (scroll-up (/ (window-body-height) 2)))

(defun scroll-down-half-page ()
  (interactive)
  (scroll-down (/ (window-body-height) 2)))

(defun select-inside-line ()
  (interactive)
  (end-of-line)
  (set-mark (point))
  (beginning-of-line))

(defun one-char-search-forward ()
  "Vim f"
  (interactive)
  (message "Waiting or a key...")
  (let ((key (read-char)))
    (search-forward (byte-to-string key))))

(defun one-char-search-backward ()
  "Vim F"
  (interactive)
  (message "Waiting or a key...")
  (let ((key (read-char)))
    (search-backward (byte-to-string key))))

(defun comment-line-or-selection ()
  "(Un)Comments the active region if it exists. Otherwise (un)comments the current line"
  (interactive)
  (if (not (region-active-p))
      (select-inside-line))
  (comment-or-uncomment-region (region-beginning) (region-end)))

(defun toggle-term ()
  (interactive))

(defun smart-beginning-of-line ()
  "Moves the cursor to the beginning of the text.
If alreadythere, at the beginning of the line"
  (interactive)
  (let ((old-point (point)))
    (back-to-indentation)
    (if (eq old-point (point))
	(beginning-of-line))))

					; Keybindings
;; Find init.el
(keymap-global-set "C-x c" (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
;; Moving the cursor
(keymap-global-set "M-h" 'left-char)
(keymap-global-set "M-j" 'next-line)
(keymap-global-set "M-k" 'previous-line)
(keymap-global-set "M-l" 'right-char)
;; Start/end of line
(keymap-global-set "M-H" 'smart-beginning-of-line)
(keymap-global-set "M-J" 'forward-paragraph)
(keymap-global-set "M-K" 'backward-paragraph)
(keymap-global-set "M-L" 'end-of-line)
;; Word forward
(keymap-global-set "M-w" 'forward-word)
;; Scrolling a half-page
(keymap-global-set "C-M-j" 'scroll-up-half-page)
(keymap-global-set "C-M-k" 'scroll-down-half-page)
;; Undo/Redo
(keymap-global-set "C-u" 'undo-only)
(keymap-global-set "C-r" 'undo-redo)
;; Splits
(keymap-global-set "M-+" (lambda () (interactive) (split-window-horizontally) (windmove-right)))
(keymap-global-set "M-_" (lambda () (interactive) (split-window-vertically) (windmove-down)))
;; Window shit
(define-prefix-command 'window-map)
(keymap-global-set "C-w" 'window-map)
(define-key window-map (kbd "C-w") 'delete-other-windows)
(define-key window-map (kbd "q") 'delete-window)
(define-key window-map (kbd "h") 'windmove-left)
(define-key window-map (kbd "j") 'windmove-down)
(define-key window-map (kbd "k") 'windmove-up)
(define-key window-map (kbd "l") 'windmove-right)
;; Selection
(keymap-global-set "C-v" 'set-mark-command)
;; New line above/below
(keymap-global-set "M-O" 'newline-above)
(keymap-global-set "M-o" 'newline-below)
;; Yank/Paste
(keymap-global-set "C-y" 'kill-ring-save)
(keymap-global-set "C-p" 'yank)
(keymap-global-set "M-p" 'yank-pop)
;; recenter-top-bottom
(keymap-global-set "C-SPC" 'recenter-top-bottom)
;; Marking
(define-prefix-command 'marking)
(keymap-global-set "M-m" 'marking)
(define-key marking (kbd "w") 'mark-word)
(define-key marking (kbd "l") 'select-inside-line)
(define-key marking (kbd "p") 'mark-paragraph)
;; Searching
(keymap-global-set "C-f" 'isearch-forward)
(keymap-global-set "C-S-f" 'isearch-backward)
(define-key isearch-mode-map (kbd "<return>") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "S-<return>") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "<escape>") 'isearch-exit)
;; One-character searching
(keymap-global-set "M-f" 'one-char-search-forward)
(keymap-global-set "M-F" 'one-char-search-backward)
;; icomplete
(define-key icomplete-minibuffer-map (kbd "<tab>") 'icomplete-forward-completions)
(define-key icomplete-minibuffer-map (kbd "<backtab>") 'icomplete-backward-completions)
(define-key icomplete-minibuffer-map (kbd "RET") (lambda () (interactive) (icomplete-force-complete) (icomplete-ret)))
;; Join line
(keymap-global-set "C-j" (lambda () (interactive) (next-line) (join-line)))
;; Comment region
(keymap-global-set "C-/" 'comment-line-or-selection)
;; Terminal
(keymap-global-set "C-`" 'toggle-term)

					; Misc
;; Pulse after mark is deactivated
(add-hook
 'deactivate-mark-hook
 (lambda () (pulse-momentary-highlight-region (region-beginning) (region-end))))

;; Modeline
(defun my-modified-status ()
  "Returns Saved or Not saved"
  (if (buffer-modified-p)
      (propertize "Not saved" 'face '(:weight bold))
    "Saved    "))

(defun my-buffer-name ()
  "Returns the buffer name, but with `propertize`"
  (propertize (buffer-name) 'face '(:foreground "#c397d8")))

(setq-default mode-line-format
      (list
       " "
       '(:eval (my-modified-status))
       " | "
       '(:eval (my-buffer-name))))


					; Don't touch
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("daa27dcbe26a280a9425ee90dc7458d85bd540482b93e9fa94d4f43327128077"
     "c20728f5c0cb50972b50c929b004a7496d3f2e2ded387bf870f89da25793bb44"
     "d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6"
     "2fa28cb507bb433aac160b2b2ec9d3bcb90bf1d1a1457df36acb092cccde467a"
     default))
 '(package-selected-packages
   '(afternoon-theme auctex fleury-theme gdscript-mode kanagawa-theme
		     kanagawa-themes markdown-mode moody nano-modeline
		     super-save thankful-eyes-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
