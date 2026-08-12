(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(setq eglot-autostart t)
(use-package eglot
  :defer t
  :hook ((c-ts-mode cpp-ts-mode  python-ts-mode) . eglot-ensure))

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)               ; 自动弹出补全
  (corfu-auto-delay 0.1)       ; 延迟极低
  (corfu-auto-prefix 2)        ; 输入两个字符就开始补全
  :init
  (global-corfu-mode))

(use-package apheleia
  :config
  (apheleia-global-mode +1))

(provide 'lsp)
