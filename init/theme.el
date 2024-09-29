(use-package gruvbox-theme
  :ensure t)

(use-package solarized-theme
  :ensure t)

(use-package flucui-themes
  :ensure t)

(use-package nord-theme
  :ensure t)

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme 'flucui-light t))
    ('dark (load-theme 'nord t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

(provide 'theme)
