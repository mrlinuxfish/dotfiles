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
  :ensure t 
  :config
  (which-key-mode))

(use-package org-bullets
  :ensure t)

(use-package org
  :ensure t
  :config
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

(use-package helm
  :ensure t)
;  :bind (("M-x" . helm-M-x)
;	 ("M-<f5>" . helm-find-files)
;	 ([f10] . helm-buffers-list)
;	 ([S-f10] . helm-recentf)))

(use-package markdown-mode
  :ensure t)

;; Put custom-set-variables in custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Enable ido mode
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Disable annoying 'bell' function.
(setq ring-bell-function 'ignore)

;; Disable startup screen
(setq inhibit-startup-message t)
