(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

; Fix for all native compile warnings
(when (eq system-type 'darwin) (customize-set-variable 'native-comp-driver-options '("-Wl,-w")))
(setq native-comp-async-report-warnings-errors nil)

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(setq confirm-kill-emacs 'y-or-n-p)

(if (display-graphic-p)
    (progn
      (toggle-scroll-bar -1)
      (scroll-bar-mode -1)
      (menu-bar-mode -1)
      (tool-bar-mode 0)
      ))

(delete-selection-mode 1)
(setq inhibit-splash-screen t) ;; no splash screen
(setq initial-scratch-message nil)

;; display column number in mode line
(column-number-mode 1)

(when (memq window-system '(mac ns x))
  (use-package exec-path-from-shell
    :ensure t)
  (exec-path-from-shell-initialize)
  
  (setq ns-right-alternate-modifier nil)
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)

  (setq frame-resize-pixelwise t)
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

  (set-frame-font "Hack Nerd Font Mono 15"))

;; Project support
(require 'project)


(setq custom-file (locate-user-emacs-file "custom.el"))

(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))
(require 'theme) 
(require 'git)

(provide 'init) 
