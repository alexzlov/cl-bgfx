;;;; cl-gbfx.asd

(asdf:defsystem #:cl-bgfx
  :description "Bindings to the famous platform-agnostic rendering library"
  :author "alex zlov <zlov.ehl@gmail.com>"
  :license "MIT"
  :depends-on (#:sdl2
               #:bordeaux-threads
               #:cffi)
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "cl-bgfx")
               (:file "ffi")))

(asdf:defsystem #:cl-bgfx/examples
  :description "CL-BGFX examples ported from original bgfx examples"
  :author "alex zlov <zlov.ehl@gmail.com>"
  :license "MIT"
  :depends-on (#:sdl2
               #:bordeaux-threads
               #:cl-bgfx
               #:cl-interpol)
  :pathname "examples"
  :serial t
  :components ((:file "example-01")
               (:file "example-02")))

(defpackage #:bgfx-config (:export #:*base-directory* #:*shaders-directory*))
(defparameter bgfx-config:*base-directory*
  (make-pathname :name nil :type nil :defaults *load-truename*))
(defparameter bgfx-config:*shaders-directory*
  (merge-pathnames #p"shaders/" bgfx-config:*base-directory*))