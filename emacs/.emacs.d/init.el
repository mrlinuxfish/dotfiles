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
