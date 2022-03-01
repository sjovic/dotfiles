(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive "^") ; Use (interactive) in Emacs 22 or older
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(global-set-key "\C-a" 'smart-beginning-of-line)


(defun sudo-find-file (file)
  "Open file as root."
  (interactive
   (list (read-file-name "Open as root: ")))
  (find-file (if (file-writable-p file)
                 file (concat "/sudo:root@localhost:" file))))

(defun sjovic/open-recent-file ()
  "Open recent file."
  (interactive)
  (find-file (completing-read "Open recent file: " recentf-list)))

(global-set-key (kbd "C-x C-r") 'sjovic/open-recent-file)


(setq sjovic-font-list '(
                         "Monoid-10"
                         "Droid Sans Mono-12"
                         "Hack-12"
                         "Inconsolata-13"
                         "DejaVu Sans Mono-13"
                         "Jetbrains Mono-13"
                         "Anonymous Pro-14"
                         "Ubuntu Mono-13"
                         "Firacode-12"
                         "Inconsolata-12"
                         ))

(defun sjovic/select-font ()
  "test"
  (interactive)
  (let ((font-name (completing-read "Select font: " sjovic-font-list)))
      (when (member font-name (font-family-list)))
      (message (format "selected %s" font-name))
      (set-face-attribute 'default nil :font font-name)))

(defun fdx/rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-c r") 'fdx/rename-current-buffer-file)

(defun fdx/delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(global-set-key (kbd "C-c d") 'fdx/delete-current-buffer-file)

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

(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)
