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
