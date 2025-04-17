;; -*- mode: elisp -*-

;; Install packages
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives
	     '("elpa"  . "https://elpa.gnu.org/packages/"))

(package-initialize)
(unless package-archive-contents (package-refresh-contents))

;(unless (package-installed-p 'evil)
;  (package-install 'evil))

(use-package evil
  :ensure t
  :init
  (evil-mode 1)
  :config
  (evil-set-undo-system 'undo-redo))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package corfu
  :ensure t
  :init
  (corfu-mode))

(use-package treemacs
  :ensure t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))

  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (when treemacs-python-executable
    (treemacs-git-commit-diff-mode t))

  (treemacs-resize-icons 14)
  (setq treemacs-wrap-around nil)

  :bind
  (:map global-map
	("M-0" . treemacs-select-window)
	("C-x t 1" . treemacs-delete-other-windows)
	("C-x t t" . treemacs)
	("C-x t d" . treemacs-select-directory)
	("C-x t B" . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t
  :config
  (treemacs-project-follow-mode t))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1))


;; Disable the splash screen (replace t with 0 to enable again)
(setq inhibit-splash-screen t)

;; Theme, font, and UI
(load-theme 'modus-vivendi)
(set-face-attribute 'default nil :height 100)

(tool-bar-mode -1)
(menu-bar-mode -1)


;; Scrolling behavior
(setq scroll-conservatively 101)


;; tab-bar-mode
(global-set-key (kbd "C-h") (lambda () (interactive) (tab-bar-switch-to-next-tab -1)))
(global-set-key (kbd "C-l") (lambda () (interactive) (tab-bar-switch-to-next-tab  1)))

(global-set-key (kbd "C-S-h") (lambda () (interactive) (tab-bar-move-tab -1)))
(global-set-key (kbd "C-S-l") (lambda () (interactive) (tab-bar-move-tab  1)))

(defun tabe()
  "Create a new tab-bar-mode tab"
  (interactive)
  (tab-bar-new-tab)
  (scratch-buffer))

(tab-bar-mode)


;;; Basics
;; Enable transient mark mode
;(transient-mark-mode 1)


;; Org mode
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org/roam"))
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ("C-c n g" . org-roam-graph)
   ("C-c n i" . org-roam-node-insert)
   ("C-c n c" . org-roam-capture)
   ;; Dailies
   ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
  (org-roam-db-autosync-mode))


;; Tabs
(setq-default tab-width 4)


;; Modeline
(column-number-mode t)


;;; Programmming languages
;; C(++)
(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode t
			  c-default-style '"linux")

(add-hook 'c++-mode-hook (lambda () (setq-default display-fill-column-indicator-column 80)
									(display-fill-column-indicator-mode t)
									(font-lock-mode t)))


;; CMake
(use-package cmake-mode
  :ensure t
  :config
  (setq-default cmake-tab-width 4))

;; Protobuf
(use-package protobuf-mode
  :ensure t)

;; P4-16
(load-file "~/.emacs.d/p4_16-mode.el")
(add-to-list 'auto-mode-alist '("\\.p4\\'" . p4_16-mode))

(add-hook 'p4_16-mode (lambda () (setq-default tab-width 4)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cmake-mode corfu org-roam protobuf-mode treemacs-evil
				treemacs-projectile vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
