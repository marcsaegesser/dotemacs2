;;; init.el --- Personal Emacs configuration
;;; Commentary:
;;;   The structure of this file is based heavily on John Wiegley's
;;;   init.el (https://github.com/jwiegley/dot-emacs)

;;; Code:

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; (setq straight-vc-git-default-protocol 'ssh)
(straight-use-package 'use-package)

;; Set up default font on startup
(use-package emacs
  :config
  (defun mas/config-zenburn ()
    "Update some custom faces in the zenburn theme."
    (interactive)
    (zenburn-with-color-variables
      (custom-theme-set-faces
       'zenburn
       `(macrostep-expansion-highlight-face ((,class (:background ,zenburn-bg+2)) (t :weight bold)) t)
       `(hl-line-face ((,class (:background ,zenburn-bg+1)) (t :weight bold)) t)
       `(hl-line ((,class (:background ,zenburn-bg+1 : extend t)) (t :weight bold)) t)))
    (custom-theme-recalc-face 'hl-line))

  (defconst mas/fixed-pitch-font "Iosevka"
    "The default fixed-pitch typeface.")

  ;; (defconst mas/fixed-pitch-font "JetBrains Mono"
  ;;   "The default fixed-pitch typeface.")

  (defconst mas/fixed-pitch-params ":hintstyle=hintslight"
    "Fontconfig parameters for the fixed-pitch typeface.")

  (defun mas/set-default-font (family size)
    "Set frame font to FAMILY at SIZE."
    (set-frame-font
     (concat family "-" (number-to-string size) mas/fixed-pitch-params) t t))

  (defun mas/set-font-desktop ()
    "Set font for desktop computer"
    (mas/set-default-font mas/fixed-pitch-font 10))

  (defun mas/set-font-docked ()
    "Set font for laptop in docking station with multiple monitors"
    (mas/set-default-font mas/fixed-pitch-font 8))

  (defun mas/set-font-laptop ()
    "Set font for un-docked laptop computer"
    (mas/set-default-font mas/fixed-pitch-font 11))

  (defun mas/start-font ()
    "Set the initial default font. TODO - query system to determine platform."
    (interactive)
    (when (display-graphic-p)
      (if (>= (display-pixel-width) 5760)
          (mas/set-font-docked)
        (mas/set-font-desktop))))

  :hook
  (after-init . mas/start-font)
  )

;; (when (fboundp 'native-compile-async)
;;   (if (yes-or-no-p "async compile?")
;;       (setq comp-async-jobs-number 4 ;; not using all cores
;;             comp-deferred-compilation t
;;             comp-deferred-compilation-black-list '())
;;     (setq comp-deferred-compilation nil)))

;; Preferences
(use-package emacs
  :config
  (setq-default
   auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
   blink-cursor-delay 0
   browse-url-browser-function 'eww-browse-url
   browse-url-generic-program "google-chrome"
   ;; browse-url-browser-function 'browse-url-generic
   c-basic-offset 4
   comp-async-jobs-number 4 ;; not using all cores
   comp-deferred-compilation t
   comp-deferred-compilation-black-list '()
   confirm-kill-processes nil
   create-lockfiles t
   gc-cons-threshold 20000000
   indent-tabs-mode nil
   inhibit-startup-screen t
   inhibit-startup-echo-area-message t
   initial-scratch-message ""
   make-backup-files nil
   mouse-yank-at-point t
   next-screen-context-lines 2
   save-interprogram-paste-before-kill t
   set-mark-command-repeat-pop t
   show-trailing-whitespace t
   tab-width 4
   tooltip-delay 1.5
   truncate-lines t
   truncate-partial-width-windows nil
   use-file-dialog nil
   use-dialog-box nil
   visible-bell nil
   warning-minimum-level :error
   window-combination-resize t
   x-select-enable-clipboard t
   )

  (blink-cursor-mode 0)
  (cua-mode 0)
  (cua-selection-mode t) ; for rectangles, CUA is nice
  (when (display-graphic-p) (fringe-mode 4))
  (menu-bar-mode -1)
  (tool-bar-mode 0)
  (transient-mark-mode t)
  (global-auto-revert-mode t)

  (global-set-key (kbd "RET") 'newline-and-indent)

  ;; To be able to M-x without meta
  (global-set-key (kbd "C-x C-m") 'execute-extended-command)

  ;; More convenient join-line bindings
  (global-set-key (kbd "C-M-S-j") 'join-line)
  (global-set-key (kbd "C-M-j") (lambda () (interactive) (join-line 1)))

  (global-set-key (kbd "C-.") 'set-mark-command)
  (global-set-key (kbd "C-x C-.") 'pop-global-mark)

  ;; Buffer/Frame navigation
  (global-set-key (kbd "C-S-n") 'next-buffer)
  (global-set-key (kbd "C-S-p") 'previous-buffer)
  (global-set-key (kbd "C-M-S-n") 'next-multiframe-window)
  (global-set-key (kbd "C-M-S-p") 'previous-multiframe-window)

  (global-set-key [f9] 'toggle-menu-bar-mode-from-frame)

  (global-set-key (kbd "C-c C-p") 'projectile-command-map)

  ;; Setup greek key bindings
  (global-set-key (kbd "M-g a") "α")
  (global-set-key (kbd "M-g b") "β")
  (global-set-key (kbd "M-g g") "γ")
  (global-set-key (kbd "M-g d") "δ")
  (global-set-key (kbd "M-g e") "ε")
  (global-set-key (kbd "M-g z") "ζ")
  (global-set-key (kbd "M-g h") "η")
  (global-set-key (kbd "M-g q") "θ")
  (global-set-key (kbd "M-g i") "ι")
  (global-set-key (kbd "M-g k") "κ")
  (global-set-key (kbd "M-g l") "λ")
  (global-set-key (kbd "M-g m") "μ")
  (global-set-key (kbd "M-g n") "ν")
  (global-set-key (kbd "M-g x") "ξ")
  (global-set-key (kbd "M-g o") "ο")
  (global-set-key (kbd "M-g p") "π")
  (global-set-key (kbd "M-g r") "ρ")
  (global-set-key (kbd "M-g s") "σ")
  (global-set-key (kbd "M-g t") "τ")
  (global-set-key (kbd "M-g u") "υ")
  (global-set-key (kbd "M-g f") "φ")
  (global-set-key (kbd "M-g j") "φ")
  (global-set-key (kbd "M-g c") "χ")
  (global-set-key (kbd "M-g y") "ψ")
  (global-set-key (kbd "M-g w") "ω")
  (global-set-key (kbd "M-g A") "Α")
  (global-set-key (kbd "M-g B") "Β")
  (global-set-key (kbd "M-g G") "Γ")
  (global-set-key (kbd "M-g D") "Δ")
  (global-set-key (kbd "M-g E") "Ε")
  (global-set-key (kbd "M-g Z") "Ζ")
  (global-set-key (kbd "M-g H") "Η")
  (global-set-key (kbd "M-g Q") "Θ")
  (global-set-key (kbd "M-g I") "Ι")
  (global-set-key (kbd "M-g K") "Κ")
  (global-set-key (kbd "M-g L") "Λ")
  (global-set-key (kbd "M-g M") "Μ")
  (global-set-key (kbd "M-g N") "Ν")
  (global-set-key (kbd "M-g X") "Ξ")
  (global-set-key (kbd "M-g O") "Ο")
  (global-set-key (kbd "M-g P") "Π")
  (global-set-key (kbd "M-g R") "Ρ")
  (global-set-key (kbd "M-g S") "Σ")
  (global-set-key (kbd "M-g T") "Τ")
  (global-set-key (kbd "M-g U") "Υ")
  (global-set-key (kbd "M-g F") "Φ")
  (global-set-key (kbd "M-g J") "Φ")
  (global-set-key (kbd "M-g C") "Χ")
  (global-set-key (kbd "M-g Y") "Ψ")
  (global-set-key (kbd "M-g W") "Ω")

  (unbind-key "M-o")

  ;; don't show trailing whitespace in SQLi, inf-ruby etc.
  (dolist (hook '(term-mode-hook comint-mode-hook compilation-mode-hook))
    (add-hook hook
              (lambda () (setq show-trailing-whitespace nil))))
)

;; Load packages

(use-package dash          :straight t :defer)
(use-package diminish      :straight t :demand t)
(use-package fringe-helper :straight t :defer t)
(use-package s             :straight t :defer)


(use-package alect-themes
  :straight t)

(use-package all-the-icons-ivy-rich
  :straight t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package amx
  :straight t
  :after ivy
  :custom
  (amx-backend 'auto)
  :config
  (amx-mode 1))

(use-package arduino-mode
  :straight t)

(use-package arjen-grey-theme
  :straight t)

(use-package auto-dim-other-buffers
  :straight t
  :disabled t
  :config
  (auto-dim-other-buffers-mode t))

(use-package auto-indent-mode
  :straight t
  :disabled t
  :config
  (auto-indent-global-mode))

(use-package avy
  :straight t
  :init (setq avy-background t)
  :bind (("C-;" . avy-goto-subword-1)
         ("C-:" . avy-goto-word-0)
         ("M-g M-g" . avy-goto-line))
  )

(use-package avy-zap
  :straight t
  :bind (("M-Z" . avy-zap-to-char-dwim)
         ("M-z" . avy-zap-up-to-char-dwim)))

(use-package browse-kill-ring
  :straight t
  :defer 5
  :commands browse-kill-ring)

(use-package color-theme-sanityinc-tomorrow  :straight t :disabled)
(use-package color-theme-sanityinc-solarized :straight t :disabled)

(use-package company
  :straight t
  :defer 5
  :diminish
  :commands (company-mode company-indent-or-complete-common)
  :init
  (dolist (hook '(emacs-lisp-mode-hook
                  haskell-mode-hook
                  c-mode-common-hook))
    (add-hook hook
              #'(lambda ()
                  (local-set-key (kbd "<tab>")
                                 #'company-indent-or-complete-common))))
  :config
  ;; From https://github.com/company-mode/company-mode/issues/87
  ;; See also https://github.com/company-mode/company-mode/issues/123
  (defadvice company-pseudo-tooltip-unless-just-one-frontend
      (around only-show-tooltip-when-invoked activate)
    (when (company-explicit-action-p)
      ad-do-it))

  ;; See http://oremacs.com/2017/12/27/company-numbers/
  (defun ora-company-number ()
    "Forward to `company-complete-number'.
  Unless the number is potentially part of the candidate.
  In that case, insert the number."
    (interactive)
    (let* ((k (this-command-keys))
           (re (concat "^" company-prefix k)))
      (if (cl-find-if (lambda (s) (string-match re s))
                      company-candidates)
          (self-insert-command 1)
        (company-complete-number (string-to-number k)))))

  (let ((map company-active-map))
    (mapc
     (lambda (x)
       (define-key map (format "%d" x) 'ora-company-number))
     (number-sequence 0 9))
    (define-key map " " (lambda ()
                          (interactive)
                          (company-abort)
                          (self-insert-command 1))))

  (defun check-expansion ()
    (save-excursion
      (if (outline-on-heading-p t)
          nil
        (if (looking-at "\\_>") t
          (backward-char 1)
          (if (looking-at "\\.") t
            (backward-char 1)
            (if (looking-at "->") t nil))))))

  (define-key company-mode-map [tab]
    '(menu-item "maybe-company-expand" nil
                :filter (lambda (&optional _)
                          (when (check-expansion)
                            #'company-complete-common))))

  (eval-after-load "yasnippet"
    '(progn
       (defun company-mode/backend-with-yas (backend)
         (if (and (listp backend) (member 'company-yasnippet backend))
             backend
           (append (if (consp backend) backend (list backend))
                   '(:with company-yasnippet))))
       (setq company-backends
             (mapcar #'company-mode/backend-with-yas company-backends))))

  (global-company-mode 1)
  :hook ((term-mode . (lambda () (company-mode -1)))
         (sbt-mode  . (lambda () (company-mode -1)))))

(use-package company-elisp
  :after company
  :config
  (push 'company-elisp company-backends))

(setq-local company-backend '(company-elisp))

(use-package company-ghc
  :straight t
  :after (company ghc)
  :config
  (push 'company-ghc company-backends))

(use-package compile
  :no-require
  :custom
  (compilation-scroll-output 'first-error)
  )

(use-package counsel
  ;; :straight (counsel :type git :host github :repo "abo-abo/swiper"
  ;;                    :fork (:host github :repo "basil-conto/swiper" :branch "blc/flx"))
  :straight t
  :bind
  (("M-x"     . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-x b"   . counsel-switch-buffer))
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (setq projectile-completion-system 'ivy)
  (ivy-mode 1))

(use-package counsel-tramp
  :straight t)

(use-package creamsody-theme
  :straight t)

;; (use-package crux
;;   :straight t
;;   :disabled
;;   :bind (;;("C-c o" . crux-open-with)
;;          ;;("M-o" . crux-smart-open-line)
;;          ;; ("C-c n" . crux-cleanup-buffer-or-region)
;;          ;;("C-c f" . crux-recentf-ido-find-file)
;;          ;;("C-M-z" . crux-indent-defun)
;;          ;;("C-c u" . crux-view-url)
;;          ;;("C-c e" . crux-eval-and-replace)
;;          ;;("C-c w" . crux-swap-windows)
;;          ;;("C-c D" . crux-delete-file-and-buffer)
;;          ;;("C-c r" . crux-rename-buffer-and-file)
;;          ("C-c t" . crux-visit-term-buffer)
;;          ;;("C-c k" . crux-kill-other-buffers)
;;          ;;("C-c TAB" . crux-indent-rigidly-and-copy-to-clipboard)
;;          ;;("C-c I" . crux-find-user-init-file)
;;          ;;("C-c S" . crux-find-shell-init-file)
;;          ;;("s-r" . crux-recentf-ido-find-file)
;;          ;;("s-j" . crux-top-join-line)
;;          ;;("C-^" . crux-top-join-line)
;;          ;;("s-k" . crux-kill-whole-line)
;;          ;;("C-<backspace>" . crux-kill-line-backwards)
;;          ;;("s-o" . crux-smart-open-line-above)
;;          ([remap move-beginning-of-line] . crux-move-beginning-of-line)
;;          ([(shift return)] . crux-smart-open-line)
;;          ;;([(control shift return)] . crux-smart-open-line-above)
;;          ;;([remap kill-whole-line] . crux-kill-whole-line)
;;          ;;("C-c s" . crux-ispell-word-then-abbrev)
;;          ))

(use-package csharp-mode
  :straight t)

(use-package css-mode
  :straight t
  :disabled
  :mode "\\.css\\'")

(use-package dap-mode
  :straight t
  :after lsp-mode
  :config (dap-auto-configure-mode)
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode))

(use-package dap-java
  :straight nil)

(use-package default-text-scale
  :straight t
  :diminish
  :config
  (default-text-scale-mode t))

(use-package delight
  :straight t)

(use-package del-sel
  :no-require
  :config
  (delete-selection-mode 1))

(use-package diff-at-point
  :straight t
  :bind (:map diff-mode-shared-map
              ("<C-M-return>" . diff-at-point-goto-source-and-close))
  :bind (:map prog-mode-map
              ("<C-M-return>" . diff-at-point-open-and-goto-hunk)))

(use-package dired
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches "-AFhlv --group-directories-first")
  (setq dired-dwim-target t)
  :hook ((dired-mode . hl-line-mode)))

(use-package diredfl
  :straight t
  :hook (dired-mode . diredfl-mode))

(use-package dired-sidebar
  :straight t
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :config
  (cond
   ((eq system-type 'darwin)
    (if (display-graphic-p)
        (setq dired-sidebar-theme 'icons)
      (setq dired-sidebar-theme 'nerd))
    (setq dired-sidebar-face '(:family "Helvetica" :height 140)))
   ((eq system-type 'windows-nt)
    (setq dired-sidebar-theme 'nerd)
    (setq dired-sidebar-face '(:family "Lucida Sans Unicode" :height 110)))
   (:default
    (setq dired-sidebar-theme 'nerd)
    (setq dired-sidebar-face '(:family "Iosevka Type" :height 100))))

  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t)

  )
(use-package all-the-icons-dired
    ;; M-x all-the-icons-install-fonts
    :straight t
    :diminish
    :hook (dired-mode . all-the-icons-dired-mode)
    :custom-face
    (all-the-icons-dired-dir-face ((t (:foreground "DarkGrey"))))
    :commands (all-the-icons-dired-mode))

(use-package dired-subtree
  :straight t
  :after dired
  :config
  (setq dired-subtree-use-backgrounds nil)
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("<C-tab>" . dired-subtree-cycle)
              ("<S-iso-lefttab>" . dired-subtree-remove)))

(use-package dired-x
  :after dired
  :config
  (setq dired-clean-up-buffers-too t)
  (setq dired-clean-confirm-killing-deleted-buffers t)
  (setq dired-x-hands-off-my-keys t)
  (setq dired-bind-man nil)
  (setq dired-bind-info nil)

  :bind (("C-x C-j" . dired-jump)
         ("C-x 4 C-j" . dired-jump-other-window)))

(use-package dockerfile-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-mode)))

(use-package eldoc :diminish)

(use-package elfeed
  :straight t
  :config
  (setq elfeed-feeds
        '(("http://nullprogram.com/feed/" blog emacs)
          ("http://feeds.feedburner.com/CafeHayek" blog economics)
          "http://www.50ply.com/atom.xml"  ; no autotagging
          ("http://nedroid.com/feed/" webcomic))))

(use-package eterm-256color
  :straight t
  :hook (term-mode . eterm-256color-mode))

(use-package expand-region
  :straight t
  :bind (("C-=" . er/expand-region)
         ("C-," . er/contract-region)
         ("C-." . er/expand-region)))

(use-package flx
  :straight t)

(use-package flx-ido
  :straight t
  :disabled
  :after ido
  :config
  ;; (setq flx-ido-use-faces t)
  (flx-ido-mode t))

(use-package flatland-theme
  :straight t)

(use-package flycheck
  :straight t
  :config
  (add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.20)))
  :init (global-flycheck-mode))

(use-package flycheck-haskell
  :straight t
  :after haskell-mode
  :config
  (flycheck-haskell-setup))

(use-package flymake-php :straight t)

(use-package flymake-shell
  :straight t
  :hook (sh-set-shell-hook . flymake-shell-load)
  )

(use-package flyspell
  :bind (("C-c i b" . flyspell-buffer)
         ("C-c i f" . flyspell-mode))
  :config
  (defun my-flyspell-maybe-correct-transposition (beg end candidates)
    (unless (let (case-fold-search)
              (string-match "\\`[A-Z0-9]+\\'"
                            (buffer-substring-no-properties beg end)))
      (flyspell-maybe-correct-transposition beg end candidates))))

(use-package foggy-night-theme
  :straight t)

(use-package font-lock-studio
  :straight t)

(use-package git-gutter
  :straight t
  :diminish
  :custom
  (git-gutter:update-interval 2))

(use-package git-gutter-fringe
:straight t
:config
(global-git-gutter-mode t))

(use-package goggles
  :straight t
  :demand t
  :diminish
  :config
  (goggles-mode)
  (setq-default goggles-pulse t)) ;; set to nil to disable pulsing

(use-package go-mode
  :straight t)

(use-package goto-last-change
  :straight t
  :bind ("C-c C-g" . goto-last-change))

(use-package groovy-mode
  :straight t)

(use-package grep
  :no-require
  :custom
  (grep-highlight-matches t)
  (grep-scroll-output t))

(use-package haskell-mode
  :straight t
  :mode (("\\.hs\\(c\\|-boot\\)?\\'" . haskell-mode)
         ("\\.lhs\\'" . literate-haskell-mode)
         ("\\.cabal\\'" . haskell-cabal-mode))
  :bind (:map haskell-mode-map
              ("C-c C-h" . my-haskell-hoogle)
              ("C-c C-," . haskell-navigate-imports)
              ("C-c C-." . haskell-mode-format-imports)
              ("C-c C-u" . my-haskell-insert-undefined)
              ("M-s")
              ("M-t"))
  :preface
  (defun my-haskell-insert-undefined ()
    (interactive) (insert "undefined"))

  (defun snippet (name)
    (interactive "sName: ")
    (find-file (expand-file-name (concat name ".hs") "~/src/notes"))
    (haskell-mode)
    (goto-char (point-min))
    (when (eobp)
      (insert "hdr")
      (yas-expand)))

  (defvar hoogle-server-process nil)
  (defun my-haskell-hoogle (query &optional arg)
    "Do a Hoogle search for QUERY."
    (interactive
     (let ((def (haskell-ident-at-point)))
       (if (and def (symbolp def)) (setq def (symbol-name def)))
       (list (read-string (if def
                              (format "Hoogle query (default %s): " def)
                            "Hoogle query: ")
                          nil nil def)
             current-prefix-arg)))
    (unless (and hoogle-server-process
                 (process-live-p hoogle-server-process))
      (message "Starting local Hoogle server on port 8687...")
      (with-current-buffer (get-buffer-create " *hoogle-web*")
        (cd temporary-file-directory)
        (setq hoogle-server-process
              (start-process "hoogle-web" (current-buffer) "hoogle"
                             "server" "--local" "--port=8687")))
      (message "Starting local Hoogle server on port 8687...done"))
    (browse-url
     (format "http://127.0.0.1:8687/?hoogle=%s"
             (replace-regexp-in-string
              " " "+" (replace-regexp-in-string "\\+" "%2B" query)))))

  (defvar haskell-prettify-symbols-alist
    '(("::"     . ?∷)
      ("forall" . ?∀)
      ("exists" . ?∃)
      ("->"     . ?→)
      ("<-"     . ?←)
      ("=>"     . ?⇒)
      ("~>"     . ?⇝)
      ("<~"     . ?⇜)
      ("<>"     . ?⨂)
      ("msum"   . ?⨁)
      ("\\"     . ?λ)
      ("not"    . ?¬)
      ("&&"     . ?∧)
      ("||"     . ?∨)
      ("/="     . ?≠)
      ("<="     . ?≤)
      (">="     . ?≥)
      ("<<<"    . ?⋘)
      (">>>"    . ?⋙)

      ("`elem`"             . ?∈)
      ("`notElem`"          . ?∉)
      ("`member`"           . ?∈)
      ("`notMember`"        . ?∉)
      ("`union`"            . ?∪)
      ("`intersection`"     . ?∩)
      ("`isSubsetOf`"       . ?⊆)
      ("`isProperSubsetOf`" . ?⊂)
      ("undefined"          . ?⊥)))

  :config
  (require 'haskell)
  (require 'haskell-doc)

  (defun my-haskell-mode-hook ()
    (haskell-indentation-mode)
    (interactive-haskell-mode)
    (diminish 'interactive-haskell-mode)
    (flycheck-mode 1)
    (setq-local prettify-symbols-alist haskell-prettify-symbols-alist)
    (prettify-symbols-mode 1)
    (bug-reference-prog-mode 1))

  (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

  (eval-after-load 'align
    '(nconc
      align-rules-list
      (mapcar #'(lambda (x)
                  `(,(car x)
                    (regexp . ,(cdr x))
                    (modes quote (haskell-mode literate-haskell-mode))))
              '((haskell-types       . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
                (haskell-assignment  . "\\(\\s-+\\)=\\s-+")
                (haskell-arrows      . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
                (haskell-left-arrows . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+"))))))

(use-package highlight-symbol
  :straight t
  :diminish highlight-symbol-mode
  :commands highlight-symbol
  )

(use-package hl-line
  :commands hl-line-mode
  :bind ("M-o h" . hl-line-mode)
  :config (global-hl-line-mode t))

;; (use-package hl-line+
;;   :after hl-line)

(use-package hydra
  :straight t
  :bind (("s-f" . hydra-projectile/body)
         ("C-x t" . hydra-toggle/body)
         ("C-M-o" . hydra-window/body))
  :config
  (hydra-add-font-lock)

  (require 'windmove)

  (defun hydra-move-splitter-left (arg)
    "Move window splitter left."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'right))
        (shrink-window-horizontally arg)
      (enlarge-window-horizontally arg)))

  (defun hydra-move-splitter-right (arg)
    "Move window splitter right."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'right))
        (enlarge-window-horizontally arg)
      (shrink-window-horizontally arg)))

  (defun hydra-move-splitter-up (arg)
    "Move window splitter up."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'up))
        (enlarge-window arg)
      (shrink-window arg)))

  (defun hydra-move-splitter-down (arg)
    "Move window splitter down."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'up))
        (shrink-window arg)
      (enlarge-window arg)))

  (defhydra hydra-toggle (:color teal)
    "
_a_ abbrev-mode:      %`abbrev-mode
_d_ debug-on-error    %`debug-on-error
_f_ auto-fill-mode    %`auto-fill-function
_t_ truncate-lines    %`truncate-lines

"
    ("a" abbrev-mode nil)
    ("d" toggle-debug-on-error nil)
    ("f" auto-fill-mode nil)
    ("t" toggle-truncate-lines nil)
    ("q" nil "cancel"))

  (defhydra hydra-window (:color amaranth)
    "
Move Point^^^^   Move Splitter    ^Split^
-----------------------------------------------------
_w_, _<up>_      Shift + Move     _0_: delete-window
_a_, _<left>_                     _2_: split-window-below
_s_, _<down>_                     _3_: split-window-right
_d_, _<right>_
You can use arrow-keys or WASD.
"
    ("0" delete-window nil)
    ("2" split-window-below nil)
    ("3" split-window-right nil)
    ("a" windmove-left nil)
    ("s" windmove-down nil)
    ("w" windmove-up nil)
    ("d" windmove-right nil)
    ("A" hydra-move-splitter-left nil)
    ("S" hydra-move-splitter-down nil)
    ("W" hydra-move-splitter-up nil)
    ("D" hydra-move-splitter-right nil)
    ("<left>" windmove-left nil)
    ("<down>" windmove-down nil)
    ("<up>" windmove-up nil)
    ("<right>" windmove-right nil)
    ("<S-left>" hydra-move-splitter-left nil)
    ("<S-down>" hydra-move-splitter-down nil)
    ("<S-up>" hydra-move-splitter-up nil)
    ("<S-right>" hydra-move-splitter-right nil)
    ("u" hydra--universal-argument nil)
    ("q" nil "quit"))

  (defhydra hydra-org-template (:color blue :hint nil)
    "
_c_enter  _q_uote     _e_macs-lisp    _L_aTeX:
_l_atex   _E_xample   _p_erl          _i_ndex:
_a_scii   _v_erse     _P_erl tangled  _I_NCLUDE:
_s_rc     ^ ^         plant_u_ml      _H_TML:
_h_tml    ^ ^         ^ ^             _A_SCII:
"
    ("s" (hot-expand "<s"))
    ("E" (hot-expand "<e"))
    ("q" (hot-expand "<q"))
    ("v" (hot-expand "<v"))
    ("c" (hot-expand "<c"))
    ("l" (hot-expand "<l"))
    ("h" (hot-expand "<h"))
    ("a" (hot-expand "<a"))
    ("L" (hot-expand "<L"))
    ("i" (hot-expand "<i"))
    ("e" (progn
           (hot-expand "<s")
           (insert "emacs-lisp")
           (forward-line)))
    ("p" (progn
           (hot-expand "<s")
           (insert "perl")
           (forward-line)))
    ("u" (progn
           (hot-expand "<s")
           (insert "plantuml :file CHANGE.png")
           (forward-line)))
    ("P" (progn
           (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
           (hot-expand "<s")
           (insert "perl")
           (forward-line)))
    ("I" (hot-expand "<I"))
    ("H" (hot-expand "<H"))
    ("A" (hot-expand "<A"))
    ("<" self-insert-command "ins")
    ("o" nil "quit"))

  (defun hot-expand (str)
    "Expand org template."
    (insert str)
    (org-try-structure-completion))

  (with-eval-after-load "org"
    (define-key org-mode-map "<"
      (lambda () (interactive)
        (if (looking-back "^")
            (hydra-org-template/body)
          (self-insert-command 1))))))

(defhydra hydra-projectile (:color blue :columns 4)
  "Projectile"
  ("a" counsel-git-grep "ag")
  ("b" projectile-switch-to-buffer "switch to buffer")
  ("c" projectile-compile-project "compile project")
  ("d" projectile-find-dir "dir")
  ("f" projectile-find-file "file")
  ;; ("ff" projectile-find-file-dwim "file dwim")
  ;; ("fd" projectile-find-file-in-directory "file curr dir")
  ("g" ggtags-update-tags "update gtags")
  ("i" projectile-ibuffer "Ibuffer")
  ("K" projectile-kill-buffers "Kill all buffers")
  ;; ("o" projectile-multi-occur "multi-occur")
  ("p" projectile-switch-project "switch")
  ("r" projectile-run-async-shell-command-in-root "run shell command")
  ("x" projectile-remove-known-project "remove known")
  ("X" projectile-cleanup-known-projects "cleanup non-existing")
  ("z" projectile-cache-current-file "cache current")
  ("q" nil "cancel"))

(use-package hyperbole
  :straight t
  :disabled)

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :init
  (add-hook 'ibuffer-mode-hook
            #'(lambda ()
                (ibuffer-switch-to-saved-filter-groups "default")))
  :config
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))
  (setq ibuffer-formats
        '((mark modified read-only vc-status-mini " "
                (name 18 18 :left :elide)
                " "
                (size-h 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                (vc-status 16 16 :left)
                " "
                filename-and-process)))
  )

(use-package ibuffer-vc
  :straight t
  :after ibuffer
  :commands ibuffer-vc-set-filter-groups-by-vc-root
  :hook (ibuffer . (lambda ()
                     (ibuffer-vc-set-filter-groups-by-vc-root)
                     (unless (eq ibuffer-sorting-mode 'alphabetic)
                       (ibuffer-do-sort-by-alphabetic)))))

(use-package ido
  :disabled
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length 0)
  (setq ido-use-virtual-buffers t)
  (setq ido-default-buffer-method 'selected-window)
  :config
  ;; (setq ido-use-filename-at-point 'guess)
  ;; (setq ido-use-faces nil)
  ;; (setq magit-completing-read-function 'magit-ido-completing-read)
  (ido-mode t)
  (ido-everywhere t))

(use-package ido-vertical-mode
  :disabled
  :straight t
  :init
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  :config
  (ido-vertical-mode t))

(use-package ido-completing-read+
  :disabled
  :straight t
  :config
  (ido-ubiquitous-mode t))

(use-package ivy
  ;; :straight (ivy :type git :host github :repo "abo-abo/swiper"
  ;;                :fork (:host github :repo "basil-conto/swiper" :branch "blc/flx"))
  :straight t
  :demand t
  :diminish
  :custom
  (ivy-wrap nil)
  (ivy-display-style 'fancy)
  :config
  (setq ivy--flx-cache (flx-make-filename-cache))
  ;; (setq ivy-flx-cache 'file)
)

(use-package ivy-avy
  :straight t)

(use-package ivy-posframe
  :straight t
  :diminish
  :custom
  (ivy-posframe-border-width 2)
  :config
  (setq ivy-posframe-display-functions-alist
        '((swiper          . ivy-display-function-fallback)
          (complete-symbol . ivy-posframe-display-at-point)
          (counsel-M-x     . ivy-posframe-display-at-window-bottom-left)
          (t               . ivy-posframe-display)))
  (ivy-posframe-mode 1))

(use-package ivy-rich
  :straight t
  :after ivy
  :config
  (setcdr (assq t ivy-format-functions-alist)
          #'ivy-format-function-line)
  (ivy-rich-mode 1))

(use-package cc-mode
  :init
  (unbind-key "C-c C-p" java-mode-map)
  )

(use-package js2-mode
  :straight t
  :mode "\\.js\\'"
  :config
  (add-to-list 'flycheck-disabled-checkers #'javascript-jshint)
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-mode 1))

(use-package json-mode
  :straight t
  :mode "\\.json\\'")

(use-package json-reformat
  :straight t
  :after json-mode)

(use-package json-snatcher
  :straight t
  :after json-mode)

(use-package keycast
  :straight t
  :after moody
  :config
  (setq keycast-window-predicate 'moody-window-active-p)
  (setq keycast-separator-width 1)
  (setq keycast-insert-after 'mode-line-buffer-identification)
  (setq keycast-remove-tail-elements nil)
  (keycast-mode t))

(use-package key-chord
  :straight t
  :config
  (setq key-chord-two-keys-delay 0.05))

(use-package use-package-chords
  :straight t
  :config (key-chord-mode 1))

(use-package kubernetes
  :straight t
  :commands (kubernetes-overview))

(use-package labburn-theme
  :straight t)

(use-package ligature
  :load-path "~/work/ligature.el"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable common ligatures
  (ligature-set-ligatures 'prog-mode '("=>" "<-" "+++" "!=" "<=" ">="))
  ;; Enable all Cascadia Code ligatures in programming modes
  ;; (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
  ;;                                      ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
  ;;                                      "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
  ;;                                      "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
  ;;                                      "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
  ;;                                      "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
  ;;                                      "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
  ;;                                      "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
  ;;                                      ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
  ;;                                      "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
  ;;                                      "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
  ;;                                      "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
  ;;                                      "\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package yasnippet
  :straight t
  :after prog-mode
  :defer 10
  :diminish yas-minor-mode
  :bind (("C-c y d"   . yas-load-directory)
         ("C-c y i"   . yas-insert-snippet)
         ("C-c y f"   . yas-visit-snippet-file)
         ("C-c y n"   . yas-new-snippet)
         ("C-c y t"   . yas-tryout-snippet)
         ("C-c y l"   . yas-describe-tables)
         ("C-c y g"   . yas-global-mode)
         ("C-c y m"   . yas-minor-mode)
         ("C-c y a"   . yas-reload-all)
         ("C-c y TAB" . yas-expand)
         ("C-c y x"   . yas-expand))
  :bind (:map yas-keymap
              ("C-i" . yas-next-field-or-maybe-expand))
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :config
  (setq yas-snippet-dirs (append yas-snippet-dirs
                                 '("~/Downloads/interesting-snippets")))
  (yas-global-mode 1))

(use-package lsp-java
  :straight t
  :custom
  (lsp-java-project-import-on-first-time-startup "interactive")
  :config
  (add-hook 'java-mode-hook 'lsp))

(use-package lsp-metals
  :straight t
  ;; :config (setq lsp-metals-treeview-show-when-views-received t)
  )

(use-package lsp-mode
  :straight t
  :hook
  ((lsp-mode . lsp-enable-which-key-integration)
   (lsp-mode . lsp-lens-mode)
   (scala-mode . lsp))
  :custom
  (lsp-headerline-breadcrumb-enable nil)
  :config
  (setq lsp-file-watch-threshold 1000
        lsp-enable-indentation nil
        lsp-headerline-breadcrumb-enable nil))

(use-package lsp-treemacs
  :straight t
  ;; :config
  ;; (lsp-metals-treeview-enable t)
  ;; (setq lsp-metals-treeview-show-when-views-received t)
  :commands lsp-treemacs-errors-list)

(use-package lsp-ui
  :straight t)

(use-package company-lsp
  :straight t)

(use-package lua-mode
  :straight t
  :mode "\\.lua\\'"
  :interpreter "lua")

(use-package macrostep
  :straight t
  :bind ("C-c e" . macrostep-expand))

(use-package magit
  :straight t
  :bind ("M-<f12>" . 'magit-status)
  :hook (magit-mode . hl-line-mode)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  )

(use-package markdown-mode
  :straight t
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode))
  :init (setq markdown-command "pandoc -t  html5"))

(use-package markdown-preview-mode
  :straight t
  :after markdown-mode
  :config
  (setq markdown-preview-stylesheets
        (list (concat "https://github.com/dmarcotte/github-markdown-preview/"
                      "blob/master/data/css/github.css"))))

(use-package material-theme
  :straight t)

(use-package memory-usage
  :straight t
  :commands memory-usage)

(use-package mic-paren
  :straight t
  :defer 5
  :config
  (paren-activate))

(use-package mmm-mode
  :straight t
  :defer t
  :config
  (setq mmm-global-mode 'buffers-with-submode-classes)
  (setq mmm-submode-decoration-level 2))

(use-package modus-operandi-theme
  :straight t
  :init
  (setq modus-operandi-theme-slanted-constructs t
           modus-operandi-theme-bold-constructs t
           modus-operandi-theme-fringes 'subtle ; {nil,'subtle,'intense}
           modus-operandi-theme-mode-line '3d ; {nil,'3d,'moody}
           modus-operandi-theme-faint-syntax t
           modus-operandi-theme-intense-hl-line nil
           modus-operandi-theme-intense-paren-match t
           modus-operandi-theme-no-link-underline t
           modus-operandi-theme-prompts 'subtle ; {nil,'subtle,'intense}
           modus-operandi-theme-completions 'moderate ; {nil,'moderate,'opinionated}
           modus-operandi-theme-diffs nil ; {nil,'desaturated,'fg-only}
           modus-operandi-theme-org-blocks 'greyscale ; {nil,'greyscale,'rainbow}
           modus-operandi-theme-headings  ; Read further below in the manual for this one
           '((1 . line)
             (t . rainbow-line-no-bold))
           modus-operandi-theme-variable-pitch-headings t
           modus-operandi-theme-scale-headings t
           modus-operandi-theme-scale-1 1.1
           modus-operandi-theme-scale-2 1.15
           modus-operandi-theme-scale-3 1.21
           modus-operandi-theme-scale-4 1.27
           modus-operandi-theme-scale-5 1.33))

(use-package modus-vivendi-theme
  :straight t
  :init
  (setq modus-vivendi-theme-slanted-constructs t
           modus-vivendi-theme-bold-constructs t
           modus-vivendi-theme-fringes 'subtle ; {nil,'subtle,'intense}
           modus-vivendi-theme-mode-line '3d ; {nil,'3d,'moody}
           modus-vivendi-theme-faint-syntax t
           modus-vivendi-theme-intense-hl-line nil
           modus-vivendi-theme-intense-paren-match t
           modus-vivendi-theme-no-link-underline t
           modus-vivendi-theme-prompts 'subtle ; {nil,'subtle,'intense}
           modus-vivendi-theme-completions 'moderate ; {nil,'moderate,'opinionated}
           modus-vivendi-theme-diffs nil ; {nil,'desaturated,'fg-only}
           modus-vivendi-theme-org-blocks 'greyscale ; {nil,'greyscale,'rainbow}
           modus-vivendi-theme-headings  ; Read further below in the manual for this one
           '((1 . line)
             (t . rainbow-line-no-bold))
           modus-vivendi-theme-variable-pitch-headings t
           modus-vivendi-theme-scale-headings t
           modus-vivendi-theme-scale-1 1.1
           modus-vivendi-theme-scale-2 1.15
           modus-vivendi-theme-scale-3 1.21
           modus-vivendi-theme-scale-4 1.27
           modus-vivendi-theme-scale-5 1.33))

(use-package moody
  :straight t)

(use-package move-text
  :straight t
  :bind (("M-<up>" . move-text-up)
         ("M-<down>" . move-text-down)))

(use-package multiple-cursors
  :straight t
  :bind
  (("C-<"     . mc/mark-previous-like-this)
   ("C->"     . mc/mark-next-like-this)
   ("C-+"     . mc/mark-next-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-c m r" . set-rectangular-region-anchor)
   ("C-c m c" . mc/edit-lines)
   ("C-c m e" . mc/edit-ends-of-lines)
   ("C-c m a" . mc/edit-beginnings-of-lines)))

(use-package multi-term
  :straight t
  :bind (("C-c t" . multi-term-next)
         ("C-c T" . multi-term))
  :init
  (defun screen ()
    (interactive)
    (let (term-buffer)
      ;; Set buffer.
      (setq term-buffer
            (let ((multi-term-program (executable-find "screen"))
                  (multi-term-program-switches "-DR"))
              (multi-term-get-buffer)))
      (set-buffer term-buffer)
      (multi-term-internal)
      (switch-to-buffer term-buffer)))
  :custom
  (multi-term-scroll-to-bottom-on-output 'others) ; Experiment, was nil. mas-2/18/2018
  :config
  (require 'term)

  (defalias 'my-term-send-raw-at-prompt 'term-send-raw)

  (defun my-term-end-of-buffer ()
    (interactive)
    (call-interactively #'end-of-buffer)
    (if (and (eobp) (bolp))
        (delete-char -1)))

  (defadvice term-process-pager (after term-process-rebind-keys activate)
    (define-key term-pager-break-map  "\177" 'term-pager-back-page)))

(use-package n4js
  :straight t)

(use-package nhexl-mode
  :straight t)

(use-package nix-mode
  :straight t)

(use-package nxml-mode
  :commands nxml-mode
  :bind (:map nxml-mode-map
              ("<return>" . newline-and-indent)
              ("C-c M-h"  . tidy-xml-buffer))
  :preface
  (defun tidy-xml-buffer ()
    (interactive)
    (save-excursion
      (call-process-region (point-min) (point-max) "tidy" t t nil
                           "-xml" "-i" "-wrap" "0" "-omit" "-q" "-utf8")))
  :init
  (defalias 'xml-mode 'nxml-mode)
  :config
  (setq nxml-child-indent 4
        nxml-attribute-indent 4)
  (autoload 'sgml-skip-tag-forward "sgml-mode")
  (add-to-list 'hs-special-modes-alist
               '(nxml-mode
                 "<!--\\|<[^/>]*[^/]>"
                 "-->\\|</[^/>]*[^/]>"
                 "<!--"
                 sgml-skip-tag-forward
                 nil)))

(use-package org
  :init
  (setq org-src-fontify-natively t)
  :bind
  (("C-c c" . org-capture))
  :config
  (setq org-default-notes-file "~/Document/org/notes.org"
        org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("j" "Journal" entry (file+olp+datetree "~/org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a"))))

(use-package org-bullets
  :straight t
  :hook (org-mode . org-bullets-mode))

(use-package org-superstar
  :straight t
  ;disabled
  :after org
  :config
  (setq org-superstar-remove-leading-stars t)
  (setq org-superstar-headline-bullets-list
        '("🞛" "◉" "○" "▷"))
  (setq org-superstar-item-bullet-alist
        '((?+ . ?•)
          (?* . ?➤)
          (?- . ?–))))

(use-package org-tree-slide
  :straight t
  :after org
  :commands prot/org-presentation-mode
  :config
  (setq org-tree-slide-breadcrumbs nil)
  (setq org-tree-slide-header nil)
  (setq org-tree-slide-slide-in-effect nil)
  (setq org-tree-slide-heading-emphasis nil)
  (setq org-tree-slide-cursor-init t)
  (setq org-tree-slide-modeline-display nil)
  (setq org-tree-slide-skip-done nil)
  (setq org-tree-slide-skip-comments t)
  (setq org-tree-slide-fold-subtrees-skipped t)
  (setq org-tree-slide-skip-outline-level 8)
  (setq org-tree-slide-never-touch-face t)
  (setq org-tree-slide-activate-message
        (propertize "Presentation mode ON" 'face 'success))
  (setq org-tree-slide-deactivate-message
        (propertize "Presentation mode OFF" 'face 'error))

  (define-minor-mode prot/org-presentation-mode
    "Parameters for plain text presentations with `org-mode'."
    :init-value nil
    :global nil
    (if prot/org-presentation-mode
        (progn
          (unless (eq major-mode 'org-mode)
            (user-error "Not in an Org buffer"))
          (org-tree-slide-mode 1)
          (prot/olivetti-mode 1)
          (org-superstar-mode 1)
          (org-indent-mode 1))
      (org-tree-slide-mode -1)
      (prot/olivetti-mode -1)
      (org-superstar-mode -1)
      (org-indent-mode -1)))

  :bind (("C-c P" . prot/org-presentation-mode)
         :map org-tree-slide-mode-map
         ("<C-down>" . org-tree-slide-display-header-toggle)
         ("<C-right>" . org-tree-slide-move-next-tree)
         ("<C-left>" . org-tree-slide-move-previous-tree)))

(use-package org-brain
  :straight t
  :after org
  :init
  (setq org-brain-path "Documents/org/brain")
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12))

(use-package origami
  :straight t
  :commands origami-mode
  :hook (prog-mode . origami-mode)
  :bind
  (("C-c o t" . origami-toggle-node)
   ("C-c o T" . origami-recursively-toggle-node)
   ("C-c o o" . origami-open-node)
   ("C-c o O" . origami-open-node-recursively)
   ("C-c o c" . origami-close-node)
   ("C-c o C" . origami-close-node-recursively)
   ("C-c o n" . origami-forward-fold)
   ("C-c o p" . origami-previous-fold)
   ("C-c o R" . origami-reset)))

(use-package page-break-lines
  :straight t
  :diminish
  :config
  (global-page-break-lines-mode))

(use-package personal
  :defer t
  :bind (([remap open-line] . sanityinc/open-line-with-reindent))
)

(use-package php-mode
  :straight t
  :hook (flymake-php-load)
  )

(use-package posframe
  :straight t
  :demand t
  :custom
  (posframe-mouse-banish t)
  )

(use-package projectile
  :straight t
  :diminish
  ;; :bind-keymap   ;; Moved to global key binding - Is there a better way?
  ;; ("C-c C-p" . projectile-command-map)
  :config
  (setq
   projectile-globally-ignored-directories (append '(".ensime" ".ensime_cache" "target" "ami-server"))
   projectile-require-project-root t)
  (projectile-mode))

(use-package pointback
  :straight t
  :disabled  ;; Breaks swiper in emacs 27
  :config
  (global-pointback-mode))

(use-package popup-imenu
  :straight t
  :commands popup-imenu
  :bind ("M-i" . popup-imenu))

(use-package python-mode
  :mode "\\.py\\'"
  :interpreter "python"
  :bind (:map python-mode-map
              ("C-c c")
              ("C-c C-z" . python-shell))
  :config
  (defvar python-mode-initialized nil)

  (defun my-python-mode-hook ()
    (unless python-mode-initialized
      (setq python-mode-initialized t)

      (info-lookup-add-help
       :mode 'python-mode
       :regexp "[a-zA-Z_0-9.]+"
       :doc-spec
       '(("(python)Python Module Index" )
         ("(python)Index"
          (lambda
            (item)
            (cond
             ((string-match
               "\\([A-Za-z0-9_]+\\)() (in module \\([A-Za-z0-9_.]+\\))" item)
              (format "%s.%s" (match-string 2 item)
                      (match-string 1 item)))))))))

    (set (make-local-variable 'parens-require-spaces) nil)
    (setq indent-tabs-mode nil))

  (add-hook 'python-mode-hook 'my-python-mode-hook))

(use-package rainbow-blocks
  :straight t)

(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :straight t
  :commands rainbow-mode)

(use-package recentf
  :defer 2 ;;10
  :commands (recentf-mode
             recentf-add-file
             recentf-apply-filename-handlers)
  :preface
  (defun recentf-add-dired-directory ()
    (if (and dired-directory
             (file-directory-p dired-directory)
             (not (string= "/" dired-directory)))
        (let ((last-idx (1- (length dired-directory))))
          (recentf-add-file
           (if (= ?/ (aref dired-directory last-idx))
               (substring dired-directory 0 last-idx)
             dired-directory)))))
  :hook (dired-mode . recentf-add-dired-directory)
  :config
  (recentf-mode 1))

(use-package regex-tool
  :load-path "lisp/regex-tool"
  :commands regex-tool)

(use-package scad-mode
  :straight t)

(use-package scad-preview
  :straight t)

(use-package sbt-mode
  :straight t
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  ;; (setq sbt:program-options '("-Djline.terminal=none"))
  (setq sbt:program-options '("-Dsbt.supershell=false"))
  )

(use-package scala-mode
  :straight t
  :mode "\\.s\\(cala\\|bt\\)$"
 :interpreter ("scala" . scala-mode)
 :bind (:map scala-mode-map
         ("C-<up>"   . scala-syntax:beginning-of-definition)
         ("C-<down>" . scala-syntax:end-of-definition))
  :preface
  (defvar scala-prettify-symbols-alist
    '(("<=" . ?≤)
      (">=" . ?≥)
      ("==" . ?≡)
      ("!" . ?¬)
      ("!=" . ?≢)
      ("msum" . ?⨁)
      ("&&" . ?∧)
      ("||" . ?∨)
      ("true" . ?⊤)
      ("false" . ?⊥)
      ("Int" . ?ℤ)
      ("Boolean" . ?𝔹)
      ("->" . ?→)
      ("<-" . ?←)
      ("=>" . ?⇒)
      ("<=>" . ?⇔)
      ("-->" . ?⟶)
      ("<->" . ?↔)
      ("<--" . ?⟵)
      ("<-->" . ?⟷)
      ("==>" . ?⟹)
      ("<==" . ?⟸)
      ("<==>" . ?⟺)
      ("~>" . ?⇝)
      ("<~" . ?⇜)))
  (defun my-scala-wrap-indented (_1 action _2)
    "Post handler for the wrap ACTION, putting the region on indented newlines."
    (when (eq action 'wrap)
      (sp-get sp-last-wrapped-region
        (let ((beg :beg-in)
              (end :end-in))
          (save-excursion
            (goto-char end)
            (newline-and-indent))
          (indent-region beg end)))))
  (defun my-scala-mode-hook ()
    (setq prettify-symbols-alist scala-prettify-symbols-alist
          indent-tabs-mode nil
          scala-indent:default-run-on-strategy scala-indent:reluctant-strategy)
    (rainbow-delimiters-mode t)
    (smartparens-strict-mode t)
    (highlight-symbol-mode t)
    ;; (prettify-symbols-mode t)
    (sp-local-pair 'scala-mode "{" nil
                   :post-handlers '(("||\n[i]" "RET")
                                    ("| " "SPC")
                                    my-scala-wrap-indented))
    )
  :hook (scala-mode . my-scala-mode-hook))

(use-package scroll-bar
  :config
  (setq-default scroll-margin 3
                scroll-conservatively 10)
  (set-scroll-bar-mode nil))

(use-package server
  :unless noninteractive
  :no-require
  :hook (after-init . server-start))

(use-package shell
  :commands shell-command
  :config
  (setq ansi-color-for-comint-mode t)
;;  (setq shell-command-prompt-show-cwd t) ; Emacs 27.1

  (defun prot/shell-multi ()
    "Spawn a new instance of `shell' and give it a unique name
based on the directory of the current buffer."
    (interactive)
    (let* ((parent (if (buffer-file-name)
                       (file-name-directory (buffer-file-name))
                     default-directory))
           (name (car (last (split-string parent "/" t)))))
      (with-current-buffer (shell)
        (rename-buffer
         (generate-new-buffer-name (concat "*shell: " name "*"))))))
  :bind (("<s-return>" . shell)
         ("<s-S-return>" . prot/shell-multi))
  :hook (shell-mode . ansi-color-for-comint-mode-on))

(use-package slime-theme
  :straight t)

(use-package smart-mode-line
  ;; :straight t
  :straight (smart-mode-line :type git :host github :repo "Malabarba/smart-mode-line"
                             :fork (:host github :repo "marcsaegesser/smart-mode-line" :branch "master"))
  :defer 5
  :config
  ;; See https://github.com/Malabarba/smart-mode-line/issues/217
  (setq sml/-debug t)
  (setq mode-line-format (delq 'mode-line-position mode-line-format))
  (column-number-mode t)
  (sml/setup)
  (sml/apply-theme 'respectful)
  (remove-hook 'display-time-hook 'sml/propertize-time-string))

(use-package smart-mode-line-powerline-theme
  :straight t
  :disabled t
  :after smart-mode-line
  :config
  (sml/apply-theme 'powerline))

;; Borrowed from Sam Halliday but I haven't been able to make this transistion work for me, yet
(use-package smartparens
  :straight t
  :diminish smartparens-mode
  ;; :commands (smartparens-strict-mode
  ;;            smartparens-mode
  ;;            sp-restrict-to-pairs-interactive
  ;;            sp-local-pair)
  :bind (:map smartparens-mode-map
              ("C-M-a" . sp-beginning-of-sexp)
              ("C-M-e" . sp-end-of-sexp)
              ("C-<backspace>" . sp-backward-unwrap-sexp))
  :hook ((smartparens-mode
          . (lambda()
              (unbind-key "C-M-p" smartparens-mode-map)
              (unbind-key "C-M-n" smartparens-mode-map)))
         (prog-mode                   . smartparens-mode)
         ((lisp-mode emacs-lisp-mode) . smartparens-strict-mode))
  :config
  (require 'smartparens-config)
  (defun mas/slurp-scala-nested-types (id action context)
    "When inserting square brackets at a type, slurp the type into brackets.
If the type was already a nested type then slurp the rest of it inside the new brackets."
    (cond ((eq action 'insert)
           (save-excursion
             (let ((sz (length (plist-get (sp-get-pair id) :close))))
               (forward-char sz)
               (when (or (eq (char-syntax (following-char)) ?w)
                         (looking-at (sp--get-opening-regexp)))
                 (backward-char sz)
                 (sp-forward-slurp-sexp)))))
          ((eq action 'slurp-forward)
           (save-excursion
             (let ((sz (length (plist-get (sp-get-pair id) :close))))
               (when (looking-at (sp--get-opening-regexp))
                 (backward-char sz)
                 (sp-forward-slurp-sexp)))))))

  (sp-local-pair 'scala-mode "[" "]" :wrap "C-c [" :post-handlers '(:add mas/slurp-scala-nested-types))

  ;; nice whitespace / indentation when creating statements
  ;; (sp-local-pair '(c-mode java-mode scala-mode) "(" nil :post-handlers '(("||\n[i]" "RET")))
  ;; (sp-local-pair '(c-mode java-mode scala-mode) "{" nil :post-handlers '(("||\n[i]" "RET")))
  ;; (sp-local-pair '(java-mode) "<" nil :post-handlers '(("||\n[i]" "RET")))
  (smartparens-global-mode t))

(use-package smex
  :straight t
  :disabled
  :bind ("M-x" . 'smex))

(use-package smooth-scroll
  :straight t
  :bind
  (("C-u"   . scroll-down)
   ("C-M-n" . scroll-up-1)
   ("C-M-p" . scroll-down-1)))

(use-package smooth-scrolling
  :straight t
  :disabled
  :bind ("C-u" . scroll-down)
  :custom
  (smooth-scroll-margin 2)
  :config
  (smooth-scrolling-mode 1))

(use-package solarized-theme
  :straight t)

(use-package sql-indent
  :straight t
  :commands sqlind-minor-mode)

(use-package sublime-themes
  :straight t)

(use-package swiper
  ;; :straight (swiper :type git :host github :repo "abo-abo/swiper"
  ;;                   :fork (:host github :repo "basil-conto/swiper" :branch "blc/flx"))
  :straight t
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)))

(use-package switch-window
  :straight t
  :config
  (setq switch-window-shortcut-style 'qwerty)
  :custom-face
  (switch-window-label ((t (:height 7.0))))
  :custom
  (switch-window-background t)
  :bind
  (("C-x o" . switch-window)
   ("C-x 9" . switch-window-then-delete)))

(use-package term
  :custom
  (term-scroll-to-bottom-on-output 'this))

(use-package treemacs
  :straight t
  :bind ("C-c r" . treemacs))

(use-package undo-tree
  :straight t
  :diminish
  :config
  (global-undo-tree-mode)
  (setq undo-tree-enable-undo-in-region t))

(use-package unfill
  :straight t)

(use-package unicode-fonts
   :straight t
   :config
   (unicode-fonts-setup))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator " • ")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

;; (use-package vterm
;;   :straight t
;;   )

(use-package volatile-highlights
  :straight t
  :disabled
  :diminish
  :config
  (volatile-highlights-mode t))

(use-package visual-regexp
  :straight t
  :bind (("C-c v r" . vr/replace)
         ("C-c v q" . vr/query-replace)
         ("C-c v m" . vr/mc-mark))
  :config
  (setq vr/match-separator-use-custom-face t))

(use-package vscode-dark-plus-theme
  :straight t)

(use-package whole-line-or-region
  :straight t
  :diminish
  :delight
  :config
  (whole-line-or-region-global-mode))

(use-package wgrep
  :defer 5)

(use-package which-key
  :straight t
  :diminish
  :config (which-key-mode))

(use-package window
  :bind
  (("<f8>" . window-toggle-side-windows))
  :custom
  (display-buffer-alist
   '(("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\|[hH]elp\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . -1)
      (window-parameters . ((no-other-window . t))))
     ("\\*grep\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 0))
     ))
  )

(use-package yaml-mode
  :straight t
  :mode "\\.ya?ml\\'")

(use-package zenburn-theme
  :straight t
  :config
  (zenburn-with-color-variables
    (custom-theme-set-faces
     'zenburn
     `(macrostep-expansion-highlight-face ((,class (:background ,zenburn-bg+2)) (t :weight bold)) t)
     `(hl-line-face ((,class (:background ,zenburn-bg-05)) (t :weight bold)) t)
     `(hl-line ((,class (:background ,zenburn-bg+1 : extend t)) (t :weight bold)) t))))

(use-package zygospore
  :straight t
  :bind ("C-x 1" . zygospore-toggle-delete-other-windows))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(if (custom-theme-enabled-p 'zenburn)
    (mas/config-zenburn))

(provide 'init)
;;; init.el ends here
