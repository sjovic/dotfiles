;; hide dired details
(defun xah-dired-mode-setup()
  (dired-hide-details-mode 1))
(add-hook 'dired-mode-hook 'xah-dired-mode-setup)

(defun dired-open()
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (call-process "xdg-open" nil 0 nil file)))

(global-set-key (kbd "C-c o") 'dired-open)