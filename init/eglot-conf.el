;;; eglot.el --- Testing this out
;;; Commentary:
;; 

;;; Code:

(use-package eglot
  :ensure t
  :defer t
  :commands eglot
  :bind (:map eglot-mode-map
              ("C-c C-d" . eldoc)
              ("C-c C-e" . eglot-rename)
              ("C-c C-f" . eglot-format-buffer))
  :hook
  (elixir-mode . eglot-ensure)
  (before-save . eglot-format-buffer)
  (js-mode . eglot-ensure)
  (javascript-mode . eglot-ensure)
  (js-ts-mode . eglot-ensure)
  :config
  (setq-default tab-width 2)
 )



(use-package flymake
    :hook (prog-mode . flymake-mode)
    :bind (:map flymake-mode-map
                ("C-c ! n" . flymake-goto-next-error)
                ("C-c ! p" . flymake-goto-prev-error)
                ("C-c ! l" . flymake-show-buffer-diagnostics)))
      
(use-package flymake-eslint
  :ensure t
  :functions flymake-eslint-enable
  :config
  (setq flymake-eslint-prefer-json-diagnostics t)
  
  (defun lemacs/use-local-eslint ()
    "Set project's `node_modules' binary eslint as first priority.
If nothing is found, keep the default value flymake-eslint set or
your override of `flymake-eslint-executable-name.'"
    (interactive)
    (let* ((root (locate-dominating-file (buffer-file-name) "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/.bin/eslint"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flymake-eslint-executable-name eslint)
        (message (format "Found local ESLINT! Setting: %s" eslint))
        (flymake-eslint-enable))))


  (defun lemacs/configure-eslint-with-flymake ()
	(when (or (eq major-mode 'tsx-ts-mode)
			  (eq major-mode 'typescript-ts-mode)
			  (eq major-mode 'typescriptreact-mode))
      (lemacs/use-local-eslint)))

  (add-hook 'eglot-managed-mode-hook #'lemacs/use-local-eslint)

  ;; With older projects without LSP or if eglot fails
  ;; you can call interactivelly M-x lemacs/use-local-eslint RET
  ;; or add a hook like:
  (add-hook 'js-ts-mode-hook #'lemacs/use-local-eslint))

(provide 'eglot-conf)
;;; eglot-conf.el ends here
