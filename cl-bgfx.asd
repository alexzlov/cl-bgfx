;;;; cl-gbfx.asd

(asdf:defsystem #:cl-bgfx
  :description "Bindings to the famous platform-agnostic rendering library"
  :author "alex zlov <zlov.ehl@gmail.com>"
  :license "MIT"
  :depends-on (#:sdl2
               #:bordeaux-threads)
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "cl-bgfx")
               (:file "ffi")
               (:file "constants")))

(asdf:defsystem #:cl-bgfx/examples
	:description "CL-BGFX examples ported from original bgfx examples"
	:author "alex zlov <zlov.ehl@gmail.com>"
	:license "MIT"
	:depends-on (#:sdl2
				 #:bordeaux-threads
				 #:cl-bgfx)
	:pathname "examples"
	:serial t
	:components ((:file "example-01")))