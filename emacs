;; -*- mode: Emacs-Lisp; coding: utf-8-unix -*-

;; .emacs - an emacs initialization file created by MindMirror

;; Load package manager ELPA
(add-to-list 'load-path "~/.emacs.d/elpa")
(load "package")
(package-initialize)


;; General Setting
;; ============================================================

;; Set default directory
(if (eq system-type 'windows-nt)
    (setq default-directory "C:/"))

;; Mute the error tip sound
(setq visible-bell t)

;; Set killing ring
(setq kill-ring-max 1024)

;; Move mouse cursor away
(mouse-avoidance-mode 'animate)

;; Show images inside Emacs
(auto-image-file-mode t)

;; Support compressed file
(auto-compression-mode t)

;; Turn off the splash
(setq inhibit-startup-message t)

;; Set scroll margin
(setq scroll-margin 8
      scroll-conservatively 8192)

;; Set default tab-width
(setq tab-width 4)
(setq-default tab-width 4)

;; Expand Tab
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)

;; Set default major mode to Text mode
(setq default-major-mode 'text-mode)

;; Set sentence end
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil) ;; End sentence with one space

;; Show the other bracket but not jumb to it
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; Syntax highlighting
(global-font-lock-mode t)

;; Display line and column number
(setq column-number-mode t)
(setq line-number-mode t)

;; Turn tool bar off
(tool-bar-mode -1)
;; Turn menu bar off
(if (not (eq system-type 'darwin))
    (menu-bar-mode -1))
;; Turn scroll bar off
(scroll-bar-mode nil)

;; Blink cursor
(blink-cursor-mode t)

;; Indicate buffer boundaries
(setq default-indicate-buffer-boundaries 'left)

;; Display time and date
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;; Use y-or-n-p
(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight marked block
(setq transient-mark-mode t)

;; Alt is Alt, Command is Meta on Mac OS X
(if (eq system-type 'darwin)
    (setq mac-option-key-is-meta  nil
          mac-command-key-is-meta t
          mac-command-modifier    'meta
          mac-option-modifier     nil))

;; Backup settings
(setq backup-by-copying t                     ; don't clobber symlinks
      backup-directory-alist
      `(("." . "~/.saves")                    ; flat dir backup
        (,tramp-file-name-regexp nil))        ; don't backup tramp files
      auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t))   ; put auto-save file in temp dir
      delete-old-versions t                   ; auto delete old version
      kept-new-version 6                      ; keep most recent 6 files
      kept-old-version 2                      ; keep 2 oldest files
      version-control t)                      ; use version contro backup

;; Use session
(add-to-list 'load-path "~/.emacs.d/site-lisp/session/")
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; Use ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;; Hide buffers starting with an asterisk
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")

;; Open recent opened files
(require 'recentf)
(recentf-mode 1)
;; Bind C-x C-r with list the recent opened files function
;; The original function is open read-only file
(defun recentf-open-files-compl ()
  (interactive)
  (let* ((all-files recentf-list)
         (tocpl (mapcar (function
                         (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
         (prompt (append '("File name: ") tocpl))
         (fname (completing-read (car prompt) (cdr prompt) nil nil)))
    (find-file (cdr (assoc-string fname tocpl)))))
(global-set-key [(control c)(control r)] 'recentf-open-files-compl)

;; Use ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ; enable fuzzy matching
;; ido M-x mode
(setq ido-execute-command-cache nil)
(defun ido-execute-command ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (progn
       (unless ido-execute-command-cache
         (mapatoms (lambda (s)
                     (when (commandp s)
                       (setq ido-execute-command-cache
                             (cons (format "%S" s)
                                   ido-execute-command-cache))))))
       ido-execute-command-cache)))))
(add-hook 'ido-setup-hook
          (lambda () (setq ido-enable-flex-matching t)
            (global-set-key "\M-x" 'ido-execute-command)))

;; Use second-sel, this must be put before browse-kill-ring
(add-to-list 'load-path "~/.emacs.d/site-lisp/second-sel/")
(require 'second-sel)
;;(global-set-key [(control meta ?y)] 'secondary-dwim)

;; Use browse-kill-ring
(add-to-list 'load-path "~/.emacs.d/site-lisp/browse-kill-ring/")
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; Use browse-kill-ring+
(require 'browse-kill-ring+)


;; Set default font
(set-frame-font "-apple-consolas-medium-r-normal--14-*-*-*-m-*-iso10646-1")

;; Set coding system
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
;; MS windows clipboard is UTF-16LE
(if (eq system-type 'windows-nt)
    (set-clipboard-coding-system 'utf-16le-dos))


;; Bind F10 with Menu function
(global-set-key [f9] 'menu-bar-mode)

;; Set highlight-symbol
(add-to-list 'load-path "~/.emacs.d/elpa/highlight-symbol-1.1")
(require 'highlight-symbol)
(global-set-key [f10] 'highlight-symbol-at-point)
(global-set-key [f11] 'highlight-symbol-next)
(global-set-key [f12] 'highlight-symbol-prev)

;; Let dired copy and delete directories recursively
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;; Show buffer info
(setq frame-title-format '("" "[%b@%f] - Emacs " emacs-version))

;; Color theme
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme/")
(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-tangotango)

;; Set default frame
(setq default-frame-alist
      '((foreground-color . "Wheat")
        (background-color . "Black")
        (cursor-color     . "DeepSkyBlue")
        (width            . 120)
        (height           . 82)))

;; Darth Vada style mode line
(custom-set-faces
 '(mode-line
   ((((class color) (min-colors 88))
     (:background "DarkRed"
      :foreground "White"
      :box (:line-width -1
            :style released-button))))))

;; Set WhiteSpace
(require 'whitespace)
(setq whitespace-style
      '(tabs tab-mark trailing))
(global-set-key (kbd "\C-c w") 'whitespace-mode)
(global-set-key (kbd "\C-c \C-w") 'whitespace-mode)

;; real lisp hackers use the lambda character
;; courtesy of stefan monnier on c.l.l
(defun gr-lambda-mode-hook ()
  (font-lock-add-keywords
   nil `(("\\<lambda\\>"
          (0 (progn (compose-region (match-beginning 0) (match-end 0)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))
;; Using Consolas font do display lambda
(set-fontset-font "fontset-default"
                  (make-char 'greek-iso8859-7 107)   ;lambda is code point 107
                  "-apple-consolas-medium-r-normal--14-*-*-*-m-*-iso10646-1")
(add-hook 'emacs-lisp-mode-hook 'gr-lambda-mode-hook)
(add-hook 'lisp-mode-hook 'gr-lambda-mode-hook)
(add-hook 'lisp-interactive-mode-hook 'gr-lambda-mode-hook)
(add-hook 'slime-repl-mode-hook 'gr-lambda-mode-hook)
(add-hook 'scheme-mode-hook 'gr-lambda-mode-hook)

;; Globally bind M+/ with hippie-expand function
(global-set-key [(meta ?/)] 'hippie-expand)
;; Settings for hippie-expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill))


;; Programming
;; ============================================================

;; ------------------------- ParEdit --------------------------

(add-to-list 'load-path "~/.emacs.d/site-lisp/paredit/")
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook       (lambda () (paredit-mode +1)))

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;; Set paredit-splice-sexp to C-c M-s in slime
(add-hook 'slime-repl-mode-hook
          (lambda () (local-set-key (kbd "C-c M-s") 'paredit-splice-sexp)))

;; Set "electric return" for ParEdit
(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
return.")
(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
open and indent an empty line between the cursor and the text. Move the
cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))
(add-hook 'lisp-mode-hook
          (lambda () (local-set-key (kbd "RET") 'electrify-return-if-match)))


;; ------------------------- redshank -------------------------

(require 'redshank-loader
         "~/.emacs.d/site-lisp/redshank/redshank-loader")
(eval-after-load "redshank-loader"
  `(redshank-setup '(lisp-mode-hook
                     slime-repl-mode-hook) t))


;; -------------------------- Slime ---------------------------

(add-to-list 'load-path "~/.emacs.d/slime/")
(cond ((eq system-type 'darwin)
       (load (expand-file-name "~/lisp/quicklisp/slime-helper.el")))
      ((eq system-type 'windows-nt)
       (load (expand-file-name "/lisp/quicklisp/slime-helper.el")))
      (t (load (expand-file-name "~/lisp/quicklisp/slime-helper.el"))))
(require 'slime-autoloads)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

(cond ((eq system-type 'darwin) ;; Mac OS Slime setting
       ;; (setq inferior-lisp-program "~/lisp/bin/ccl/dx86cl"
       (setenv "SBCL_HOME" (expand-file-name "~/lisp/bin/sbcl/lib/sbcl"))
       (setq inferior-lisp-program "~/lisp/bin/sbcl/bin/sbcl"
             slime-complete-symbol-function 'slime-fuzzy-complete-symbol
             common-lisp-hyperspec-root "file:///Users/qinaihui/lisp/docs/HyperSpec/"
             slime-startup-animation t))
      ((eq system-type 'windows-nt) ;; Windows Slime setting
       ;;(setq inferior-lisp-program "C:/Lisp/lwp51/lispworks-personal-5-1-1-x86-win32.exe"
       ;;(setq inferior-lisp-program "C:/Lisp/lwp60/lispworks-personal-6-0-1-x86-win32.exe"
       ;;(setq inferior-lisp-program "C:/Lisp/sbcl/1037/sbcl.exe"
       (setq inferior-lisp-program "C:/Lisp/ccl/wx86cl.exe"
             slime-complete-symbol-function 'slime-complete-symbol-function
             common-lisp-hyperspec-root "file:///C:/Lisp/docs/HyperSpec/"))
      (t (setq inferior-lisp-program "/usr/local/bin/sbcl" ;; Other system
               slime-complete-symbol-function 'slime-fuzzy-complete-symbol
               common-lisp-hyperspec-root "~/lisp/docs/HyperSpec/"
               slime-startup-animation t)))

(slime-setup '(slime-fancy slime-banner))


;; Slime info path
(add-to-list 'Info-default-directory-list "~/.emacs.d/slime/doc/")

;; ---------------------- Common Lisp -------------------------
(setq auto-mode-alist
      (append '(
                ("\\.lisp$" . lisp-mode)
                ("\\.lsp$" . lisp-mode)
                ("\\.cl$" . lisp-mode)
                ("\\.asd$" . lisp-mode)
                ("\\.system$" . lisp-mode))
              auto-mode-alist))

(add-hook 'lisp-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)))

;; ------------------------ Emacs Lisp ------------------------
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)))

;; ------------------- Lisp Interaction Mode ------------------
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)))

;; ------------------------- CC-mode --------------------------

(require 'cc-mode)
(add-hook 'cc-mode (lambda ()
                     (setq show-trailing-whitespace t)))


;; ----------------------- Objective-C ------------------------

(setq auto-mode-alist
      (cons '("\\.m$" . objc-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.mm$" . objc-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.h$" . objc-mode) auto-mode-alist))

;; Set my objc-mode hook
(defun my-objc-mode-hook()
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil
        show-trailing-whitespace t)
  (c-set-style "stroustrup"))
(add-hook 'objc-mode-hook 'my-objc-mode-hook)


;; --------------------------- C++ ----------------------------

;; Make .h an extension for C++
;; Currently I set the .h file to objc-mode
;;(setq auto-mode-alist
;;      (cons '("\\.h\\'" . c++-mode)
;;            auto-mode-alist))

;; Make .c an extension for C++
(setq auto-mode-alist
      (cons '("\\.c\\'" . c++-mode)
            auto-mode-alist))

;; Set My C++ mode
(defun my-c++-mode-hook()
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil
        show-trailing-whitespace t)
  (c-set-style "stroustrup")
  (define-key c++-mode-map [f7] 'compile))

;; Hook my C++ mode to c++-mode
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; The variable control the on/off of the auto compilation command for gcc.
;; Replace "nil" with "t" will turn it on
(setq create-gcc-compile-command t)

(defvar g++-other-options "-g -Wall"
  "other options for g++; e.g., -O2")

(defun gcc-compile-command (filename)
  (let* ((program-name (file-name-nondirectory filename))
         (executable-name
          (file-name-sans-extension program-name)))
    (concat "g++ "
            program-name
            " -o "
            executable-name
            " "
            g++-other-options)))

(defadvice compile (before gnu-compilation activate )
  "Automatic setting the compile-command using the form

       g++ <program.cpp> -o <program>

   followed by the value of g++-other-options"
  (interactive
   (if (and create-gcc-compile-command    ;; only if auto-gcc-compile-command
            ;; is non-nil (turn on)
            (equal mode-name "C++/l"))
       (list (read-from-minibuffer
              "Compile command: "
              (gcc-compile-command buffer-file-name)))
     (list (read-from-minibuffer "Compile command: "
                                 compile-command)))))  ;; default otherwise


;; --------------------------- GDB ----------------------------

;; GDB many windows mode
(defvar gdb-many-windows t)
