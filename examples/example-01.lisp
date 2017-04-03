(defpackage #:example-01
  (:use #:cl #:cl-bgfx #:cffi #:cl-interpol)
  (:documentation "Basic example")
  (:export :run :init-bgfx-capi)
  (:import-from plus-c #:& #:*))

(in-package :example-01)

(eval-when (:compile-toplevel :execute :load-toplevel)
  (enable-interpol-syntax))

(defparameter *win* nil)

(cffi:defcallback event-filter :int ((userdata :pointer)
                                     (sdl-event-ptr :pointer))
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
        (c (foreign-string-alloc #?"Color can be changed with ANSI \x1b[9;me\x1b[10;ms\x1b[11;mc\x1b[12;ma\x1b[13;mp\x1b[14;me\x1b[0m code too." :encoding :ascii))
        (d (foreign-string-alloc #?"Backbuffer %dW x %dH in pixels, debug text %dW x %dH in characters.")))
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
        (dbg-text-printf 0 6 #x0f d :int width :int height :int text-width :int text-height))
             
      (frame nil))))

(defun run ()
  (sdl2:with-init (:video)
    (sdl2:with-window (window :title "Foo" :w 640 :h 480 :flags '(:resizable))
      (with-foreign-objects (
             (callback '(:struct callback-interface))
             (allocator '(:struct allocator-interface))
             (p-data '(:struct platform-data)))
      (let ((wm-info (sdl2:get-window-wm-info window)))
        (progn
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
               (bgfx-shutdown)
               t))
            (:idle () (render-loop)))))))))
