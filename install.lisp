(load (merge-pathnames (user-homedir-pathname) "quicklisp.lisp"))

(quicklisp-quickstart:install)

(with-open-file (stream (merge-pathnames (merge-pathnames (user-homedir-pathname) ".sbclrc"))
                        :direction :output :if-exists :append
                        :if-does-not-exist :create)
  (write `(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                                 (user-homedir-pathname))))
            (when (probe-file quicklisp-init)
              (load quicklisp-init)))
         :stream stream))
