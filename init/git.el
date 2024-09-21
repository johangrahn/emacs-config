(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

(provide 'git) 
