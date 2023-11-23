(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa_stable" . "https://stable.melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa_local" . "/media/sjovic/nas/repo/melpa"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)
;;(setq use-package-always-ensure t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line. If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq inhibit-startup-message t
      inhibit-splash-screen t
      x-gtk-use-system-tooltips nil
      use-dialog-box nil
      mode-require-final-newline t)
(global-display-line-numbers-mode t)
(menu-bar-mode -1)
(scroll-bar-mode 0)
(tool-bar-mode -1)
;; (blink-cursor-mode 0)
(column-number-mode 1)
(desktop-save-mode t)
(recentf-mode t)
(save-place-mode 1)
(global-auto-revert-mode 1)
(delete-selection-mode t)
(setq history-length 30)
(savehist-mode 1) ;; save minibuffer history
(show-paren-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-processes nil)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq enable-recursive-minibuffers t)
(global-hl-line-mode t)
;; (winner-mode t)
(setq custom-file
      (concat (file-name-directory user-init-file) "custom-variables.el"))
(when (file-exists-p custom-file)
  (load custom-file))
(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(safe-curly-arrow right-curly-arrow))
(fringe-mode 16)
(setq initial-scratch-message nil)

(add-to-list 'default-frame-alist '(font . "Monoid 11"))
;;(set-fontset-font t 'symbol "Noto Color Emoji")
(set-fontset-font t 'symbol "Dejavu Sans Mono")

(setq default-font-size-pt 10)

(electric-pair-mode 1)
;;(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(setq create-lockfiles nil)
(setq backup-directory-alist
      `((".*" . ,(concat user-emacs-directory "saves"))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq epa-file-select-keys nil)
(setq epa-pinentry-mode 'loopback)

;; (global-visual-line-mode t)
(setq-default word-wrap t)

(autoload 'notmuch "notmuch" "notmuch mail" t)
;; (setq message-directory "~/.emacs.d/mail/")
;; (setq nnfolder-directory "~/.emacs.d/mail/archive")
;; (autoload 'notmuch "notmuch" "notmuch mail" t)

(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(setq enable-recursive-minibuffers t)

(setq
 org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                     (sequence "HOLD(h)" "|" "CANCELLED"))
 org-hide-leading-stars t
 org-pretty-entities t
 org-fontify-whole-heading-line t
 org-hide-emphasis-markers t
 org-log-done 'time
 org-indent-mode nil
 org-ellipsis " >")

(setq org-capture-templates
      '(("j" "Journal Entry"
         entry (file+datetree "~/txt/private/org/journal.org")
         "* %?"
         :empty-lines 1)))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-M-<return>") 'org-insert-subheading)
(global-set-key (kbd "C-x C-r") 'recentf-open)

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


;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "Droid Serif" :height 120 :weight thin))))
;;  '(fixed-pitch ((t ( :family "Monoid" :height 120 :weight normal)))))

;; (defface org-checkbox-done-text
;;   '((t (:foreground "#5a637b")))
;;   ;;'((t (:strike-through t :foreground "#5a637b")))
;;   "Face for the text part of a checked org-mode checkbox.")

(defface org-checkbox-done-text
  '((t (:strike-through t)))
  "Face for the text part of a checked org-mode checkbox.")

;; (font-lock-add-keywords
;;  'org-mode
;;  `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
;;     1 'org-checkbox-done-text prepend))
;;  'append)

;; (add-hook 'org-mode-hook (lambda ()
;;   "Beautify Org Checkbox Symbol"
;;   (push '("[ ]" .  "") prettify-symbols-alist)
;;   (push '("[X]" . "☑" ) prettify-symbols-alist)
;;   (push '("[-]" . "❍" ) prettify-symbols-alist)
;;   (prettify-symbols-mode)))

(font-lock-add-keywords
 'org-mode
 '(("^\\**\\(*\\) "
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "●"))))))

(setq org-indent-mode 't)
(setq org-visual-indent-mode 't)

;; (add-hook 'org-mode-hook (lambda ()
;;   (push '("[ ]" .  "") prettify-symbols-alist)
;;   (push '("[X]" . "" ) prettify-symbols-alist)
;;   (push '("[-]" . "" ) prettify-symbols-alist)
;;   ;; (push '("TODO" . "") prettify-symbols-alist)
;;   ;; (push '("NOW" . "" ) prettify-symbols-alist)
;;   ;; (push '("WAIT" . "" ) prettify-symbols-alist)
;;   ;; (push '("DONE" . "" ) prettify-symbols-alist)
;;   (prettify-symbols-mode)))

(custom-set-faces
 '(org-ellipsis ((t (:underline nil))))
 '(org-level-1 ((t (:inherit outline-1 :weight normal))))
 '(org-level-2 ((t (:inherit outline-2 :weight normal))))
 '(org-level-3 ((t (:inherit outline-3 :weight normal))))
 '(org-level-4 ((t (:inherit outline-4 :weight normal))))
 '(org-level-5 ((t (:inherit outline-5 :weight normal))))
 '(org-level-6 ((t (:inherit outline-6 :weight normal))))
 '(org-level-7 ((t (:inherit outline-7 :weight normal))))
 '(org-level-8 ((t (:inherit outline-8 :weight normal)))))

;; hide dired details
(defun xah-dired-mode-setup()
  (dired-hide-details-mode 1))
(add-hook 'dired-mode-hook 'xah-dired-mode-setup)

(defun dired-open()
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (call-process "xdg-open" nil 0 nil file)))

(global-set-key (kbd "C-c o") 'dired-open)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq js-indent-level 2)
(add-hook 'js-mode-hook
         (lambda ()
           (setq tab-width 2)))
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; (defun dired-sort-dirs-first ()
;;   "Sort dired listings with directories first."
;;   (save-excursion
;;     (let (buffer-read-only)
;;       (forward-line 2) ;; beyond dir. header
;;       (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
;;     (set-buffer-modified-p n33il)))

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (setq echo-keystroke 0.5)) ;; which-key pop-up delay

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package all-the-icons
  :ensure t
  :config
  ;; (use-package all-the-icons-ivy
  ;;   :ensure t
  ;;   :config
  ;;   (all-the-icons-ivy-setup))
  (use-package all-the-icons-dired
    :ensure t
    :hook (dired-mode . all-the-icons-dired-mode)))

;; (use-package vertico
;;   :ensure t
;;   :init
;;   (vertico-mode)
;;   (setq vertico-cycle t))

;; (use-package orderless
;;   :ensure t
;;   :init
;;   (setq completion-styles '(orderless)
;;         completion-category-defaults nil
;;         completion-category-overrides '((file (styles partial-completion)))))

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2))

(use-package diff-hl
  :ensure t
  :hook ((dired-mode . diff-hl-dired-mode))
  :custom (diff-hl-flydiff-delay 0.5)
  :init
  (global-diff-hl-mode t))

;; (use-package highlight-indent-guides
;;   :ensure t
;;   :config
;;   (setq highlight-indent-guides-method 'character))

(use-package editorconfig
  :ensure t
  :commands editorconfig-mode
  :config
  (editorconfig-mode t))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t))

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")

;; (use-package rust-mode
;;   :ensure t
;;   :mode "\\.rs'\\")

(use-package eglot
  :ensure t
  :hook ((js-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (rust-mode . eglot-ensure)))

(use-package company
  :ensure t
;;  :after eglot
  :hook
  (prog-mode . company-mode)
  :config
  (setq company-selection-wrap-around t))

(setq company-minimum-prefix-length 1
      company-idle-delay 0.0) ;; default is 0.2

(setq package-enable-at-startup nil)

(use-package js-comint
  :ensure t)

(fido-mode 1)
(fido-vertical-mode 1)

;; (use-package modus-themes
;;   :ensure t)

;; (load-theme 'modus-operandi)

;; (use-package subatomic-theme
;;   :ensure t)

;; (load-theme 'subatomic)

(server-start)
