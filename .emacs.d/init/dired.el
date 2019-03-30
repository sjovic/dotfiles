;;; -*- lexical-binding: t -*-

;; Install fonts M-x all-the-icons-install-fonts
;; Note: bug https://github.com/domtronn/all-the-icons.el/issues/134
;; Download icons manually to ~/.local/share/fonts 
(use-package all-the-icons
  :ensure t
  :config
  ;; all-the-icons doesn't work without font-lock+
  ;; download https://www.emacswiki.org/emacs/download/font-lock%2b.el to all-the-fonts-../
  (use-package font-lock+
    :config (require 'font-lock+))
  )

(use-package all-the-icons-dired
  :ensure t
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(put 'dired-find-alternate-file 'disabled nil)

(defun dired-sort-dirs-first ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (dired-sort-dirs-first))
