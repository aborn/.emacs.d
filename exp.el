
(defvar ab/debug-helm-file "~/.emacs.d/debugonly")
(defvar ab/debug-helm nil)

(when (file-readable-p ab/debug-helm-file)
  (load-file ab/debug-helm-file))

(debug-on-entry 'helm-adaptive-sort)
(debug-on-entry 'helm-adapt-use-adaptive-p)

(debug-on-entry 'helm-adaptive-save-history)

(debug-on-entry 'helm-adaptive-maybe-load-history)


(defun ab/demo-fun (arg)
  (message (format "arg=%s" arg)))

(defun ab/debug-demo ()
  (interactive)
  (ab/demo-fun "good"))

(defun ab/debug-json ()
  (interactive)
  (message (json-encode '(:a "b"))))

(defun ab/ivy-read-example ()
  "Elisp completion at point."
  (interactive)
  (let* ((bnd (bounds-of-thing-at-point 'symbol))
         (str (buffer-substring-no-properties (car bnd) (cdr bnd)))
         (candidates (all-completions str obarray))
         (ivy-height 7)
         (res (ivy-read (format "pattern (%s): " str)
                        candidates)))
    (when (stringp res)
      (delete-region (car bnd) (cdr bnd))
      (insert res))))

(defun ab/get-ivy-test-list (key)
  ""
  (interactive)
  (if (string-equal key "ab")
      (list '("fff" "ggg" "hhh"))
    (list '("kkk" "mmm"))))

(defun ab/ivy-read-test ()
  ""
  (interactive)
  (ivy-read (format "input key:")
            (ab/get-ivy-test-list )))

(defun counsel-package-install ()
  (interactive)
  (ivy-read "Install package: "
            (delq nil
                  (mapcar (lambda (elt)
                            (unless (package-installed-p (car elt))
                              (symbol-name (car elt))))
                          package-archive-contents))
            :action (lambda (x)
                      (package-install (intern x)))
            :caller 'counsel-package-install))

;; (global-set-key (kbd "M-p") 'display-prefix)
(defun display-prefix (arg)
  "Display the value of the raw prefix arg."
  (interactive "P")
  (if (equal current-prefix-arg '(4))
      (message "ggg")
    (message "kkk"))
  (message "%s%s" arg current-prefix-arg))
