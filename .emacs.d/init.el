(require 'package)
;; (add-to-list 'package-archives '("melpa_stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa_local" . "/media/sjovic/nas/repo/melpa"))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;;(setq use-package-always-ensure t)


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

 (setq inhibit-startup-message t
      inhibit-splash-screen t
      x-gtk-use-system-tooltips nil
      use-dialog-box nil
      mode-require-final-newline t)
(menu-bar-mode -1)
(scroll-bar-mode 0)
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

(setq org-todo-keywords '((sequence "☐" "ON-HOLD" "☑")))
(load-theme 'gruvbox-dark-medium t)

;; (setq message-directory "~/.emacs.d/mail/")
;; (setq nnfolder-directory "~/.emacs.d/mail/archive")
;; (autoload 'notmuch "notmuch" "notmuch mail" t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (setq echo-keystroke 0.5)) ;; which-key pop-up delay

;; (use-package emojify
;;   :defer t)

(add-to-list 'default-frame-alist '(font . "Hack 13"))

(use-package default-text-scale
  :ensure t
  :config
  (default-text-scale-mode))

(global-visual-line-mode t)

(use-package exec-path-from-shell
  :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)

(setq rcirc-server-alist
      '(("irc.freenode.net" :port 6697 :encryption tls
	     :channels ("#haskell" "#emacs" "#emacs-beginners" "#javascript" "#linux", "#networking")))
      rcirc-default-nick "")

(use-package restclient
  :ensure t)

;; (use-package nodejs-repl
;;   :ensure t
;;   :hook
;;   (typescript-mode . nodejs-repl))

;; (defun nvm-which ()
;;   (let* ((shell (concat (getenv "SHELL") " -l -c 'nvm which'"))
;;          (output (shell-command-to-string shell)))
;;     (cadr (split-string output "[\n]+" t))))
;; (setq nodejs-repl-command #'nvm-which)

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

;; (defun dired-sort-dirs-first ()
;;   "Sort dired listings with directories first."
;;   (save-excursion
;;     (let (buffer-read-only)
;;       (forward-line 2) ;; beyond dir. header
;;       (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
;;     (set-buffer-modified-p n33il)))


(use-package counsel
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(use-package counsel-projectile
  :ensure t
  :config
  (setq counsel-projectile-basename-matcher 'counsel--find-file-matcher))

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "
        ivy-extra-directories nil
        ivy-on-del-error-function #'ignore
        ivy-height 20
        ))

(use-package avy
  :ensure t
  :bind (("C-:" . avy-goto-char)
         ("C-;" . avy-goto-char-2)))

;; (use-package eyebrowse
;;   :ensure t
;;   :config
;;   (eyebrowse-mode 1))

;; (windmove-default-keybindings)

(use-package ace-window
  :ensure t
  )

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq js-indent-level 2)
(add-hook 'js-mode-hook
          (lambda ()
            (setq tab-width 2)))
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(use-package typescript-mode
  :ensure t)

(use-package diff-hl
  :ensure t
  :hook ((dired-mode . diff-hl-dired-mode))
  :custom (diff-hl-flydiff-delay 0.5)
  :init
  (global-diff-hl-mode t))

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'character))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode t))

(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (add-to-list 'projectile-globally-ignored-files "node-modules"))
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(use-package yasnippet
  :ensure t)

(use-package eglot
  :ensure t)

(use-package company
  :ensure t
  :after eglot
  :hook
  (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.5)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t))


(add-hook 'typescript-mode-hook 'eglot-ensure)
(add-hook 'js-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'c-common-mode-hook 'eglot-ensure)
(add-hook 'java-mode-hook 'eglot-ensure)
;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   ;; :config
;;   ;; (lsp-ui-doc-enable nil)
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :init
;;   (setq lsp-ui-doc-position 'at-point)
;;   ;; (setq lsp-ui-doc-header nil)
;;   (setq lsp-ui-doc-border "violet")
;;   ;; lsp-ui-doc-include-signature t
;;   (setq lsp-ui-sideline-update-mode 'point)
;;   (setq lsp-ui-sideline-delay 1)
;;   (setq lsp-ui-sideline-ignore-duplicate t)
;;   (setq lsp-ui-peek-always-show t)
;;   (setq lsp-ui-flycheck-enable t))

;; (use-package flycheck
;;   :ensure t)

;; (use-package company-lsp
;;   :after company
;;   :ensure t
;;   :commands company-lsp
;;   :config
;;   (push 'company-lsp company-backends)
;;   (setq company-lsp-async t
;;         company-lsp-cache-candidates 'auto
;;         company-lsp-enable-recompletion t)
;;  )

;; (use-package lsp-mode
;;   :ensure t
;;   ;; :commands lsp
;;   :hook
;;   (js-mode . lsp)
;;   (typescript-mode . lsp) ;; don't use typescript-mode, try add hook to .ts extension
;;   :config
;;   (setq lsp-prefer-flymake nil))


;; (use-package dap-mode
;;   :ensure t
;;   :config
;;   ;; (dap-mode 1)
;;   (dap-ui-mode 1))

;; (require 'dap-node)

;; (use-package lsp-java
;;   :ensure t
;;   :after lsp
;;   :config (add-hook 'java-mode-hook 'lsp))

;; (use-package lsp-java
;;   :init
;;   (add-hook 'java-mode-hook #'lsp))


(server-start)
