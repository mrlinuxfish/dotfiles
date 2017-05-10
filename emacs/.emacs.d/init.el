;;; package --- sumary
;;; Commentary:
;;; Code:
;; Initialize package archives
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package async
  :ensure t
  :config
  (async-bytecomp-package-mode 1))

(use-package moe-theme
  :ensure t
  :config
  (moe-dark)
  (moe-theme-set-color 'green))

(use-package auto-complete
  :ensure t
  :config
  (global-auto-complete-mode t))

(use-package popup-complete
  :ensure t)

(use-package flyspell
  :ensure t)

(use-package flyspell-popup
  :ensure t
  :config
  (define-key flyspell-mode-map (kbd"C-;") #'flyspell-popup-correct))

(use-package org-bullets
  :ensure t)

(use-package org
  :ensure t
  :config
  ;; Use flyspell in org mode
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'flyspell-buffer)
  ;; Turn on org-bullets-mode as minor mode
  (add-hook 'org-mode-hook 'org-bullets-mode)
  ;; Sync mobile org files on open/close of emacs
  (add-hook 'after-init-hook 'org-mobile-pull)
  (add-hook 'kill-emacs-hook 'org-mobile-push)
  ;; Set locations for mobile org
  (setq org-directory "~/org")
  ;; Location of inbox
  (setq org-mobile-inbox-for-pull "~/org/flagged.org")
  ;; Location of mobile org
  (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
  ;; Fontify code in code blocks (syntax highlighting)
  (setq org-src-fontify-natively t
	org-src-tab-acts-natively t
	org-confirm-babel-evaluate nil
	org-edit-src-content-indentation 0))

(use-package markdown-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'flyspell-buffer))

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-strict-mode t))

(use-package highlight-parentheses
  :ensure t
  :config
  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda ()
      (highlight-parentheses-mode t)))
  (global-highlight-parentheses-mode t))
;; Might switch to rainbow-delimiters as color is customizable

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
  (global-magit-file-mode t))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-ledger
  :ensure t
  :config
  (eval-after-load 'flycheck '(require 'flycheck-ledger)))

(use-package ledger-mode
  :ensure t
  :init
  (setq ledger-clear-whole-transactions 1))

(use-package multiple-cursors
  :ensure t
  :config
  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package pkg-info
  :ensure t)

(use-package expand-region
  :ensure t
  :config
  (require 'expand-region)
  (global-set-key (kbd "C-=") 'er/expand-region)
  (global-set-key (kbd "C-+") 'er/contract-region))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1))

(use-package move-text
  :ensure t
  :config
  (require 'move-text)
  (move-text-default-bindings))

(use-package flx-ido
  :ensure t
  :config
  (require 'flx-ido)
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

;; Make emacs slightly transparent '(<active> . <inactive>)
(set-frame-parameter (selected-frame) 'alpha '(95 . 90))
(add-to-list 'default-frame-alist '(alpha . (95 . 90)))

;; Put custom-set-variables in a temp file
(setq custom-file (make-temp-file ""))

;; Set Abbrev file
(setq abbrev-file-name
      "~/.emacs.d/abbrev_defs")
(if (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))
(setq-default abbrev-mode t)

;; Beautify lambda symbol
(defun my-pretty-lambda ()
  "Make lambda use unicode symbol for lambda in Lisp."
  (setq prettify-symbols-alist
	'(
	  ("lambda" . 995) ; λ
	  )))
(add-hook 'elisp-mode-hook 'my-pretty-lambda)
(global-prettify-symbols-mode 1)

;; Enable transient mark mode
(transient-mark-mode t)

;; Enable ido mode
;; (setq indo-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode t)

;; Disable annoying 'bell' function.
(setq ring-bell-function 'ignore)

;; Turn off double space for sentences
(setq sentence-end-double-space nil)

;; Disable startup screen
(setq inhibit-startup-message t)

;; Disable unnecessary ui elements
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Use y and n inseted of yes and no
(fset 'yes-or-no-p 'y-or-n-p)

;; Set C-RET to insert new line and indent
(global-set-key (kbd "<C-return>") (lambda ()
                   (interactive)
                   (end-of-line)
                   (newline-and-indent)))

;; Set C-S-RET to insert new line above and indent
(global-set-key (kbd "<C-S-return>") (lambda ()
                       (interactive)
                       (forward-line -1)
		       (end-of-line)
                       (newline-and-indent)))
;;; init.el ends here
