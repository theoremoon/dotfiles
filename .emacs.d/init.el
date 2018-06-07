;;;
;;; (setq sym val) is (set 'sym val)
;;; auto-mode-alist is map for ext and mode
;;; (interactive) specifies this function is a command.


;;; use package.el
(require 'package)
;; Add melpa to package repos
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;; load other files
;(setq settings-dir (expand-file-name "lisp" user-emacs-directory))
;(add-to-list 'load-path settings-dir)

;;; basic settings
(prefer-coding-system 'utf-8-unix)
(global-font-lock-mode t)

(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(show-paren-mode 1)
(global-hl-line-mode -1)
(display-time)

(line-number-mode t)
(column-number-mode t)
(global-linum-mode t)
(setq linum-format "%4d \u2502 ")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; package install function
(defun packages-install (packages)
  (dolist (pkg packages)
    (when (not (package-installed-p pkg))
      (package-install pkg)))
  (delete-other-windows))

;; install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(ido  ;; built-in completion interface
     smex   ;; ido on M-x
     ido-completing-read+  ;; more everywhere ido
     ido-vertical-mode
     flx
     flx-ido

     ivy  ;; macher interface
     counsel  ;; ivy on M-x
     swiper  ;; ivy on C-s
     find-file-in-project
     recentf  ;; most recent used files

     dumb-jump  ;; jump to definition

;     git-complete  ;; completion on git managed project
     

     expand-region  ;; interactively expand selection
     popup-kill-ring
     popup
     pos-tip

     yasnippet
     company

     flycheck
     flycheck-pos-tip

     magit
     wgrep
     paredit
     smartparens

     d-mode
     company-dcd

     monokai-theme
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


;;; ido
;(require 'ido)
;(ido-mode t)
;(ido-everywhere t)
;(setq ido-enable-flex-matching t)  ;; fuzzy matching
;
;(require 'ido-completing-read+)
;(ido-ubiquitous-mode t)
;
;(require 'ido-vertical-mode)
;(ido-vertical-mode 1)
;
;(require 'flx)
;(require 'flx-ido)
;(flx-ido-mode 1)
;
;(require 'smex)
;(global-set-key (kbd "M-x") 'smex)

;;; ivy
(require 'ivy)
(require 'swiper)
(require 'counsel)
(require 'flx)

(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)

(setq ivy-re-builders-alist
      '((swiper . ivy--regex-fuzzy)
        (t . ivy--regex-plus)))

;;; git-complete
;(require 'git-complete)
;(global-set-key (kbd "S-SPC") 'git-complete)


;;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)

;;; popup-kill-ring
(require 'popup-kill-ring)
(global-set-key (kbd "M-y") 'popup-kill-ring)

;;; yasnippet
;(require 'yasnippet)
;(yas-global-mode t)

;;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-M-i") 'company-complete)  ;; actually, Meta-Tab
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)


;;; hippie-expand[built-in] abbrev completion
(global-set-key (kbd "M-SPC ") 'hippie-expand)

;;; paredit
(require 'paredit)

;;; smartparens
(require 'smartparens-config)


;;; useful functions
(defun delete-this-file ()
  "Delete current editing file, and kill buffer"
  (interactive) 
  (unless (buffer-file-name)
    (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete %s?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))

;;; color-theme
(load-theme 'monokai t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (git-complete dumb-jump dump-jump recenf find-file-in-project counsel company-dcd d-mode monokai-theme yasnippet whitespace-cleanup-mode wgrep visual-regexp smex smartparens popup-kill-ring paredit multiple-cursors markdown-mode magit ido-vertical-mode ido-completing-read+ ido-at-point hydra htmlize guide-key flycheck-pos-tip flx-ido f expand-region company browse-kill-ring))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; language specific settings
(require 'd-mode)
(require 'company-dcd)
(add-hook 'd-mode-hook 'company-dcd-mode)
