(setq inhibit-startup-message t)


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
  (add-hook 'org-mode-hook(lambda () (org-bullets-mode 1))))

(use-package org-mobile-sync
  :ensure t
  :config
  (add-hook 'org-mode-hook(lambda () (org-mobile-sync-mode 1))))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("M-<f5>" . helm-find-files)
	 ([f10] . helm-buffers-list)
	 ([S-f10] . helm-recentf)))

(use-package markdown-mode
  :ensure t)

;; Put custom-set-variables in custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Mobile org
;; Set location of Org files
(setq org-directory "~/org")
;; Set name of file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set dropbox directory
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
