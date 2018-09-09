;;; package --- sumary
;;; Commentary:
;;; Code:
;; Initialize package archives
(require 'package)
(setq load-prefer-newer t
package-enable-at-startup nil)

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
("org" . "http://orgmode.org/elpa/")
("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

;; To load newer version of org
(package-initialize)(require 'package)
;(setq package-enable-at-startup nil)
(add-to-list 'package-archives
'("melpa" . "https://melpa.org/packages/"))
;(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(eval-when-compile (require 'use-package))

(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Always use ':ensure t' for use-package
(setq use-package-always-ensure t)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package async
  :config
  (async-bytecomp-package-mode 1))

(use-package moe-theme
  :config
  (moe-dark)
  (moe-theme-set-color 'green))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; (use-package auto-complete
;; 
;;   :config
;;   (global-auto-complete-mode t))

(use-package popup-complete)

(use-package flyspell)

(use-package flyspell-popup
  :config
  (define-key flyspell-mode-map (kbd"C-;") #'flyspell-popup-correct))

(use-package org-bullets)

(use-package org
  :config
  ;; Use flyspell in org mode
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'flyspell-buffer)
  ;; Turn on org-bullets-mode as minor mode
  (add-hook 'org-mode-hook 'org-bullets-mode)
  ;; Sync mobile org files on open/close of emacs
  (add-hook 'after-init-hook 'org-mobile-pull)
  (add-hook 'kill-emacs-hook 'org-mobile-push)
  ;; Turn on word warp in org mode
  (add-hook 'org-mode-hook 'turn-on-visual-line-mode)
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
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'flyspell-buffer))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-strict-mode t))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
  (global-magit-file-mode t))

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-ledger
  :config
  (eval-after-load 'flycheck '(require 'flycheck-ledger)))

(use-package ledger-mode
  :init
  (setq ledger-clear-whole-transactions 1))

(use-package multiple-cursors
  :config
  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package pkg-info)

(use-package expand-region
  :config
  (require 'expand-region)
  (global-set-key (kbd "C-=") 'er/expand-region)
  (global-set-key (kbd "C-+") 'er/contract-region))

(use-package anzu
  :config
  (global-anzu-mode +1))

(use-package move-text
  :config
  (require 'move-text)
  (move-text-default-bindings))

(use-package flx-ido
  :config
  (require 'flx-ido)
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; allow ido to open files as root
  ;; (defadvice ido-find-file (after find-file-sudo activate)
  ;;   "Find file as root if necessary."
  ;;   (unless (and buffer-file-name
  ;; 		 (file-writable-p buffer-file-name))
  ;;   (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

;; Tablist is required for pdf-tools
(use-package tablist)

(when (eq system-type 'gnu/linux)
  (use-package pdf-tools
    :config
    (pdf-tools-install)
    (setq TeX-view-program-selection '((output-pdf "pdf-tools")))
    (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))))

;; Set emacs font size
(set-face-attribute 'default nil :height 110)

;; Make emacs slightly transparent '(<active> . <inactive>)
(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))

;; Start emacs server
(server-start)

;; Highlight current line
(global-hl-line-mode 1)

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

;; Make doc-view continuous
(setq-default doc-view-continuous t)
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
