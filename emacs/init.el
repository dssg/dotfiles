(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)


                                        ; Enable "package", for installing packages
                                        ; Add some common package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

;; (package-initialize) Not needed in Emacs 27
                                        ; Disable loading package again after init.el
(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(use-package paradox
  :ensure t
  :config
  (paradox-enable)
  (setq paradox-spinner-type 'progress-bar))

(setq display-time-24hr-format t)
(setq display-time-format "%H:%M - %d %B %Y")

(display-time-mode 1)



;; force consistent font height by using the biggest font for spaces:
(global-whitespace-mode t)
(setq whitespace-style '(face tabs spaces trailing empty newline))

;; Click [here](https://github.com/hbin/dotfiles-for-emacs) to take a further look.
;; Hack font: https://sourcefoundry.org/hack/
(set-frame-font "Hack:pixelsize=18")

;; If you use Emacs Daemon mode
(add-to-list 'default-frame-alist
               (cons 'font "Hack:pixelsize=18"))

(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(set-selection-coding-system 'utf-8)

(load-library "iso-transl")

(use-package highlight-symbol
  :ensure t
  :commands highlight-symbol-mode
  :init
  (add-hook 'prog-mode-hook #'highlight-symbol-mode)
  (add-hook 'matlab-mode-hook #'highlight-symbol-mode))
(use-package highlight-parentheses
  :ensure t
  :commands highlight-parentheses-mode
  :init
  (add-hook 'org-mode-hook 'highlight-parentheses-mode)
  (add-hook 'LaTeX-mode-hook 'highlight-parentheses-mode)
  (add-hook 'python-mode-hook 'highlight-parentheses-mode))

(setq-default truncate-lines t)
(add-hook 'prog-mode-hook 'column-number-mode)
(add-hook 'prog-mode-hook 'linum-mode)

(setq initial-scratch-message "")

(defalias 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode -1)

(menu-bar-mode -1)

(unless (frame-parameter nil 'tty)
    (scroll-bar-mode -1))

(setq inhibit-splash-screen t
      ring-bell-function 'ignore)

;; Turn off the blinking cursor
(blink-cursor-mode -1)

(use-package async
  :ensure t
  :init (dired-async-mode 1))

(use-package ag
  :ensure t)

(use-package smartparens
  :ensure t
  :after circe
  :diminish smartparens-mode
  :config

  ;; Activate smartparens globally
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)

  ;; Activate smartparens in minibuffer
  (add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-mode)

  ;; Do not pair simple quotes
  (sp-pair "'" nil :actions :rem)
  (sp-pair "*" nil :actions :rem)
  (sp-pair "_" nil :actions :rem)
  (sp-pair "/" nil :actions :rem)

  ;; smart pairing for all
  (require 'smartparens-config)
  (setq sp-base-key-bindings 'paredit)
  (setq sp-autoskip-closing-pair 'always)
  (setq sp-hybrid-kill-entire-symbol nil)
  (sp-use-paredit-bindings)

  (show-smartparens-global-mode +1)
  )

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'LaTex-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'org-mode-hook #'rainbow-delimiters-mode))

(use-package rainbow-mode
    :ensure t
    :config
    (setq rainbow-x-colors nil)
    (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package all-the-icons
  ;; (use-package all-the-icons-dired
  ;;   :config
  ;;   (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  ;;   )
  ;; (use-package all-the-icons-ivy :ensure t)
  )
(use-package all-the-icons-dired
  ;; M-x all-the-icons-install-fonts
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  :commands (all-the-icons-dired-mode))

(use-package git-gutter+
  :diminish
  :defer t
  :config
  (global-git-gutter+-mode)
  )

(use-package pretty-mode
  :ensure t
  :config
  (global-pretty-mode t)

  ;; (pretty-deactivate-groups
  ;;  '(:equality :ordering :ordering-double :ordering-triple
  ;;              :arrows :arrows-twoheaded :punctuation
  ;;              :logic :sets))

  ;; (pretty-activate-groups
  ;;  '(:sub-and-superscripts :greek :arithmetic-nary :parentheses
  ;;                          :types :arrows-tails  :arrows-tails-double
  ;;                          :logic :sets :equality :ordering
  ;;                          :arrows :arrows-twoheaded ))
  )

(add-hook
 'prog-mode-hook
 (lambda ()
   (setq prettify-symbols-alist
         '(;; Syntax
           ("in" . "∈")
           ("not in" . "∉")
           ("not" .      #x2757)
           ("NOT" .      #x2757)
           ("return" .   #x27fc)
           ("yield" .    #x27fb)
           ("for" . "∀")
           ("function" . ?λ)
           ("<>" . ?≠)
           ("!=" . ?≠)
           ("exists" . ?Ǝ)
           ("in" . ?∈)
           ("sum" . ?Ʃ)
           ("complex numbers" . ?ℂ)
           ("integer numbers" . ?ℤ)
           ("natural numbers" . ?ℕ)
           ("class" . "𝑪")
           ("and" . "∧")
           ("AND" . "∧")
           ("or" . "∨")
           ("OR" . "∨")
           ("not" . "￢")
           ("NOT" . "￢")
           ;; Base Types
           ;; ("int" .      #x2124)
           ;; ("INT" .      #x2124)
           ;; ("float" .    #x211d)
           ;; ("str" .      #x1d54a)
           ("True" .     #x1d54b)
           ("False" .    #x1d53d)
           ("true" .     #x1d54b)
           ("false" .    #x1d53d)
           ("null"  .    #x2205)
           ("NULL"  .    #x2205)
           ("Null"  .    #x2205)
           ;; python
           ;; ("Dict" .     #x1d507)
           ;; ("List" .     #x2112)
           ;; ("Tuple" .    #x2a02)
           ;; ("Set" .      #x2126)
           ;; ("Iterable" . #x1d50a)
           ;; ("Any" .      #x2754)
           ;; ("union" .    #x22c3)
           ;; ("Union" .    #x22c3)
           ))))
      (global-prettify-symbols-mode t)

(use-package recentf
  :init
  (recentf-mode 1)

  :config

  ;;
  (setq
   recentf-max-saved-items 500
   recentf-max-menu-items 15
   ;; disable recentf-cleanup on Emacs start, because it can cause
   ;; problems with remote files
   recentf-auto-cleanup 'never)

  ;; Emacs
  (add-to-list 'recentf-exclude (format "%s/.orhc-bibtex-cache" (getenv "HOME")))
  (add-to-list 'recentf-exclude (format "%s/configuration/emacs\\.d/\\(?!\\(main.org\\)\\)" (getenv "HOME")))
  (add-to-list 'recentf-exclude (format "%s/\\.emacs\\.d/.*" (getenv "HOME")))

  ;; Some caches
  (add-to-list 'recentf-exclude (format "%s/\\.ido\\.last" (getenv "HOME")))
  (add-to-list 'recentf-exclude (format "%s/\\.recentf" (getenv "HOME")))


  ;; Org/todo/calendars
  (add-to-list 'recentf-exclude ".*todo.org")
  (add-to-list 'recentf-exclude (format "%s/Calendars/.*" (getenv "HOME")))

  ;; Maildir
  (add-to-list 'recentf-exclude (format "%s/maildir.*" (getenv "HOME")))

  )

(setq x-select-enable-primary nil)
(setq x-select-enable-clipboard t)

;; Open Large files
(use-package vlf :ensure t)

;; Delete trailing-whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Unify the buffer name style
(eval-after-load "uniquify"
  '(progn
     (setq uniquify-buffer-name-style 'forward)))

(use-package use-package-chords
  :ensure t
  :config
  (key-chord-mode 1))

(use-package wgrep
  :ensure t
  )

(use-package smex
  :ensure t)

(use-package counsel
  :ensure t
  :chords (("yy" . counsel-yank-pop))
  )

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d ")
  ;(setq ivy-initial-inputs-alist nil) ;; By default ivy starts filter with ^, ignoring that
  )


(use-package ivy-hydra
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :after projectile
  :config (counsel-projectile-mode))

(use-package dumb-jump
  :bind (( "M-g o" . dumb-jump-go-other-window)
         ( "M-g j" . dumb-jump-go)
         ( "M-g x" . dumb-jump-go-prefer-external)
         ( "M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
  (setq dumb-jump-selector 'ivy)
  :ensure)

(setq diff-switches "-u")
(autoload 'diff-mode "diff-mode" "Diff major mode" t)
(setq ediff-auto-refine-limit (* 2 14000))
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function (lambda (&optional arg)
                    (if (> (frame-width) 160)
                    (split-window-horizontally arg)
                      (split-window-vertically arg))))

(setq tramp-default-method "ssh")
(setq password-cache-expiry 60)
(setq tramp-auto-save-directory temporary-file-directory)

;; Debug
;;(setq tramp-verbose 9)
(setq tramp-debug-buffer nil)

(use-package material-theme :defer t)
(use-package ubuntu-theme :defer t)
(use-package gotham-theme :defer t)
(use-package django-theme :defer t)
(use-package color-theme-sanityinc-tomorrow :defer t)
(use-package creamsody-theme :defer t)
(use-package monokai-theme :defer t)
(use-package blackboard-theme :defer t)
(use-package bubbleberry-theme :defer t)
(use-package gruvbox-theme
  :disabled t
  :ensure t
  :config (load-theme 'gruvbox-dark-medium t))

(use-package darkokai-theme
  :disabled t
  :ensure t
  :config
  (setq darkokai-mode-line-padding 1)
  (load-theme 'darkokai t))

(use-package moe-theme
  :disabled t
  :ensure t
  :config
  (setq moe-theme-highlight-buffer-id nil)
  (moe-dark))

(use-package dracula-theme
  :disabled t
  :ensure t
  :config
  (load-theme 'dracula t))

(use-package doom-themes
  :ensure t
  :config
  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
  ;; may have their own settings.
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme
  (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )

(use-package avy
  :ensure t
  :bind (("M-s" . avy-goto-word-1))
  )

(use-package ace-window
  :ensure t
  :chords ("jk" . ace-window)
  :bind   ("M-o" . ace-window)
  :config
  (setq aw-dispatch-always 1)
                                        ;(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  )

(use-package switch-window
  :ensure t
  :config
    (setq switch-window-input-style 'minibuffer)
    (setq switch-window-increase 4)
    (setq switch-window-threshold 2)
    (setq switch-window-shortcut-style 'qwerty)
    (setq switch-window-qwerty-shortcuts
        '("a" "s" "d" "f" "j" "k" "l" "i" "o"))
  :bind
    ([remap other-window] . switch-window))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; Aggressive-fill
(use-package aggressive-fill-paragraph
  :ensure t
  :disabled
  :config
  (afp-setup-recommended-hooks)
  ;; to enable the minor mode in all places where it might be useful. Alternatively use
  ;;(add-hook '[major-mode-hook] #'aggressive-fill-paragraph-mode)
  )

;; Aggressive-indent
(use-package aggressive-indent
  :ensure t
  :config
  ;; (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
  (add-hook 'ruby-mode-hook #'aggressive-indent-mode)
  ;(add-hook 'python-mode-hook #'aggresive-indent-mode)
  (add-hook 'css-mode-hook #'aggressive-indent-mode)
  )

;; Edición de múltiples líneas
(use-package multiple-cursors
  :diminish multiple-cursors-mode
  :defer t
  :init
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

(use-package undo-tree  ;; C-x u
  :ensure t
  :chords (("uu . undo-tree-visualize"))
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t))
  )

(use-package company
  :ensure t
  :init
  (global-company-mode 1)
  (add-hook 'prog-mode-hook 'company-mode)
  (add-hook 'LaTeX-mode-hook 'company-mode)
  (add-hook 'org-mode-hook 'company-mode)
  :config
  ;; Enable company mode everywhere
  (add-hook 'after-init-hook 'global-company-mode)
  ;; Set up TAB to manually trigger autocomplete menu
                                        ;(define-key company-mode-map (kbd "TAB") 'company-complete)
                                        ;(define-key company-active-map (kbd "TAB") 'company-complete-common)
  ;; Set up M-h to see the documentation for items on the autocomplete menu
  (define-key company-active-map (kbd "M-h") 'company-show-doc-buffer)

  (setq company-show-numbers t)

  (setq company-idle-delay t)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 3)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)

  )

(use-package yasnippet
  :ensure t
  :after company
  :diminish yas-minor-mode
  :config


  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")

  ;; Adding yasnippet support to company
  (add-to-list 'company-backends '(company-yasnippet))

  ;; Activate global
  (yas-global-mode)

  (global-set-key (kbd "M-/") 'company-yasnippet)
  )

(use-package  yasnippet-snippets
  :ensure t)

(defvar show-paren-delay)
(setq show-paren-delay 0.0)
(show-paren-mode t)

(column-number-mode t)

(use-package fill-column-indicator
  :ensure t
  :config
  (setq fci-rule-column 80)
  (add-hook 'prog-mode-hook 'fci-mode))

(setq backup-directory-alist `((".*" . "/tmp/.emacs"))
      auto-save-file-name-transforms `((".*" , "/tmp/.emacs" t)))

(global-auto-revert-mode t)

(add-hook 'after-save-hook
        'executable-make-buffer-file-executable-if-script-p)

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :init
  (add-hook 'prog-mode-hook 'flycheck-mode)
  :config
  (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-indication-mode nil)
  (setq flycheck-display-errors-delay 1.5)
  (setq flycheck-idle-change-delay 3)
  (setq flycheck-check-syntax-automatically '(mode-enabled save))

  (flycheck-define-checker proselint
    "A linter for prose."
    :command ("proselint" source-inplace)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message) line-end))
    :modes (text-mode markdown-mode gfm-mode))

  (add-to-list 'flycheck-checkers 'proselint))

(use-package flyspell
  :commands flyspell-mode
  :init
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  :config
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)
          ("es_MX" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)))
  (flyspell-mode 1))
(use-package flyspell-correct-ivy
  :ensure t
  :after flyspell
  :bind (:map flyspell-mode-map
              ("C-c C-SPC" . flyspell-correct-word-generic)))

; Point auctex to my central .bib file
(use-package tex
  :ensure auctex
  :config

  ;; Subpackages
  (let ((byte-compile-warnings '(not free-vars)))
    (use-package latex-extra
      :ensure t
      :config
      (add-hook 'LaTeX-mode-hook #'latex-extra-mode)))

  ;; Pdf activated by default
  (TeX-global-PDF-mode 1)

  (setq Tex-auto-save t)
  (setq Tex-parse-self t)
  (setq TeX-save-query nil)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))

  (setq LaTeX-indent-level 4
	LaTeX-item-indent 0
	TeX-brace-indent-level 4
	TeX-newline-function 'newline-and-indent)

  ;; Some usefull hooks
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'outline-minor-mode)

  ;; PDF/Tex correlation
  (setq TeX-source-correlate-method 'synctex)
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

  ;; Keys
  (define-key LaTeX-mode-map (kbd "C-c C-=") 'align-current)

)

(use-package bibtex
  :config
  (defun bibtex-generate-autokey ()
    (let* ((bibtex-autokey-names nil)
           (bibtex-autokey-year-length 2)
           (bibtex-autokey-name-separator "\0")
           (names (split-string (bibtex-autokey-get-names) "\0"))
           (year (bibtex-autokey-get-year))
           (name-char (cond ((= (length names) 1) 4)
                            ((= (length names) 2) 2)
                            (t 1)))
           (existing-keys (bibtex-parse-keys))
           key)
      (setq names (mapconcat (lambda (x)
                               (substring x 0 name-char))
                             names
                             ""))
      (setq key (format "%s%s" names year))
      (let ((ret key))
        (loop for c from ?a to ?z
              while (assoc ret existing-keys)
              do (setq ret (format "%s%c" key c)))
        ret)))

  (setq bibtex-align-at-equal-sign t
        bibtex-autokey-name-year-separator ""
        bibtex-autokey-year-title-separator ""
        bibtex-autokey-titleword-first-ignore '("the" "a" "if" "and" "an")
        bibtex-autokey-titleword-length 100
        bibtex-autokey-titlewords 1))

(use-package auctex-latexmk
  :ensure t
  :after auctex
  :init (add-hook 'LaTeX-mode-hook 'auctex-latexmk-setup))


;; Completion
;;(setq TeX-auto-global (format "%s/auctex/style" generated-basedir))
;; (add-to-list 'TeX-style-path TeX-auto-global) ;; FIXME: what is this variable


(use-package company-auctex
  :ensure t
  :after company
  :after auctex
  :config
  (company-auctex-init))


(use-package company-bibtex
  :ensure t
  :after company
  :after auctex
  :config
  (add-to-list 'company-backends 'company-bibtex))


(use-package company-math
  :ensure t
  :after company
  :after auctex
  :config
  ;; global activation of the unicode symbol completion
  (add-to-list 'company-backends 'company-math-symbols-unicode))

(use-package company-anaconda
  :ensure t
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; Escape mode
(defun TeX-toggle-escape nil
  (interactive)
  "Toggle Shell Escape"
  (setq LaTeX-command
        (if (string= LaTeX-command "latex") "latex -shell-escape"
          "latex"))
  (message (concat "shell escape "
                   (if (string= LaTeX-command "latex -shell-escape")
                       "enabled"
                     "disabled"))
           )
  )
(add-to-list 'TeX-command-list
             '("Make" "make" TeX-run-command nil t))
(setq TeX-show-compilation nil)

;; Redine TeX-output-mode to get the color !
(define-derived-mode TeX-output-mode TeX-special-mode "LaTeX Output"
  "Major mode for viewing TeX output.
  \\{TeX-output-mode-map} "
  :syntax-table nil
  (set (make-local-variable 'revert-buffer-function)
       #'TeX-output-revert-buffer)

  (set (make-local-variable 'font-lock-defaults)
       '((("^!.*" . font-lock-warning-face) ; LaTeX error
          ("^-+$" . font-lock-builtin-face) ; latexmk divider
          ("^\\(?:Overfull\\|Underfull\\|Tight\\|Loose\\).*" . font-lock-builtin-face)
          ;; .....
          )))

  ;; special-mode makes it read-only which prevents input from TeX.
  (setq buffer-read-only nil))

(use-package reftex
  :after auctex
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
  (setq reftex-save-parse-info t
        reftex-enable-partial-scans t
        reftex-use-multiple-selection-buffers t
        reftex-plug-into-AUCTeX t
        reftex-vref-is-default t
        reftex-cite-format
        '((?\C-m . "\\cite[]{%l}")
          (?t . "\\textcite{%l}")
          (?a . "\\autocite[]{%l}")
          (?p . "\\parencite{%l}")
          (?f . "\\footcite[][]{%l}")
          (?F . "\\fullcite[]{%l}")
          (?x . "[]{%l}")
          (?X . "{%l}"))

        font-latex-match-reference-keywords
        '(("cite" "[{")
          ("cites" "[{}]")
          ("footcite" "[{")
          ("footcites" "[{")
          ("parencite" "[{")
          ("textcite" "[{")
          ("fullcite" "[{")
          ("citetitle" "[{")
          ("citetitles" "[{")
          ("headlessfullcite" "[{"))

        reftex-cite-prompt-optional-args nil
        reftex-cite-cleanup-optional-args t))

(use-package latex-math-preview
  :ensure t
  :config
  (autoload 'LaTeX-preview-setup "preview")
  (setq preview-scale-function 1.2)
  (add-hook 'LaTeX-mode-hook 'LaTeX-preview-setup))

(use-package s)

(use-package cider
  :ensure t
  :config

  ;; REPL history file
  (setq cider-repl-history-file "~/.emacs.d/cider-history")

  ;; nice pretty printing
  (setq cider-repl-use-pretty-printing t)

  ;; nicer font lock in REPL
  (setq cider-repl-use-clojure-font-lock t)

  ;; result prefix for the REPL
  (setq cider-repl-result-prefix ";; => ")

  ;; never ending REPL history
  (setq cider-repl-wrap-history t)

  ;; looong history
  (setq cider-repl-history-size 3000)

  ;; eldoc for clojure
  (add-hook 'cider-mode-hook #'eldoc-mode)


  ;; error buffer not popping up
  (setq cider-show-error-buffer nil)

  ;; company mode for completion
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  )

(use-package clj-refactor
  :ensure t
  :config
  (add-hook 'clojure-mode-hook
	        (lambda ()
	          (clj-refactor-mode 1)
	          ;; insert keybinding setup here
	          (cljr-add-keybindings-with-prefix "C-c RET")))

  (add-hook 'clojure-mode-hook #'yas-minor-mode)

  ;; no auto sort
  (setq cljr-auto-sort-ns nil)

  ;; do not prefer prefixes when using clean-ns
  (setq cljr-favor-prefix-notation nil)
  )

(use-package let-alist
  :ensure t
  )

(use-package flycheck-clojure
  :ensure t
  )

(use-package hl-sexp
  :ensure t
  :config
  (add-hook 'clojure-mode-hook #'hl-sexp-mode)
  (add-hook 'lisp-mode-hook #'hl-sexp-mode)
  (add-hook 'emacs-lisp-mode-hook #'hl-sexp-mode)
  )

;(ignore-errors
;  (use-package org-beautify-theme
;    :ensure t)
;  )

(use-package cider
  :config
  (require 'cider)
  )

(require 'ob-emacs-lisp)

(use-package ob-http
  :config
  (require 'ob-http)
  )

(use-package ob-ipython
  :ensure t
  :config
  (require 'ob-ipython)
  )

(use-package ob-mongo
  :config
  (require 'ob-mongo)
  )

(use-package ob-cypher
  :config
  (require 'ob-cypher)
  )

(use-package ob-sql-mode
  :config
  (require 'ob-sql-mode)
  )

(use-package ob-prolog
  :config
  (require 'ob-prolog))


(use-package ob-blockdiag
  :config
  (require 'ob-blockdiag))

(use-package ob-browser
  :config
  (require 'ob-browser))

(use-package ob-async :ensure t)

(use-package org
  :ensure t
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)
         ("C-c C-w" . org-refile)
         ("C-c C-v t" . org-babel-tangle)
         ("C-c C-v f" . org-babel-tangle-file)
         ("C-c j" . org-clock-goto)
         ("C-c C-x C-o" . org-clock-out)
         )

  :init
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook 'org-babel-result-hide-all)
  (add-hook 'org-mode-hook 'turn-on-auto-fill)


  (add-hook 'org-mode-hook
            (lambda ()
              (let ((lines (count-lines (point-min) (point-max))))
                (when (< lines 500)
                  (linum-mode)))))

  :config

  (setq org-directory "~/Dropbox/org")



  ;; Enable pretty entities - shows e.g. α β γ as UTF-8 characters.
  (setq org-pretty-entities t)
  ;; Ensure native syntax highlighting is used for inline source blocks in org files
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-edit-src-content-indentation 0)

  (setq org-hide-emphasis-markers t)
  ;; I can display inline images. Set them to have a maximum size so large images don't fill the screen.
  (setq org-image-actual-width 800)
  (setq org-ellipsis "⤵");; ⤵ ≫ ⚡⚡⚡

  ;; make available "org-bullet-face" such that I can control the font size individually
  (setq org-bullets-face-name (quote org-bullet-face))

  ;; Agenda
  ;; Todo part
  ;;(setq org-agenda-files '())

  (setq org-agenda-files (quote ("~/Dropbox/org"
                                 "~/Dropbox/org/research.org"
                                 "~/Dropbox/org/consultancy.org"
                                 "~/Dropbox/org/previta.org"
                                 "~/Dropbox/org/anglobal.org"
                                 "~/Dropbox/org/datank.org"
                                 "~/Dropbox/org/dsapp.org"
                                 "~/Dropbox/org/gasolinerias.org"
                                 "~/Dropbox/org/ligamx.org"
                                 "~/Dropbox/org/vigilamos.org"
                                 "~/Dropbox/org/personal.org"
                                 "~/Dropbox/org/proyectos.org"
                                 )))



  (when (file-exists-p "~/Dropbox/org/todo/todo.org")
    (setq org-agenda-files
          (append org-agenda-files '("~/Dropbox/org/todo/todo.org"))))

  (when (file-exists-p "~/Dropbox/org/organisation/bookmarks.org")
    (setq org-agenda-files
          (append org-agenda-files '("~/Dropbox/org/organisation/bookmarks.org"))))

  (when (file-exists-p "~/Calendars")
    (setq org-agenda-files
          (append org-agenda-files (directory-files "~/Calendars/" t "^.*\\.org$"))))


  ;; I don't want to see things that are done. turn that off here.
  ;; http://orgmode.org/manual/Global-TODO-list.html#Global-TODO-list
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-timestamp-if-done t)
  (setq org-agenda-todo-ignore-scheduled t)
  (setq org-agenda-todo-ignore-deadlines t)
  (setq org-agenda-todo-ignore-timestamp t)
  (setq org-agenda-todo-ignore-with-date t)
  (setq org-agenda-start-on-weekday nil) ;; start on current day

  (setq org-upcoming-deadline '(:foreground "blue" :weight bold))

  ;; record time I finished a task when I change it to DONE
  (setq org-log-done 'time)

  ;; use timestamps in date-trees. for the journal
  (setq org-datetree-add-timestamp 'active)

  ;; Org-clock
  ;; Resume clocking task when emacs is restarted
  (org-clock-persistence-insinuate)
  ;;
  ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
  (setq org-clock-history-length 23)
  ;; Resume clocking task on clock-in if the clock is open
  (setq org-clock-in-resume t)
  ;; Separate drawers for clocking and logs
  (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
  ;; Save clock data and state changes and notes in the LOGBOOK drawer
  (setq org-clock-into-drawer t)
  ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)
  ;; Clock out when moving task to a done state
  (setq org-clock-out-when-done t)
  ;; Save the running clock and all clock history when exiting Emacs, load it on startup
  (setq org-clock-persist t)
  ;; Do not prompt to resume an active clock
  (setq org-clock-persist-query-resume nil)
  ;; Enable auto clock resolution for finding open clocks
  (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
  ;; Include current clocking task in clock reports
  (setq org-clock-report-include-clocking-task t)

  ;; Capture
  (setq org-capture-templates
        (quote (("t" "todo" entry (file "~/Dropbox/org/refile.org")
                 "* ▶ TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                ("r" "research" entry (file "~/Dropbox/org/research.org")
                 "* %? :IDEA:\n%U\n%a\n" :clock-in t :clock-resume t)
                ("j" "Journal" entry (file+datetree "~/Dropbox/org/diary.org")
                 "* %?\n%U\n" :clock-in t :clock-resume t)
                )))

  ;; Refile
  (setq org-default-notes-file "~/Dropbox/org/refile.org")

  ;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
  (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                   (org-agenda-files :maxlevel . 9))))
  ;; Use full outline paths for refile targets
  (setq org-refile-use-outline-path t)

  ;;
  (setq org-outline-path-complete-in-steps nil)

  ;; Allow refile to create parent tasks with confirmatio
  (setq org-refile-allow-creating-parent-nodes (quote confirm))

  (setq org-todo-keywords '(
                            (sequence
                             "TODO(t)"
                             "WORKING(w)"
                             "BLOCKED(b)"
                             "REVIEW(r)"
                             "|"
                             "✔ DONE(d)")
                            (sequence "|" "✘ CANCELLED(c@/!)"
                                      "SOMEDAY(f)"
                                      )))
  (setq org-todo-keyword-faces
        '(("WORKING" . "orange") ("BLOCKED" . "magenta") ("CANCELLED" . "red") ("DONE" . "green") ("SOMEDAY" . "pink"))
        )

  ;; Org-babel

  ;; No preguntar para confirmar la evaluación
  (setq org-confirm-babel-evaluate nil)

  ;; O en la exportación
  (setq org-export-babel-evaluate nil)

  (setq org-confirm-elisp-link-function nil)
  (setq org-confirm-shell-link-function nil)

  ;; Paths a ditaa y plantuml
  (setq org-ditaa-jar-path "~/software/org-libs/ditaa.jar")
  (setq org-plantuml-jar-path "~/software/org-libs/plantuml.jar")

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(

     (shell      . t)
     (R          . t)
     (awk        . t)
     (sed        . t)
     (org        . t)
     (latex      . t)
     (emacs-lisp . t)
     (clojure    . t)
     (stan       . t)
     (ipython    . t)
     (ruby       . t)
     (dot        . t)
     ;; (scala      . t)
     (sqlite     . t)
     (sql        . t)
     (ditaa      . t)
     (plantuml   . t)
     (mongo      . t)
     (cypher     . t)
     ;; (redis      . t)
     (blockdiag  . t)
     )
   )

  ;; LaTeX
  (setq org-export-latex-listings 'minted)
  (setq org-export-latex-minted-options
        '(("frame" "lines")
          ("fontsize" "\\scriptsize")
          ("linenos" "")
          ))
  (setq org-latex-to-pdf-process
        '("latexmk -xelatex='xelatex --shell-escape -interaction nonstopmode' -f  %f")) ;; for multiple passes

  ;; Org-babel no muestra el stderr
  ;; http://kitchingroup.cheme.cmu.edu/blog/2015/01/04/Redirecting-stderr-in-org-mode-shell-blocks/
  (setq org-babel-default-header-args:sh
        '((:prologue . "exec 2>&1") (:epilogue . ":"))
        )


  (add-to-list 'org-structure-template-alist
               '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))


  )  ;; Fin de use-package org

(use-package org-notebook :ensure t)

(use-package org-kanban
 :ensure t)

(use-package ox-twbs :config (require 'ox-twbs))
(use-package ox-gfm :config (require 'ox-gfm))
(use-package ox-tufte :config (require 'ox-tufte))
(use-package ox-textile :config (require 'ox-textile))
(use-package ox-rst :config (require 'ox-rst))
(use-package ox-asciidoc :config (require 'ox-asciidoc))
(use-package ox-epub :config (require 'ox-epub))
;;(use-package ox-reveal :config (require 'ox-reveal))

(use-package org-dashboard :ensure t)
(use-package org-download :ensure t)

(use-package org-web-tools :ensure t)

(use-package org-tree-slide
  :defer t
  :after (org)
  :bind (("C-<right>" . org-tree-slide-move-next-tree)
         ("C-<left>" . org-tree-slide-move-previous-tree)
         ("C-<up>" . org-tree-slide-content)
         )
  :init
  (setq org-tree-slide-skip-outline-level 4)
  (org-tree-slide-narrowing-control-profile)
  (setq org-tree-slide-skip-done nil)
  (org-tree-slide-presentation-profile)
  )

(use-package org-projectile
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :after (org)
  :config
  (progn
    (setq org-projectile-projects-file
          "~/Dropbox/org/projects.org")
    (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    (push (org-projectile-project-todo-entry) org-capture-templates))
  :ensure t)

(use-package ivy-bibtex
  :ensure t
  :config
  (setq ivy-bibtex-bibliography "~/Dropbox/bibliography/references.bib" ;; where your references are stored
        ivy-bibtex-library-path "~/Dropbox/bibliography/bibtex-pdfs/" ;; where your pdfs etc are stored
        ivy-bibtex-notes-path "~/Dropbox/bibliography/notes.org" ;; where your notes are stored
        bibtex-completion-bibliography "~/Dropbox/bibliography/references.bib" ;; writing completion
        bibtex-completion-notes-path "~/Dropbox/bibliography/notes.org"))

(use-package org-ref
  :defer t
  :init
  (setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))

  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
        org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
        org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")
  )

(use-package interleave
  :defer t
  :bind ("C-x i" . interleave-mode)
  :config
  (setq interleave-split-direction 'horizontal
        interleave-split-lines 20
        interleave-disable-narrowing t))

;; (use-package org-present
;;   :defer t
;;   :after (org)
;;   :init
;;   (progn

;;     (add-hook 'org-present-mode-hook
;;               (lambda ()
;;                 (global-linum-mode -1)
;;                 (org-present-big)
;;                 (org-display-inline-images)
;;                 (org-present-hide-cursor)
;;                 (org-present-read-only)))
;;     (add-hook 'org-present-mode-quit-hook
;;               (lambda ()
;;                 (global-linum-mode -1)
;;                 (org-present-small)
;;                 (org-remove-inline-images)
;;                 (org-present-show-cursor)
;;                 (org-present-read-write))))
;;   )

(use-package org-bullets
  :defer t
  :diminish
  :disabled
  :after (org)
  :init
  (setq org-bullets-bullet-list
        '("■" "◆" "▲" "○" "☉" "◎" "◉" "○" "◌" "◎" "●" "◦" "◯" "⚪" "⚫" "⚬" "❍" "￮" "⊙" "⊚" "⊛" "∙" "∘"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(use-package org-attach-screenshot
  :diminish
  :after (org)
  :bind
  (("C-c S" . org-attach-screenshot))
  )

;; Disable checking doc
(use-package flycheck
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))


;; Package lint
(use-package package-lint :ensure t)

;; Pretty print for lisp
(use-package ipretty :ensure t)

(add-to-list 'same-window-buffer-names "*SQL*")

(setq sql-postgres-login-params
      '((user :default "postgres")
        (database :default "postgres")
        (server :default "localhost")
        (port :default 5432)))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (setq sql-prompt-regexp "^[_[:alpha:]]*[=][#>] ")
            (setq sql-prompt-cont-regexp "^[_[:alpha:]]*[-][#>] ")
            (toggle-truncate-lines t)))

(use-package ensime
:ensure t)
(setq ensime-startup-notification nil
      ensime-startup-snapshot-notification nil)

(use-package ess-site
  :ensure ess
  :config
  ;; Subpackage
  (use-package ess-R-data-view :ensure t)
  (use-package ess-smart-equals :ensure t)
  (use-package ess-smart-underscore :ensure t)
  (use-package ess-view :ensure t)

  (ess-toggle-underscore nil) ; http://stackoverflow.com/questions/2531372/how-to-stop-emacs-from-replacing-underbar-with-in-ess-mode
  (setq ess-fancy-comments nil) ; http://stackoverflow.com/questions/780796/emacs-ess-mode-tabbing-for-comment-region
					; Make ESS use RStudio's indenting style
  (add-hook 'ess-mode-hook (lambda() (ess-set-style 'RStudio)))
					; Make ESS use more horizontal screen
					; http://stackoverflow.com/questions/12520543/how-do-i-get-my-r-buffer-in-emacs-to-occupy-more-horizontal-space
  (add-hook 'ess-R-post-run-hook 'ess-execute-screen-options)
  (define-key inferior-ess-mode-map "\C-cw" 'ess-execute-screen-options)
					; Add path to Stata to Emacs' exec-path so that Stata can be found
  )

(use-package company-statistics
  :ensure t
  :after company
  :init
  (add-hook 'after-init-hook 'company-statistics-mode))

(use-package ssh :ensure t)
(use-package ssh-deploy :ensure t)

(use-package nginx-mode
  :ensure t)

(use-package apache-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
  (add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
  (add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
  (add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
  (add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode)))


(use-package syslog-mode
  :mode "\\.log$")

(use-package config-general-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.conf$" . config-general-mode))
  (add-to-list 'auto-mode-alist '("\\.*rc$"  . config-general-mode)))

;; (use-package authinfo-mode
;;   :ensure t
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.authinfo\\(?:\\.gpg\\)\\'" . authinfo-mode)))

(use-package ssh-config-mode
  :ensure t
  :config
  (autoload 'ssh-config-mode "ssh-config-mode" t)
  (add-to-list 'auto-mode-alist '("/\\.ssh/config\\'"     . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/system/ssh\\'"        . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/sshd?_config\\'"      . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode))
  (add-hook 'ssh-config-mode-hook 'turn-on-font-lock))

(use-package logview
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("syslog\\(?:\\.[0-9]+\\)" . logview-mode))
  (add-to-list 'auto-mode-alist '("\\.log\\(?:\\.[0-9]+\\)?\\'" . logview-mode)))

(use-package docker :ensure t)
(use-package docker-tramp :ensure t)
(use-package dockerfile-mode :ensure t :mode "Dockerfile$")
(use-package docker-compose-mode :ensure t :mode "docker-compose.yml")

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package polymode
  :ensure t
  :config
  (require 'poly-markdown))

(use-package json-mode :mode "\\.json")
(use-package json-navigator)
(use-package json-reformat)

(use-package yaml-mode :ensure t :mode "\\.ya?ml")
(use-package yaml-tomato :ensure t)

(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package hideshow
  :ensure t
  :config
  (add-hook 'c-mode-common-hook   'hs-minor-mode)
  (add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
  (add-hook 'java-mode-hook       'hs-minor-mode)
  (add-hook 'lisp-mode-hook       'hs-minor-mode)
  (add-hook 'perl-mode-hook       'hs-minor-mode)
  (add-hook 'sh-mode-hook         'hs-minor-mode)
  (add-hook 'js-mode-hook         'hs-minor-mode))
(use-package fold-dwim :ensure t)

(use-package fancy-narrow
  :ensure t
  :diminish
  :config
  (fancy-narrow-mode)
  )

(use-package demo-it
  :ensure t
  )

(use-package magit
  :ensure t
  :config

  ;; Ignore recent commit
  (setq magit-status-sections-hook
        '(magit-insert-status-headers
          magit-insert-merge-log
          magit-insert-rebase-sequence
          magit-insert-am-sequence
          magit-insert-sequencer-sequence
          magit-insert-bisect-output
          magit-insert-bisect-rest
          magit-insert-bisect-log
          magit-insert-untracked-files
          magit-insert-unstaged-changes
          magit-insert-staged-changes
          magit-insert-stashes
          magit-insert-unpulled-from-upstream
          magit-insert-unpulled-from-pushremote
          magit-insert-unpushed-to-upstream
          magit-insert-unpushed-to-pushremote))


  ;; Update visualization
  (setq pretty-magit-alist nil
        pretty-magit-prompt nil)

  (defmacro pretty-magit (WORD ICON PROPS &optional NO-PROMPT?)
    "Replace sanitized WORD with ICON, PROPS and by default add to prompts."
    `(prog1
         (add-to-list 'pretty-magit-alist
                      (list (rx bow (group ,WORD (eval (if ,NO-PROMPT? "" ":"))))
                            ,ICON ',PROPS))
       (unless ,NO-PROMPT?
         (add-to-list 'pretty-magit-prompt (concat ,WORD ": ")))))

  (pretty-magit "Feature" ? (:foreground "slate gray" :height 1.2) pretty-magit-prompt)
  (pretty-magit ": add"   ? (:foreground "#375E97" :height 1.2) pretty-magit-prompt)
  (pretty-magit ": fix"   ? (:foreground "#FB6542" :height 1.2) pretty-magit-prompt)
  (pretty-magit ": clean" ? (:foreground "#FFBB00" :height 1.2) pretty-magit-prompt)
  (pretty-magit ": docs"  ? (:foreground "#3F681C" :height 1.2) pretty-magit-prompt)
  (pretty-magit "master"  ? (:box t :height 1.2) t)
  (pretty-magit "origin"  ? (:box t :height 1.2) t)

  (defun add-magit-faces ()
    "Add face properties and compose symbols for buffer from pretty-magit."
    (interactive)
    (with-silent-modifications
      (--each pretty-magit-alist
        (-let (((rgx icon props) it))
          (save-excursion
            (goto-char (point-min))
            (while (search-forward-regexp rgx nil t)
              (compose-region
               (match-beginning 1) (match-end 1) icon)
              (when props
                (add-face-text-property
                 (match-beginning 1) (match-end 1) props))))))))

  (advice-add 'magit-status :after 'add-magit-faces)
  (advice-add 'magit-refresh-buffer :after 'add-magit-faces)


  ;; Opening repo externally
  (defun parse-url (url)
    "convert a git remote location as a HTTP URL"
    (if (string-match "^http" url)
        url
      (replace-regexp-in-string "\\(.*\\)@\\(.*\\):\\(.*\\)\\(\\.git?\\)"
                                "https://\\2/\\3"
                                url)))
  (defun magit-open-repo ()
    "open remote repo URL"
    (interactive)
    (let ((url (magit-get "remote" "origin" "url")))
      (progn
        (browse-url (parse-url url))
        (message "opening repo %s" url))))


  (add-hook 'magit-mode-hook
            (lambda ()
              (local-set-key (kbd "o") 'magit-open-repo))))


;; Some plugins
(use-package magit-tbdiff :ensure t :after magit)

(use-package git-commit :ensure t)
(use-package gitattributes-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package gitconfig-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist
               '("/\.gitconfig\'"    . gitconfig-mode))
  (add-to-list 'auto-mode-alist
               '("/vcs/gitconfig\'"    . gitconfig-mode)))


(use-package magit-gitflow
  :ensure t
  :after magit
  :disabled
  :init
  (progn
    (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)  ;; Keybing: C-f en la ventana de magit
    )
  )

(use-package git-timemachine :ensure t)

(setenv "PAGER" "/bin/cat") ;; fixes git terminal warning
(add-hook 'eshell-mode-hook #'(lambda () (setenv "PAGER" "/bin/cat")))

(setq eshell-list-files-after-cd t)
(setq eshell-ls-initial-args "-lh")

      (use-package eshell-git-prompt
        :config (eshell-git-prompt-use-theme 'robbyrussell))

      (use-package eshell-prompt-extras
        :config
        (progn
          (with-eval-after-load "esh-opt"
            (autoload 'epe-theme-lambda "eshell-prompt-extras")
            (setq eshell-highlight-prompt nil
                  eshell-prompt-function 'epe-theme-lambda))
          ))


;; pinched from powerline.el
(defun curve-right-xpm (color1 color2)
  "Return an XPM right curve string representing."
  (create-image
   (format "/* XPM */
static char * curve_right[] = {
\"12 18 2 1\",
\". c %s\",
\"  c %s\",
\"           .\",
\"         ...\",
\"         ...\",
\"       .....\",
\"       .....\",
\"       .....\",
\"      ......\",
\"      ......\",
\"      ......\",
\"      ......\",
\"      ......\",
\"      ......\",
\"       .....\",
\"       .....\",
\"       .....\",
\"         ...\",
\"         ...\",
\"           .\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun curve-left-xpm (color1 color2)
  "Return an XPM left curve string representing."
  (create-image
   (format "/* XPM */
static char * curve_left[] = {
\"12 18 2 1\",
\". c %s\",
\"  c %s\",
\".           \",
\"...         \",
\"...         \",
\".....       \",
\".....       \",
\".....       \",
\"......      \",
\"......      \",
\"......      \",
\"......      \",
\"......      \",
\"......      \",
\".....       \",
\".....       \",
\".....       \",
\"...         \",
\"...         \",
\".           \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

;; TODO memoize those drawing functions

(defvar eshell-prompt-suffix
  (if (eq system-type 'darwin) "🔥 " "$ ")
  "String at end of prompt")

(defun eshell-blocky-prompt ()
  (let ((bg (frame-parameter nil 'background-color))
        (fg (frame-parameter nil 'foreground-color)))
    (concat
     (propertize " " 'display (curve-right-xpm bg "#3d3d68"))
     (propertize (eshell/pwd) 'face
                 (list :foreground "white"
                       :background "#3d3d68"))
     (propertize " " 'display (curve-left-xpm "#3d3d68" bg))
     eshell-prompt-suffix)))

(defconst eshell-blocky-prompt-regexp
  (string-join (list "^[^#\n]* " eshell-prompt-suffix)))

(unless (frame-parameter nil 'tty)
  ;; TODO fancy prompt in terminal mode also
  (setq eshell-prompt-function 'eshell-blocky-prompt
        eshell-prompt-regexp eshell-blocky-prompt-regexp))

(use-package graphviz-dot-mode
  :ensure t
  :init
  (defvar default-tab-width nil)

  :config
  (add-to-list 'auto-mode-alist '("\\.dot\\'" . graphviz-dot-mode)))

(use-package csv-mode
  :ensure t
  :mode "\\.[PpTtCc][Ss][Vv]\\'"

  :config
  (progn
    (setq csv-separators '("," ";" "|" " " "\t"))
    )
  )

(use-package cypher-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.cql\\'" . cypher-mode))
  )

(use-package org-pdfview
  :after org
  :ensure t
  )


(use-package  pdf-tools
  :after org
  :after hydra
  :ensure t
  :config
  (add-to-list 'org-file-apps
	   '("\\.pdf\\'" . (lambda (file link)
				 (org-pdfview-open link))))
  (add-to-list 'org-file-apps
	   '("\\.pdf::\\([[:digit:]]+\\)\\'" . org-pdfview-open))

  (setq ess-pdf-viewer-pref 'emacsclient)
  )

(pdf-tools-install)


;; Keys
(bind-keys :map pdf-view-mode-map
	   ("/" . hydra-pdftools/body)
	   ("<s-spc>" .  pdf-view-scroll-down-or-next-page)
	   ("g"  . pdf-view-first-page)
	   ("G"  . pdf-view-last-page)
	   ("l"  . image-forward-hscroll)
	   ("h"  . image-backward-hscroll)
	   ("j"  . pdf-view-next-page)
	   ("k"  . pdf-view-previous-page)
	   ("e"  . pdf-view-goto-page)
	   ("u"  . pdf-view-revert-buffer)
	   ("al" . pdf-annot-list-annotations)
	   ("ad" . pdf-annot-delete)
	   ("aa" . pdf-annot-attachment-dired)
	   ("am" . pdf-annot-add-markup-annotation)
	   ("at" . pdf-annot-add-text-annotation)
	   ("y"  . pdf-view-kill-ring-save)
	   ("i"  . pdf-misc-display-metadata)
	   ("s"  . pdf-occur)
	   ("b"  . pdf-view-set-slice-from-bounding-box)
	   ("r"  . pdf-view-reset-slice))

(defhydra hydra-pdftools (:color blue :hint nil)
  "
  PDF tools

   Move  History   Scale/Fit                  Annotations     Search/Link     Do
------------------------------------------------------------------------------------------------
 ^^_g_^^      _B_    ^↧^    _+_    ^ ^     _al_: list    _s_: search    _u_: revert buffer
 ^^^↑^^^      ^↑^    _H_    ^↑^  ↦ _W_ ↤   _am_: markup  _o_: outline   _i_: info
 ^^_p_^^      ^ ^    ^↥^    _0_    ^ ^     _at_: text    _F_: link      _d_: dark mode
 ^^^↑^^^      ^↓^  ╭─^─^─┐  ^↓^  ╭─^ ^─┐   _ad_: delete  _f_: search link
_h_ ←pag_e_→ _l_  _N_  │ _P_ │  _-_    _b_     _aa_: dired
 ^^^↓^^^      ^ ^  ╰─^─^─╯  ^ ^  ╰─^ ^─╯   _y_:  yank
 ^^_n_^^      ^ ^  _r_eset slice box
 ^^^↓^^^
 ^^_G_^^
"
  ("\\" hydra-master/body "back")
  ("<ESC>" nil "quit")
  ("al" pdf-annot-list-annotations)
  ("ad" pdf-annot-delete)
  ("aa" pdf-annot-attachment-dired)
  ("am" pdf-annot-add-markup-annotation)
  ("at" pdf-annot-add-text-annotation)
  ("y"  pdf-view-kill-ring-save)
  ("+" pdf-view-enlarge :color red)
  ("-" pdf-view-shrink :color red)
  ("0" pdf-view-scale-reset)
  ("H" pdf-view-fit-height-to-window)
  ("W" pdf-view-fit-width-to-window)
  ("P" pdf-view-fit-page-to-window)
  ("n" pdf-view-next-page-command :color red)
  ("p" pdf-view-previous-page-command :color red)
  ("d" pdf-view-dark-minor-mode)
  ("b" pdf-view-set-slice-from-bounding-box)
  ("r" pdf-view-reset-slice)
  ("g" pdf-view-first-page)
  ("G" pdf-view-last-page)
  ("e" pdf-view-goto-page)
  ("o" pdf-outline)
  ("s" pdf-occur)
  ("i" pdf-misc-display-metadata)
  ("u" pdf-view-revert-buffer)
  ("F" pdf-links-action-perfom)
  ("f" pdf-links-isearch-link)
  ("B" pdf-history-backward :color red)
  ("N" pdf-history-forward :color red)
  ("l" image-forward-hscroll :color red)
  ("h" image-backward-hscroll :color red))

(use-package darkroom :ensure t)

(setq python-shell-prompt-detect-failure-warning nil)

;;(setq split-height-threshold nil)
;;(setq split-width-threshold 80)

(use-package neotree
  :ensure t

  :config
  (setq neo-smart-open t)
  (setq neo-vc-integration nil)
  ;; Do not allow neotree to be the only open window
  (setq-default neo-dont-be-alone t)
  (setq neo-fit-to-contents nil)
  (setq neo-theme 'arrow)
  (setq neo-window-fixed-size nil)
  )

(setq dired-listing-switches "-lh --group-directories-first")

(use-package writegood-mode
  :ensure t
  :bind ("C-c g" . writegood-mode)
  :config
  (add-to-list 'writegood-weasel-words "actionable"))

(use-package sx
   :ensure t
   :config
   (bind-keys :prefix "C-c s"
              :prefix-map my-sx-map
              :prefix-docstring "Global keymap for SX."
              ("q" . sx-tab-all-questions)
              ("i" . sx-inbox)
              ("o" . sx-open-link)
              ("u" . sx-tab-unanswered-my-tags)
              ("a" . sx-ask)
              ("s" . sx-search)))

(use-package google-this
  :ensure t)

(use-package helpful :ensure t)

(use-package info-buffer :ensure t)

(use-package which-key
  :ensure t
  :config
    (which-key-mode))

(use-package man
  :ensure t
  :config
  (setq Man-notify-method 'pushy)
  (setq woman-manpath
        `(
          "/usr/share/man/" "/usr/local/man/" ;; System
          (format "%s/local/man" config-basedir) ;; Private environment
          )))

;; Swiper / ivy / counsel
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key [f6] 'ivy-resume)
(global-set-key (kbd "C-c hm") 'woman)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c u") 'swiper-all)
(global-set-key (kbd "<F1> f") 'counsel-describe-function)
(global-set-key (kbd "<F1> v") 'counsel-describe-variable)
(global-set-key (kbd "<F1> l") 'counsel-find-library)
(global-set-key (kbd "<F2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<F2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))


(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(global-set-key [f8] 'neotree-toggle)

(global-set-key (kbd "<F9> b") 'bbdb)
(global-set-key (kbd "<F9> c") 'calendar)
(global-set-key (kbd "<F9> f") 'boxquote-insert-file)

(global-set-key [f7] 'darkroom-tentative-mode)

(global-set-key [f12] 'org-agenda)

(defhydra hydra-main (:color teal :hint nil)
  "
     Main helper

 Org. related             Help                Zooming
------------------------------------------------------------------------------------------
_c_: org-capture        _f_: function doc.    _+_: zoom in
_g_: org-web-get-url    _v_: variable doc.    _-_: zoom out
_m_: new mail
"
  ("c"   org-capture)
  ("f" describe-function)
  ("g" org-web-tools-read-url-as-org)
  ("m" mu4e-compose-new)
  ("v" describe-variable)
  ("+" text-scale-increase :color pink)
  ("-" text-scale-decrease :color pink)
  ("<ESC>" nil "quit" :color blue)
  ("q"   nil "cancel" :color blue))

(global-set-key (kbd "<f1>") 'hydra-main/body)

(global-set-key
 (kbd "C-n")
 (defhydra hydra-move
   (:body-pre (next-line))
   "move"
   ("n" next-line)
   ("p" previous-line)
   ("f" forward-char)
   ("b" backward-char)
   ("a" beginning-of-line)
   ("e" move-end-of-line)
   ("v" scroll-up-command)
   ("V" scroll-down-command)
   ("l" recenter-top-bottom)
   (">" end-of-buffer)
   ("<" beginning-of-buffer)))

(defhydra hydra-projectile-other-window (:color teal)
  "projectile-other-window"
  ("f"  projectile-find-file-other-window        "file")
  ("g"  projectile-find-file-dwim-other-window   "file dwim")
  ("d"  projectile-find-dir-other-window         "dir")
  ("b"  projectile-switch-to-buffer-other-window "buffer")
  ("q"  nil                                      "cancel" :color blue))

(defhydra hydra-projectile (:color teal :hint nil)
  "
     PROJECTILE: %(projectile-project-root)

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
_s-f_: file            _a_: ag                _i_: Ibuffer           _c_: cache clear
 _ff_: file dwim       _g_: update gtags      _b_: switch to buffer  _x_: remove known project
 _fd_: file curr dir   _o_: multi-occur     _s-k_: Kill all buffers  _X_: cleanup non-existing
  _r_: recent file                                               ^^^^_z_: cache current
  _d_: dir

"
  ("<ESC>" nil "quit")
  ("<" hydra-project/body "back")
  ("a"   projectile-ag)
  ("b"   projectile-switch-to-buffer)
  ("c"   projectile-invalidate-cache)
  ("d"   projectile-find-dir)
  ("s-f" projectile-find-file)
  ("ff"  projectile-find-file-dwim)
  ("fd"  projectile-find-file-in-directory)
  ("g"   ggtags-update-tags)
  ("s-g" ggtags-update-tags)
  ("i"   projectile-ibuffer)
  ("K"   projectile-kill-buffers)
  ("s-k" projectile-kill-buffers)
  ("m"   projectile-multi-occur)
  ("o"   projectile-multi-occur)
  ("s-p" projectile-switch-project "switch project")
  ("p"   projectile-switch-project)
  ("s"   projectile-switch-project)
  ("r"   projectile-recentf)
  ("x"   projectile-remove-known-project)
  ("X"   projectile-cleanup-known-projects)
  ("z"   projectile-cache-current-file)
  ("`"   hydra-projectile-other-window/body "other window" :color blue)
  ("q"   nil "cancel" :color blue))

(defhydra hydra-fixmee (:color teal :hint nil :idle 0.4)
  "
     FIXMEE

------------------------------------------------------------------------------------------
_x_: view listing    _X_: toggle
            "
  ("<ESC>" nil "quit")
  ("<" hydra-project/body "back")
  ("X"   fixmee-mode)
  ("x"   fixmee-view-listing)
  ("q"   nil "cancel" :color blue))

(defhydra hydra-magit (:color teal :hint nil)
  "
      Magit: %(magit-get \"remote\" \"origin\" \"url\")

 Status/Info      Remote          Operations
------------------------------------------------------------------------------------------
_s_: Status      _f_: Pull       _c_: commit
_l_: Log all     _p_: Push
_d_: Diff
_t_: timeline
"
  ("<ESC>" nil "quit")
  ("<" hydra-project/body "back")
  ("f" magit-pull)
  ("p" magit-push)
  ("c" magit-commit)
  ("d" magit-diff)
  ("l" magit-log-all)
  ("s" magit-status)
  ("t" git-timeline)
  ("q"   nil "cancel" :color blue))

(defhydra hydra-flycheck (:pre (progn (setq hydra-lv t) (flycheck-list-errors))
                          :post (progn (setq hydra-lv nil) (quit-windows-on "*Flycheck errors*"))
                          :color teal
                          :hint nil)
  "Errors"
  ("f"  flycheck-error-list-set-filter                            "Filter")
  ("j"  flycheck-next-error                                       "Next")
  ("k"  flycheck-previous-error                                   "Previous")
  ("gg" flycheck-first-error                                      "First")
  ("G"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("<" hydra-project/body "back")
  ("q"   nil "cancel" :color blue))


(defhydra hydra-project (:color teal :hint nil)
  "
     Project/Source management

 Projects              Version control        On-the-fly
------------------------------------------------------------------------------------------
_d_: dash projects     _m_: magit             _f_: fixmee
_p_: projectile        _t_: travis status     _F_: flycheck

"
  ("<ESC>" nil "quit")
  ("d"   org-dashboard-display)
  ("p"   hydra-projectile/body)
  ("f"   hydra-fixmee/body)
  ("F"   hydra-flycheck/body)
  ("m"   hydra-magit/body)
  ("t"   show-my-travis-projects)
  ("q"   nil "cancel" :color blue))
(global-set-key (kbd "<f4>") 'hydra-project/body)

;; Function coming from here: http://www.howardism.org/Technical/Emacs/eshell-fun.html
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(defhydra hydra-shell (:color teal :hint nil)
  "
     Shell

------------------------------------------------------------------------------------------
_p_: start (projectile)
_h_: start (here)
"
  ("p"      projectile-run-eshell)
  ("h"      eshell-here)
  ("<ESC>"  nil "quit" :color blue)
  ("q"      nil "cancel" :color blue))
(global-set-key (kbd "<f9>") 'hydra-shell/body)

(global-set-key (kbd "C-c C-c") 'compile)

(defhydra hydra-next-error (global-map "C-x")
    "
Compilation errors:
_j_: next error        _h_: first error    _q_uit
_k_: previous error    _l_: last error
"
    ("`" next-error     nil)
    ("j" next-error     nil :bind nil)
    ("k" previous-error nil :bind nil)
    ("h" first-error    nil :bind nil)
    ("l" (condition-case err
             (while t
               (next-error))
           (user-error nil))
     nil :bind nil)
    ("q" nil            nil :color blue))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") 'text-scale-adjust)

(global-set-key (kbd "C-c C-;") 'comment-region)
(global-set-key (kbd "C-c C-:") 'uncomment-region)

(global-set-key (kbd "C-x C-r") 'counsel-recentf)
(global-set-key (kbd "C-x C-d") 'dired)

(global-set-key [(control c) ?1] 'find-name-dired)
(global-set-key [(control c) ?2] 'find-grep-dired)
(global-set-key [(control c) ?3] 'grep-find)

(use-package dashboard
  :disabled
  :demand
  :after projectile
  :config
  (progn
    (dashboard-setup-startup-hook)
    (setq dashboard-banner-logo-title ""
          dashboard-startup-banner 'official
          dashboard-items '((agenda . t)
                            (recents  . 5)
                            (projects . 5)
			                )))
  )

(use-package telephone-line
  :config (progn
            (require 'telephone-line-config)
            (telephone-line-mode 1)
            (setq telephone-line-height 24)))

(use-package scratch-ext
  :ensure t
  :config
  (add-hook 'after-init-hook 'scratch-ext-restore-last-scratch)

  ;; Org-mode + start folded buffer
  (setq initial-major-mode 'org-mode)
  (set-buffer (get-buffer-create "*scratch*"))
  (set (make-local-variable 'org-startup-folded) t))

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
)

(use-package savehist
  :ensure t
  :init
  (savehist-mode +1)
  :config
  ;; savehist keeps track of some history
  (setq savehist-additional-variables
        ;; search entries
        '(search-ring regexp-search-ring)
        ;; save every minute
        savehist-autosave-interval 60
        ;; keep the home clean
        ;;savehist-file (expand-file-name "savehist" prelude-savefile-dir)
)

  )

(use-package windmove
  :ensure t
  :config
  ;; use shift + arrow keys to switch between visible buffers
  (windmove-default-keybindings)
  )

;; dired - reuse current buffer by pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)

;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(setq dired-dwim-target t)

;; enable some really cool extensions like C-x C-j(dired-jump)
(require 'dired-x)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; clean up obsolete buffers automatically
(require 'midnight)

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)            ;; but maintain correct appearance


;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
(delete-selection-mode t)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; disable annoying blink-matching-paren
(setq blink-matching-paren nil)

;; highlight the current line
(global-hl-line-mode +1)

;; saner regex syntax
(require 're-builder)
(setq reb-re-syntax 'string)

(use-package exec-path-from-shell
  :ensure t
  :disabled
  :config
  (exec-path-from-shell-initialize))

(require 'server)
(if (not (server-running-p)) (server-start))
