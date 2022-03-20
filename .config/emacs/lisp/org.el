(setq 
 org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                     (sequence "HOLD(h)" "|" "CANCELLED"))
 org-hide-leading-stars t
 org-pretty-entities t
 org-fontify-whole-heading-line t
 org-hide-emphasis-markers t
 org-log-done 'time
 org-indent-mode nil
 org-ellipsis " ▶")

(setq org-capture-templates
      '(("j" "Journal Entry"
         entry (file+datetree "~/txt/private/journal.org")
         "* %?"
         :empty-lines 1)))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-M-<return>") 'org-insert-subheading)

;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "Droid Serif" :height 120 :weight thin))))
;;  '(fixed-pitch ((t ( :family "Monoid" :height 120 :weight normal)))))

(defface org-checkbox-done-text
  '((t (:foreground "#5a637b")))
  ;;'((t (:strike-through t :foreground "#5a637b")))
  "Face for the text part of a checked org-mode checkbox.")

(font-lock-add-keywords
 'org-mode
 `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
    1 'org-checkbox-done-text prepend))
 'append)

(font-lock-add-keywords
 'org-mode
 '(("^\\**\\(*\\) "
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "●"))))))

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

