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
(setq make-backup-files nil)
;; Start in fullscreen
(push '(fullscreen . maximized) default-frame-alist)
;; Disable welcome scren
(setq inhibit-startup-screen t)
;; Autosave
(auto-save-visited-mode 1)
(setq auto-save-visited-interval 1)
;; No bell
(setq ring-bell-function 'ignore)

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

;; Undo
(use-package undo-fu
  :ensure t)

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

					; Utility functions
(defun newline-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line))

(defun newline-below ()
  (interactive)
  (end-of-line)
  (newline))

					; Keybindings
;; Find init.el
(keymap-global-set "C-x c" (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
;; Moving the cursor
(keymap-global-set "M-h" 'left-char)
(keymap-global-set "M-j" 'next-line)
(keymap-global-set "M-k" 'previous-line)
(keymap-global-set "M-l" 'right-char)
;; Start/end of line
(keymap-global-set "M-H" 'beginning-of-line)
(keymap-global-set "M-J" 'forward-paragraph)
(keymap-global-set "M-K" 'backward-paragraph)
(keymap-global-set "M-L" 'end-of-line)
;; Word forward
(keymap-global-set "M-w" 'forward-word)
;; Undo/Redo
(keymap-global-set "C-z" 'undo-fu-only-undo)
(keymap-global-set "C-S-z" 'undo-fu-only-redo)
;; Splits
(keymap-global-set "M-+" 'split-window-horizontally)
(keymap-global-set "M-_" 'split-window-vertically)
;; Navigating windows
(keymap-global-set "C-h" 'windmove-left)
(keymap-global-set "C-j" 'windmove-down)
(keymap-global-set "C-k" 'windmove-up)
(keymap-global-set "C-l" 'windmove-right)
;; Window shit
(define-prefix-command 'window-map)
(keymap-global-set "C-w" 'window-map)
(define-key window-map (kbd "C-w") 'delete-other-windows)
;; Selection
(keymap-global-set "C-v" 'set-mark-command)
;; New line above/below
(keymap-global-set "M-O" 'newline-above)
(keymap-global-set "M-o" 'newline-below)
;; Yank/Paste
(keymap-global-set "C-y" 'kill-ring-save)
(keymap-global-set "C-p" 'yank)
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
   '(afternoon-theme auctex fleury-theme kanagawa-theme kanagawa-themes
		     markdown-mode moody nano-modeline super-save
		     thankful-eyes-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
