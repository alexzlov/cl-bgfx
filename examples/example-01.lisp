(defpackage #:example-01
  (:use #:cl #:cl-bgfx #:cffi)
  (:documentation "Basic example")
  (:export :run :init-bgfx-capi)
  (:import-from plus-c #:& #:*))

(in-package :example-01)

(defparameter *so* *standard-output*)

(defun init-bgfx (sdl-window width height)
  (sdl2:in-main-thread ()
    (with-foreign-objects ((callback '(:struct callback-interface))
                           (allocator '(:struct allocator-interface))
                           (p-data '(:struct platform-data)))
      (let ((wm-info (sdl2:get-window-wm-info sdl-window)))
        (progn
          (setf (foreign-slot-value callback '(:struct callback-interface) 'vtbl) (null-pointer))
          (setf (foreign-slot-value allocator '(:struct allocator-interface) 'vtbl) (null-pointer))
          (with-foreign-slots ((ndt nwh context back-buffer back-buffer-ds) p-data (:struct platform-data))
            (setf ndt nil
                  nwh (getf wm-info :window)
                  context nil
                  back-buffer nil
                  back-buffer-ds nil))
          (set-platform-data p-data)
          (render-frame)
          (init (foreign-enum-value 'renderer-type :opengl) 0 0 callback allocator)
          (reset width height +bgfx-reset-vsync+))))))




(defun draw ()
  (progn
    (touch 0)
    (dbg-text-clear 0 nil)
    (dbg-text-printf 0 1 #x4f "Lisp bgfx test...")
    (dbg-text-printf 0 2 #x6f "Initialization and debug text test...")
    (frame nil)))
         
(cffi:defcallback event-filter :int ((userdata :pointer)
                                     (sdl-event-ptr :pointer))
  (plus-c:c-let ((sdl-event sdl2-ffi:sdl-event :from sdl-event-ptr))
    (let* ((event (sdl2:get-event-type sdl-event)))
      (if (or (eql event :resized) (eql event :size-changed) (eql event :windowevent))
          (capi:contain (make-instance 'capi:message-pane))
        (capi:contain (make-instance 'capi:message-pane :title (symbol-name event))))
      1)))

(defun run ()
  (let ((width 640)
        (height 480))
    (sdl2:with-init (:video)
      (sdl2:with-window (window :title "Foo" :w width :h height :flags '(:resizable))
        ;(sdl2-ffi.functions:sdl-set-event-filter (autowrap:callback 'cb) nil)
        (init-bgfx window 640 480)
        (set-debug +bgfx-debug-text+)
        (set-view-clear 0 (logior +bgfx-clear-color+ +bgfx-clear-depth+) #x303030ff 1.0 0)
        (set-view-rect 0 0 0 640 480)
        (sdl2:with-event-loop (:method :poll)
          (:quit () t)
          (:windowevent (:event raw-event :data1 d1 :data2 d2)
           (let ((event (autowrap:enum-key 'sdl2-ffi:sdl-window-event-id raw-event)))
             (when (or (eql event :resized) (eql event :size-changed))
               (progn
                 (sdl2:set-window-size window d1 d2)
                 (reset d1 d2 +bgfx-reset-vsync+)
                 (set-view-rect 0 0 0 d1 d2)
                 (draw)
                 ))))
          (:idle () (draw)))
        (bgfx-shutdown)
        ))))
    
