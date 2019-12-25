;;; init.el --- Just loading the real thing
;;; Fuck the bell sound
(setq ring-bell-function 'ignore)
(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))
(add-to-list 'load-path (expand-file-name
                         "lisp" (expand-file-name
                                 "org" (expand-file-name
                                        "src" dotfiles-dir))))
;; Load up Org Mode and Babel
(require 'org-install)
;; load up the main file
(org-babel-load-file (expand-file-name "config.org" dotfiles-dir))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (doom-nord)))
 '(custom-safe-themes
   (quote
    ("70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" default)))
 '(delete-selection-mode nil)
 '(package-selected-packages
   (quote
    (gnugo go-mode go-snippets flycheck emmet-mode yasnippet-snippets yasnippet company-lsp lsp-ui lsp-mode company elfeed org-re-reveal doom-themes ibuffer-sidebar hide-mode-line doom-modeline dashboard use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
