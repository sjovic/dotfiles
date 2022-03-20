(add-to-list 'default-frame-alist '(font . "Monoid-10"))
;;(set-fontset-font t 'symbol "Noto Color Emoji")
(set-fontset-font t 'symbol "Dejavu Sans Mono")

(setq sjovic-font-list '(
                         "Monoid-10"
                         "Droid Sans Mono-12"
                         "Hack-12"
                         "Inconsolata-12"
                         "DejaVu Sans Mono-12"
                         "Jetbrains Mono-12"
                         "Anonymous Pro-12"
                         "Ubuntu Mono-14"
                         "Firacode-12"
                         "Inconsolata-14"
                         "Iosevka SS03-12"
                         "Iosevka SS07-12"
                         "Iosevka SS08-12"
                         "Iosevka SS09-12"
                         "Iosevka SS10-12"
                         "Iosevka SS15-12"
                         ))

(defun sjovic/select-font ()
  "test"
  (interactive)
  (let ((font-name (completing-read "Select font: " sjovic-font-list)))
      (when (member font-name (font-family-list)))
      (message (format "selected %s" font-name))
      (set-face-attribute 'default nil :font font-name)))
