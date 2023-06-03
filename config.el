;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "dengwww"
      user-mail-address "vinzry@163.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-dracula)
;; (setq doom-theme 'misterioso)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ------- 主题 配置 Start -----------------------------------------------------------------------------
(message "主题配置条件判断, The current computer name is %s" system-name)
(defvar dw-doom-theme 'doom-dracula
  "The default Doom theme.")
;; (setq doom-theme 'misterioso)
(cond
  ;; 自己的 MBA
  ((string-prefix-p "a1" system-name) ;; 以 a1 开头
   (setq dw-doom-theme 'doom-dracula))
  ;; 公司: VD
  ((string-prefix-p "VD" system-name) ;; 以 VD 开头, 公司的 Mac mini
   (setq dw-doom-theme 'misterioso)
    (custom-set-faces! 
      '(region :background "#ff9966"))
    (setq evil-normal-state-cursor '(box "#ff5858") ;; pink
      evil-insert-state-cursor '(bar "#ffffff") ;; white
      evil-visual-state-cursor '(hollow "#FFA500")) ;; orange
   )
  ;; 自己放公司的 HackinTosh: a2
  ((string-prefix-p "a2" system-name) ;; 以 a2 开头
   (setq dw-doom-theme 'doom-dracula))
  ;; ((string-prefix-p "a2" system-name) ;; 以 VD 开头, 公司的 Mac mini
  ;;  (setq dw-doom-theme 'misterioso)
  ;;   (custom-set-faces! 
  ;;     '(region :background "#ff9966"))
  ;;   (custom-set-faces!
  ;;     '(company-tooltip-selection :background "#4CB8C4")) ;; 代码提示的高亮
  ;;   (setq evil-normal-state-cursor '(box "#ff5858") ;; pink
  ;;     evil-insert-state-cursor '(bar "#ffffff") ;; white
  ;;     evil-visual-state-cursor '(hollow "#FFA500")) ;; orange
  ;;  )
  ;; 默认主题
  (t (setq dw-doom-theme 'doom-one))
)
(setq doom-theme dw-doom-theme)
(load-theme dw-doom-theme t)
;; ------- 主题 配置 End -----------------------------------------------------------------------------

;; ------- 开启时屏幕位置/尺寸 配置 Start -----------------------------------------------------------------------------
(set-frame-position (selected-frame) 0 0)
(add-to-list 'initial-frame-alist '(fullscreen . maximized)) ;; 最大化
;; ------- 开启时屏幕位置/尺寸 配置 End -----------------------------------------------------------------------------

;; ------- Flutter 配置 Start -----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages 
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
    ;; Optional packages
    lsp-ui company hover))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

(after! lsp-dart
  (setq lsp-dart-line-length 120)  ;; 一行的最大长度
  (setq-hook! 'dart-mode-hook tab-width 2)  ;; 制表符 2
  (setq-hook! 'dart-mode-hook +format-without-save nil) ;; 保存不自动格式化
)
;; ------- Flutter 配置 End -----------------------------------------------------------------------------

;; ------- git 配置 Start -----------------------------------------------------------------------------
(use-package git-gutter
  :ensure t
  :config
  (progn
    (global-git-gutter-mode)))
;; ------- git 配置 End -----------------------------------------------------------------------------

;; ------- lsp-ui 配置 Start -----------------------------------------------------------------------------
(use-package lsp-ui
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-max-height 150
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 80))
;; ------- lsp-ui 配置 End -----------------------------------------------------------------------------

;; ------- lsp-treemacs 配置 Start -----------------------------------------------------------------------------
;; (lsp-treemacs-sync-mode 1)
;; ------- lsp-treemacs 配置 End -----------------------------------------------------------------------------

;; ------- blamer 配置 Start -----------------------------------------------------------------------------
(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 100
                    :italic t)))
  :config
  (global-blamer-mode 0))
;; ------- blamer 配置 End -----------------------------------------------------------------------------

;; ------- all-the-icons 配置 Start -----------------------------------------------------------------------------
(use-package all-the-icons
  :after memoize
  :load-path "site-lisp/all-the-icons")
;; ------- all-the-icons 配置 End -----------------------------------------------------------------------------

;; ------- 代码 minimap 配置 Start -----------------------------------------------------------------------------
;; (setq
;;   ;; Configure minimap position
;;   minimap-window-location 'right ; Minimap on the right side
;;   minimap-width-fraction 0.0 ; slightly smaller minimap
;;   minimap-minimum-width 20 ; also slightly smaller minimap

;;   minimap-dedicated-window t ; seems to work better
;;   minimap-enlarge-certain-faces nil ; enlarge breaks BlockFont
;; )
;; (minimap-mode 1)
;; ------- 代码 minimap 配置 End -----------------------------------------------------------------------------

;; ------- better-jumper 配置 Start -----------------------------------------------------------------------------
(use-package better-jumper
  :ensure t
  :init
  (better-jumper-mode 1))
;; ------- better-jumper 配置 End -----------------------------------------------------------------------------  

;; ------- 多光标(evil-mc)配置 Start -----------------------------------------------------------------------------
;; (use-package evil-mc
;;   :ensure t
;;   :init
;;   (global-evil-mc-mode 1))
;; ------- evil-mc 配置 End -----------------------------------------------------------------------------

;; ------- helm 配置 Start -----------------------------------------------------------------------------
;; TODO: 描述以后再看，https://github.com/lujun9972/emacs-document/blob/master/emacs-common/我用Helm并且推荐你也用的原因.org
;; (helm-mode)
;; (require 'helm-xref)
;; (define-key global-map [remap find-file] #'helm-find-files)
;; (define-key global-map [remap execute-extended-command] #'helm-M-x)
;; (define-key global-map [remap switch-to-buffer] #'helm-mini)
;; ------- helm 配置 End -----------------------------------------------------------------------------

;; ------- window 缩放(zoom-window)配置 Start -----------------------------------------------------------------------------
;; (use-package zoom-window
;;   :ensure t)
;; (custom-set-variables
;;  '(zoom-window-mode-line-color "DarkGreen"))
;; ------- zoom-window 配置 End -----------------------------------------------------------------------------

;; ------- 字体配置 Start -----------------------------------------------------------------------------
;; (set-frame-font "Menlo 13" nil t)
(setq doom-font (font-spec :family "Hack Nerd Font" :size 14))
;; ------- 字体配置 End -----------------------------------------------------------------------------


