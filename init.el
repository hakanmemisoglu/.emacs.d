;; Packages
(package-initialize)
(setq use-package-always-ensure t)

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)

;; Backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      delete-old-versions t
      version-control t
      kept-new-versions 10
      kept-old-versions 5
      vc-make-backup-files t)

;; Fonts
(add-to-list 'default-frame-alist '(font . "Inconsolata"))

;; UI
(tool-bar-mode -1)
(display-time-mode 1)
(scroll-bar-mode -1)

;; Winner mode for layout change
(winner-mode 1)

;; Copy shell variables
(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize)
  )

(use-package projectile
  :config
  (projectile-mode)
  )

(use-package magit
  :bind
  ("C-x g" . magit-status)
  )

;; Linum mode for linenumbers
(use-package linum
  :init
  (add-hook 'prog-mode-hook #'linum-on)
  )

;; Paren mode
(use-package paren
  :init
  (add-hook 'prog-mode-hook #'show-paren-mode)
  (add-hook 'prog-mode-hook #'electric-pair-mode)
  )

;; Theme
(use-package doom-themes
  :init
  (progn
    (require 'doom-themes)
    (setq doom-themes-enable-bold t
	  doom-themes-enable-italic t))
  :config
  (load-theme 'doom-one t)
  )

;; Helm
(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-quick-update t)
    (helm-mode))
  :bind
  (("C-x C-b" . helm-buffers-list)
   ("C-x b" . helm-buffers-list)
   ("C-x C-f" . helm-find-files)
   ("M-x" . helm-M-x)
   (:map helm-map
         ("TAB" . helm-execute-persistent-action)))
  )

(use-package company
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (use-package company-statistics
    :config
    (company-statistics-mode)
    )
  (use-package company-go
    :init
    (add-to-list 'company-backends 'company-go)
    )
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.1)
  (setq company-echo-delay 0)
  )

(use-package flycheck
  :init
  (global-flycheck-mode)
  )

;; Go mode
(use-package go-mode
  :init
  (defun add-save-hook-go ()
    (add-hook 'before-save-hook 'gofmt-before-save nil 'local))
  (setq gofmt-command "goimports")
  (use-package go-eldoc
    :init
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  :hook
  (go-mode . add-save-hook-go)
  )

(use-package go-dlv)

;; Dockerfile
(use-package dockerfile-mode
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package yaml-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile magit exec-path-from-shell go-eldoc flycheck company-go company-statistics company-mode company yaml-mode go-dlv smooth-scrolling linum-mode doom-themes helm use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
