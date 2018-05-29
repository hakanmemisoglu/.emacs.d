;; Melpa sources
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("marmalade" . "https://marmalade-repo.org/packages/")))

;; Package list
(setq my-packages
      '(company
	company-go
	company-rtags
	darcula-theme
	flycheck
	flycheck-rtags
	go-eldoc
	helm
	rtags
	undo-tree
	use-package))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; User interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(display-time-mode t)

;; Theme
(use-package darcula-theme
  :ensure t
  :config
  (set-frame-font "Inconsolata-12")
  )

;; Line numbers
(add-hook 'prog-mode-hook 'linum-mode)

;; Electric pair mode
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; Backup directory
(setq backup-by-copying t)
(setq backup-directory-alist '(("" . "/tmp/saves")))
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 6)
(setq version-control t)
(setq auto-save-default t)

;; Helm mode
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-idle-delay 0.0
	  helm-input-idle-delay 0.0
	  helm-quick-update t)
    (helm-mode))
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini)
	 ("C-x C-b" . helm-mini))
  :bind (:map helm-map
	      ("<tab>" . helm-execute-persistent-action)
	      ("C-i" . helm-execute-persistent-action)
	      ("C-z" . helm-select-action))
  )

;; Flyheck mode
(use-package flycheck
  :ensure t
  :diminish flycheck
  :init
  (progn
    (add-hook 'prog-mode-hook 'flycheck-mode))
  )

;; Undo tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  )

;; Golang mode
(use-package go-mode
  :ensure t
  :init
  (progn
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)

    (use-package go-eldoc
      :ensure t
      :init
      (add-hook 'go-mode-hook 'go-eldoc-setup))
    )
  )


;; Company mode
(use-package company
  :ensure t
  :diminish company
  :config
  (progn
    (global-company-mode)
    (setq company-idle-delay 0.1)
    (setq company-echo-delay 0)
    (setq company-minimum-prefix-length 1)
    (setq company-tooltip-align-annotations t)
    (setq company-tooltip-flip-when-above t)
    (add-hook 'prog-mode-hook 'company-mode)

    (use-package company-go
      :ensure t
      :init
      (add-to-list 'company-backends 'company-go)
      )
    )
  )

;; Rtags (for C/C++)
(use-package rtags
  :ensure t
  :diminish rtags
  :config
  (progn
    (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
    
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t)

    (use-package flycheck-rtags
      :ensure t
      :config
      (progn
	(defun my-flycheck-setup ()
	  (flycheck-select-checker 'rtags))
	(add-hook 'c-mode-hook #'my-flycheck-setup)
	(add-hook 'c++-mode-hook #'my-flycheck-setup))
      )
    (use-package company-rtags
      :ensure t
      :config
      (progn
    	(require 'company)
    	(push 'company-rtags company-backends)
    	))
    )
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (go-eldoc company-go use-package helm flycheck-rtags f company-rtags))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
