(defpackage #:cl-bgfx-consts
	(:use #:cl)
	(:export +BGFX-RESET-VSYNC+
			 +BGFX-DEBUG-TEXT+))

(in-package :cl-bgfx-consts)

(defconstant +BGFX-RESET-VSYNC+ #x00000080)
(defconstant +BGFX-DEBUG-TEXT+  #x00000008)