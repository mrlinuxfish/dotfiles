;; -*- mode:elisp -*-

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/epla/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Put custom-set-variables in custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;org-mode configuration
;; Enable org-mode
(require 'org)

;; Mobile org
;; Set location of Org files
(setq org-directory "~/org")
;; Set name of file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set dropbox directory
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
