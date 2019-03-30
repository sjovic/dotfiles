(setq inhibit-startup-message t
      inhibit-splash-screen t
      x-gtk-use-system-tooltips nil
      use-dialog-box nil
      mode-require-final-newline t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)
(column-number-mode 1)
(desktop-save-mode t)
(save-place-mode 1)
;; (savehist-mode 1) ;; save minibuffer history
(show-paren-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-processes nil)
(global-hl-line-mode t)
;; (winner-mode t)
(setq custom-file
      (concat (file-name-directory user-init-file) "custom-variables.el"))
(when (file-exists-p custom-file)
  (load custom-file))
(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(safe-curly-arrow right-curly-arrow))
(fringe-mode 16)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq epa-file-select-keys nil)
(setq epa-pinentry-mode 'loopback)

(defun new-buffer ()
  (interactive)
  (switch-to-buffer (generate-new-buffer "untitled")))

(global-set-key (kbd "<f7>") 'new-buffer)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(put 'downcase-region 'disabled nil)
(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)
