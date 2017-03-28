(defpackage #:example-01
  (:use #:cl #:fli #:cl-bgfx-ffi #:cl-bgfx-consts)
  (:documentation "Basic example")
  (:export :run))

(in-package :example-01)

(defun run ()
  (sdl2:with-init (:video)
    (sdl2:with-window (window :title "Foo" :w 640 :h 480)
      (let* (
             (callback (fli:allocate-foreign-object :type 'callback-interface))
             (allocator (fli:allocate-foreign-object :type 'allocator-interface))
             (p-data (fli:allocate-foreign-object :type 'platform-data))
             (wm-info (sdl2:get-window-wm-info window)))
        (progn
          (setf (fli:foreign-slot-value callback 'vtbl) fli:*null-pointer*)
          (setf (fli:foreign-slot-value allocator 'vtbl) fli:*null-pointer*)
          (fli:with-foreign-slots (ndt nwh context back-buffer back-buffer-ds) p-data
            (setf ndt nil
                  nwh (getf wm-info :window)
                  context nil
                  back-buffer nil
                  back-buffer-ds nil))

          (set-platform-data p-data)
          (render-frame)
          (init 'opengl 0 0 nil nil)
          (reset 640 480 +bgfx-reset-vsync+)
          (set-debug +bgfx-debug-text+)
          (set-view-clear 0 (logior #x0001 #x0002) #x303030ff 1.0 0)
          (sdl2:with-event-loop (:method :poll)
            (:quit () t)
            (:idle ()
             (progn (set-view-rect 0 0 0 640 480)
               (touch 0)
               (dbg-text-clear 0 nil)
               (dbg-text-printf 0 1 #x4f "Lisp bgfx test...")
               (dbg-text-printf 0 2 #x6f "Initialization and debug text test...")
               (frame nil)
               )))
          (bgfx-shutdown)                              
          )))))