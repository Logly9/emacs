;;; lsp.el --- LSP configuration -*- lexical-binding: t -*-

(declare-function eglot-find-typeDefinition "eglot")

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package eglot
  :defer t
  :hook ((c-ts-mode cpp-ts-mode python-ts-mode java-ts-mode) . eglot-ensure)
  :config
  ;; Emacs 30.2 自带 eglot 的 eglot-mode-map 是空的（不预置按键），
  ;; 这里手动补上常用命令的快捷键。
  (define-key eglot-mode-map (kbd "C-c C-a") #'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c C-d") #'eglot-find-declaration)
  (define-key eglot-mode-map (kbd "C-c C-f") #'eglot-format) ; jdtls 格式化
  (define-key eglot-mode-map (kbd "C-c C-o") #'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "C-c C-r") #'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c C-v") #'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c C-x") #'eglot-find-typeDefinition)
  ;; Java: Eclipse JDT Language Server (jdtls)，启动器在 ~/.local/bin/jdtls
  (add-to-list 'eglot-server-programs
               '(java-ts-mode . ("/home/whsb/.local/bin/jdtls"))))

;; --- Java project root detection (Maven/Gradle) ---
;; 让 jdtls 以 pom.xml/build.gradle 所在目录作为工作区根目录
(require 'project)

(defun my-java-project-try (dir)
  "Detect Maven/Gradle/Eclipse project roots for Java buffers."
  (let ((root (or (locate-dominating-file dir "pom.xml")
                  (locate-dominating-file dir "build.gradle")
                  (locate-dominating-file dir "build.gradle.kts")
                  (locate-dominating-file dir "settings.gradle")
                  (locate-dominating-file dir ".project"))))
    (and root (cons 'java root))))

(cl-defmethod project-root ((project (head java)))
  (cdr project))

(add-to-list 'project-find-functions #'my-java-project-try)

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
