					; -*- elisp -*-

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

(use-package try
  :ensure t)

(use-package which-key
  :ensure t)

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
  (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg"))

(use-package markdown-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'flyspell-buffer))

(use-package autopair
  :ensure t
  :config
  (autopair-global-mode t))

(use-package highlight-parentheses
  :ensure t
  :config
  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda ()
      (highlight-parentheses-mode t)))
  (global-highlight-parentheses-mode t))

(use-package moe-theme
  :ensure t
  :config
  (moe-dark)
  (moe-theme-set-color 'green))

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

;; Put custom-set-variables in custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Enable transient mark mode
(transient-mark-mode t)

;; Enable ido mode
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;; Disable annoying 'bell' function.
(setq ring-bell-function 'ignore)

;; Disable startup screen
(setq inhibit-startup-message t)

;; Disable unnecessary ui elements
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

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
