;;; init-editor.el --- Basic Editor Settings -*- lexical-binding: t -*-

;; --- 1. 行号设置 ---
(setq display-line-numbers-type 'relative) ; 使用相对行号 (更方便跳转
(global-display-line-numbers-mode t)       ; 全局开启

;; 禁用不需要行号的模式（如 terminal, dashboard 等）
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; --- 2. 缩进设置 (Tab = 2) ---
(setq-default indent-tabs-mode nil) ; 使用空格代替 Tab
(setq-default tab-width 2)          ; Tab 宽度设为 2
(setq-default standard-indent 2)    ; 标准缩进设为 2
(setq-default c-basic-offset 2)     ; C 语言系列缩进 2

;; --- 3. 自动高亮括号与括号匹配 ---
(electric-pair-mode t)              ; 自动补全括号 (Emacs 内置)
(show-paren-mode t)                 ; 高亮匹配的括号

;; --- 4. 文本编码与换行 ---
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq-default fill-column 80)       ; 默认每行 80 字符换行提醒
(global-auto-revert-mode t)         ; 外部修改文件后自动刷新 Buffer

;; --- 5. 搜索与交互 ---
(setq search-highlight t)           ; 搜索高亮
(setq query-replace-highlight t)    ; 替换高亮
(setq isearch-lazy-highlight t)
(setq-default case-fold-search t)   ; 搜索时忽略大小写

;; --- 6. 现代 Emacs 30 建议 ---
(setq use-short-answers t)          ; 将 yes/no 改为 y/n
(setq scroll-step 1                 ; 平滑滚动，每次一行
      scroll-conservatively 10000)
;; 设置 FiraCode Nerd Font，字号 13 (130 = 13pt)
(set-face-attribute 'default nil 
                    :family "Fira Code Nerd Font" 
                    :height 140)

;; 如果你希望所有 Frame（包括新开的窗口）都生效，建议也把字体加入默认列表
(add-to-list 'default-frame-alist '(font . "Fira Code Nerd Font-14"))

;; 开启 which-key 模式
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  ;; 可选：调整弹出等待时间（默认是 1.0 秒，改为 0.5 秒感官更快）
  (setq which-key-idle-delay 0.5))
(provide 'basic)
