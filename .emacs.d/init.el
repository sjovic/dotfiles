(require 'package)
;; (add-to-list 'package-archives '("melpa_stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa_local" . "/media/sjovic/nas/repo/melpa"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package)
  (package-refresh-contents))
;;(setq use-package-always-ensure t)

;; Load all files from my ~/.emacs.d/init directory
;; It doesn't support nested dirs
(dolist
    (file
     (directory-files
      (concat (expand-file-name user-emacs-directory) "init")
      t
      "^.[^#].+el$"))
  (load-file file))

;; (setq message-directory "~/.emacs.d/mail/")
;; (setq nnfolder-directory "~/.emacs.d/mail/archive")
;; (autoload 'notmuch "notmuch" "notmuch mail" t)

;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode)
;;   :config
;;   ;; (setq doom-modeline-height 36)
;;   (setq doom-modeline-buffer-file-name-style 'truncate-all))

(use-package which-key
  :ensure t
  :init (which-key-mode)
  :config
  (setq echo-keystroke 0.5)) ;; which-key pop-up delay

;; (use-package emojify
;;   :defer t)

(use-package default-text-scale
  :ensure t
  :config
  (default-text-scale-mode))

(use-package exec-path-from-shell
  :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
