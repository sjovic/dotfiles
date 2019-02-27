(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq js-indent-level 2)
(add-hook 'js-mode-hook
          (lambda ()
            (setq tab-width 2)))
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode))

(use-package flycheck
  :ensure t)

;; (use-package lsp-ui
;;   :ensure t
;;   :after lsp-mode
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :config
;;   (setq lsp-ui-sideline-enable t
;;         lsp-ui-sideline-show-symbol t
;;         lsp-ui-sideline-show-hover t
;;         lsp-ui-sideline-show-code-actions t
;;         lsp-ui-sideline-update-mode 'point))

(use-package company-lsp
  :after company
  :ensure t
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  (setq company-lsp-async t
        company-lsp-cache-candidates 'auto
        company-lsp-enable-recompletion t)
  )

;; (use-package company
;;   :ensure t
;;   :custom
;;   (company-require-match nil)
;;   (company-minimum-prefix-length 1)
;;   (company-idle-delay 0.2)
;;   (company-tooltip-align-annotation t)
;;   (company-frontends '(company-pseudo-tooltip-frontend
;;                        company-echo-metadata-frontend))
;;   :hook ((prog.mode . company-mode))
;;   :bind (:map company-active-map
;;               ("C-n" . company-select-next)
;;               ("C-p" . company-select-previous)))

(use-package lsp-java
  :init
  (add-hook 'java-mode-hook #'lsp))

(use-package lsp-mode
  :ensure t
  ;; :commands lsp
  :hook
  (js-mode . lsp)
  :config
  (setq lsp-prefer-flymake nil))

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
  :ensure t)

(setq highlight-indent-guides-method 'character)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode t))

;;(projectile-mode +1)
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; (use-package dap-mode
;;   :ensure t
;;   :config
;;   (dap-mode 1)
;;   (dap-ui-mode 1))
