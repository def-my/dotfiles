; ロードパス
;; ~/.emacs.d/elisp ディレクトリをロードパスに追加する
;; Emacs23以前用
(when (> emacs-major-version 23)
    (defvar user-emacs-directory "~/.emacs.d"))
;; load-path を追加する関数
(defun add-to-load-path (&rest paths)
    (let (path)
        (dolist (path paths paths)
            (let ((default-directory
                    (expand-file-name (concat user-emacs-directory path))))
              (add-to-list 'load-path default-directory)
              (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
                  (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリをload-path に追加
(add-to-load-path "elisp" "conf" "public_repos")

; 基本設定
(load "init-general")

; site-lisp
;; haskell 用の設定ファイルを読み込み
(load "init-haskell")