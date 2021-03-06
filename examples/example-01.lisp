(defpackage #:example-01
  (:use #:cl #:cl-bgfx #:cffi #:cl-interpol)
  (:documentation "Basic example")
  (:export :run)
  (:import-from plus-c #:& #:*))

(in-package :example-01)

(defparameter *logo* #(
        #xdc #x03 #xdc #x03 #xdc #x03 #xdc #x03 #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;; ........ . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #xdc #x08 ;;  . . . . . . ...
	#xdc #x03 #xdc #x07 #xdc #x07 #xdc #x08 #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;; ........ . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#xde #x03 #xb0 #x3b #xb1 #x3b #xb2 #x3b #xdb #x3b #x20 #x0f #x20 #x0f #x20 #x0f ;; ...;.;.;.; . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #xdc #x03 #xb1 #x3b #xb2 #x3b ;;  . . . . ....;.;
	#xdb #x3b #xdf #x03 #xdf #x3b #xb2 #x3f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;; .;...;.? . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #xb1 #x3b #xb1 #x3b #xb2 #x3b #xb2 #x3f #x20 #x0f #x20 #x0f #x20 #x0f ;;  ..;.;.;.? . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #xb1 #x3b #xb1 #x3b #xb2 #x3b ;;  . . . . ..;.;.;
	#xb2 #x3f #x20 #x0f #x20 #x0f #xdf #x03 #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;; .? . ... . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #xb1 #x3b #xb1 #x3b #xb1 #x3b #xb1 #x3f #xdc #x0b #xdc #x03 #xdc #x03 ;;  ..;.;.;.?......
	#xdc #x03 #xdc #x03 #x20 #x0f #x20 #x0f #xdc #x08 #xdc #x03 #xdc #x03 #xdc #x03 ;; .... . .........
	#xdc #x03 #xdc #x03 #xdc #x03 #xdc #x08 #x20 #x0f #xb1 #x3b #xb1 #x3b #xb1 #x3b ;; ........ ..;.;.;
	#xb1 #x3f #xb1 #x3f #xb2 #x0b #x20 #x0f #x20 #x0f #xdc #x03 #xdc #x03 #xdc #x03 ;; .?.?.. . .......
	#x20 #x0f #x20 #x0f #xdc #x03 #xdc #x03 #xdc #x03 #x20 #x0f #x20 #x01 #x20 #x0f ;;  . ....... . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #xb2 #x3b #xb1 #x3b #xb0 #x3b #xb0 #x3f #x20 #x0f #xde #x03 #xb0 #x3f ;;  ..;.;.;.? ....?
	#xb1 #x3f #xb2 #x3f #xdd #x03 #xde #x03 #xdb #x03 #xdb #x03 #xb2 #x3f #x20 #x0f ;; .?.?.........? .
	#x20 #x0f #xb0 #x3f #xb1 #x3f #xb2 #x3f #xde #x38 #xb2 #x3b #xb1 #x3b #xb0 #x3b ;;  ..?.?.?.8.;.;.;
	#xb0 #x3f #x20 #x0f #x20 #x0f #x20 #x0f #xb0 #x3b #xb1 #x3b #xb2 #x3b #xb2 #x3f ;; .? . . ..;.;.;.?
	#xdd #x03 #xde #x03 #xb0 #x3f #xb1 #x3f #xb2 #x3f #xdd #x03 #x20 #x01 #x20 #x0f ;; .....?.?.?.. . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #xb2 #x3b #xb1 #x3b #xb0 #x3b #xb0 #x3f #x20 #x0f #x20 #x0f #xdb #x03 ;;  ..;.;.;.? . ...
	#xb0 #x3f #xb1 #x3f #xdd #x03 #xb1 #x3b #xb0 #x3b #xdb #x03 #xb1 #x3f #x20 #x0f ;; .?.?...;.;...? .
	#x20 #x0f #x20 #x3f #xb0 #x3f #xb1 #x3f #xb0 #x3b #xb2 #x3b #xb1 #x3b #xb0 #x3b ;;  . ?.?.?.;.;.;.;
	#xb0 #x3f #x20 #x0f #x20 #x0f #x20 #x0f #xdc #x08 #xdc #x3b #xb1 #x3b #xb1 #x3f ;; .? . . ....;.;.?
	#xb1 #x3b #xb0 #x3b #xb2 #x3b #xb0 #x3f #xdc #x03 #x20 #x0f #x20 #x01 #x20 #x0f ;; .;.;.;.?.. . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #xb2 #x3b #xb1 #x3b #xb0 #x3b #xb0 #x3f #xdc #x0b #xdc #x07 #xdb #x03 ;;  ..;.;.;.?......
	#xdb #x03 #xdc #x38 #x20 #x0f #xdf #x03 #xb1 #x3b #xb0 #x3b #xb0 #x3f #xdc #x03 ;; ...8 ....;.;.?..
	#xdc #x07 #xb0 #x3f #xb1 #x3f #xb2 #x3f #xdd #x3b #xb2 #x3b #xb1 #x3b #xdc #x78 ;; ...?.?.?.;.;.;.x
	#xdf #x08 #x20 #x0f #x20 #x0f #xde #x08 #xb2 #x3b #xb1 #x3b #xb0 #x3b #xb0 #x3f ;; .. . ....;.;.;.?
	#x20 #x0f #xdf #x03 #xb1 #x3b #xb2 #x3b #xdb #x03 #xdd #x03 #x20 #x01 #x20 #x0f ;;  ....;.;.... . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #xdc #x08 #xdc #x08 #xdc #x08 #x20 #x0f ;;  . . . ....... .
	#x20 #x0f #xb0 #x3f #xb0 #x3f #xb1 #x3f #xdd #x3b #xdb #x0b #xdf #x03 #x20 #x0f ;;  ..?.?.?.;.... .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #xdf #x08 #xdf #x03 #xdf #x03 #xdf #x08 ;;  . . . .........
	#x20 #x0f #x20 #x0f #xdf #x08 #xdf #x03 #xdf #x03 #x20 #x0f #x20 #x01 #x20 #x0f ;;  . ....... . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #xdb #x08 #xb2 #x38 #xb1 #x38 #xdc #x03 ;;  . . . ....8.8..
	#xdc #x07 #xb0 #x3b #xb1 #x3b #xdf #x3b #xdf #x08 #x20 #x0f #x20 #x0f #x20 #x0f ;; ...;.;.;.. . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b ;;  . . . . . . . .
	#x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0b #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x2d #x08 #x3d #x08 #x20 #x0a #x43 #x0b #x72 #x0b #x6f #x0b #x73 #x0b #x73 #x0b ;; -.=. .C.r.o.s.s.
	#x2d #x0b #x70 #x0b #x6c #x0b #x61 #x0b #x74 #x0b #x66 #x0b #x6f #x0b #x72 #x0b ;; -.p.l.a.t.f.o.r.
	#x6d #x0b #x20 #x0b #x72 #x0b #x65 #x0b #x6e #x0b #x64 #x0b #x65 #x0b #x72 #x0b ;; m. .r.e.n.d.e.r.
	#x69 #x0b #x6e #x0b #x67 #x0b #x20 #x0b #x6c #x0b #x69 #x0b #x62 #x0b #x72 #x0b ;; i.n.g. .l.i.b.r.
	#x61 #x0b #x72 #x0b #x79 #x0b #x20 #x0f #x3d #x08 #x2d #x08 #x20 #x01 #x20 #x0f ;; a.r.y. .=.-. . .
	#x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a ;;  . . . . . . . .
	#x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a ;;  . . . . . . . .
	#x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a ;;  . . . . . . . .
	#x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a ;;  . . . . . . . .
	#x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a #x20 #x0a ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
	#x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f #x20 #x0f ;;  . . . . . . . .
))

(defparameter *logo-ptr* nil)

(eval-when (:compile-toplevel :execute :load-toplevel)
  (enable-interpol-syntax))

(defparameter *win* nil)

(cffi:defcallback event-filter :int ((userdata :pointer)
                                     (sdl-event-ptr :pointer))
  (declare (ignore userdata))
   (plus-c:c-let ((sdl-event sdl2-ffi:sdl-event :from sdl-event-ptr))
      (let ((event-type (sdl2:get-event-type sdl-event)))
        (if (eql event-type :windowevent)
            (multiple-value-bind (x y) (sdl2:get-window-size *win*)
              (progn 
                (reset x y +bgfx-reset-vsync+)
                (set-view-rect 0 0 0 x y)
                (render-loop)
                0))
          1))))

(defun render-loop ()
  (let ((a (foreign-string-alloc "Lisp bgfx test..."))
        (b (foreign-string-alloc "Initialization and debug text test..."))
        (c (foreign-string-alloc #?"Color can be changed with ANSI \x1b[9;me\x1b[10;ms\x1b[11;mc\x1b[12;ma\x1b[13;mp\x1b[14;me\x1b[0m code too."))
        (d (foreign-string-alloc #?"Backbuffer %dW x %dH in pixels, debug text %dW x %dH in characters."))
        (e (foreign-string-alloc (symbol-name (get-renderer-type)))))
    (progn
      (touch 0)
      (dbg-text-clear 0 nil)
      (dbg-text-printf 0 1 #x4f a)
      (dbg-text-printf 0 2 #x6f b)
      (dbg-text-printf 0 4 #x0f c)
      (let* ((bgfx-stats (get-stats))
             (width (foreign-slot-value bgfx-stats '(:struct stats) 'width))
             (height (foreign-slot-value bgfx-stats '(:struct stats) 'height))
             (text-width (foreign-slot-value bgfx-stats '(:struct stats) 'text-width))
             (text-height (foreign-slot-value bgfx-stats '(:struct stats) 'text-height)))
        (dbg-text-printf 0 6 #x0f d :int width :int height :int text-width :int text-height)
        (dbg-text-printf 0 7 #x0f e)
        (dbg-text-image 
         (round (* (- (max (/ (/ width 2) 8) 20) 20) 1.0))
         (round (* (- (max (/ (/ height 2) 16) 6) 6) 1.0))
         40  12 *logo-ptr* 160))             
        (frame nil))))

(defun run ()
  (sdl2:with-init (:video)
    (sdl2:with-window (window :title "Example01: Intro" :w 640 :h 480 :flags '(:resizable))
      (with-foreign-objects (
             (callback '(:struct callback-interface))
             (allocator '(:struct allocator-interface))
             (p-data '(:struct platform-data)))
      (let ((wm-info (sdl2:get-window-wm-info window)))
        (progn
          (setf *logo-ptr* (foreign-alloc :uint8 :initial-contents *logo*))
          (setf *win* window)
          (sdl2-ffi.functions:sdl-set-event-filter (cffi:callback event-filter) nil)
          (setf (foreign-slot-value callback '(:struct callback-interface) 'vtbl)
                (null-pointer))
          (setf (foreign-slot-value allocator '(:struct allocator-interface) 'vtbl) 
                (null-pointer))
          (with-foreign-slots ((ndt nwh context back-buffer back-buffer-ds)
                               p-data (:struct platform-data))
            (setf ndt nil
                  nwh (getf wm-info :window)
                  context nil
                  back-buffer nil
                  back-buffer-ds nil))

          (set-platform-data p-data)
          (render-frame)
          (init :opengl 0 0 nil nil)
          (reset 640 480 +bgfx-reset-vsync+)
          (set-debug +bgfx-debug-text+)
          (set-view-clear 0 (logior +BGFX-CLEAR-COLOR+ +BGFX-CLEAR-DEPTH+) #x303030ff 1.0 0)
          (set-view-rect 0 0 0 640 480)
          (sdl2:with-event-loop (:method :poll)
            (:quit ()
             (progn
               (sdl2-ffi.functions:sdl-set-event-filter (null-pointer) nil)
               (foreign-free *logo-ptr*)
               (bgfx-shutdown)
               t))
            (:idle () (render-loop)))))))))
