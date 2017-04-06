;;;; cl-gbfx.lisp

(in-package #:cl-bgfx)
(use-package :bgfx-config :cffi)

;; Loads shader into bgfx structure bgfx_memory
;; and returns pointer to it.
(defun load-shader (name)
  (let* ((current-renderer 
          (concatenate 'string 
                       (string-downcase (symbol-name (get-renderer-type))) "/"))
         (shaders-dir *shaders-directory*)
         (shader-dir (merge-pathnames current-renderer shaders-dir))
         (shader-path (merge-pathnames name shader-dir)))
    
    (let ((shader-data (with-open-file (stream shader-path)
                        (let ((data (make-string (file-length stream))))
                          (read-sequence data stream)
                          data))))
      (with-foreign-object (shader-memory '(:struct memory))
        (with-foreign-slots ((data size)  shader-memory (:struct memory))
          (setf data (foreign-string-alloc shader-data)
                size (length shader-data))
          (create-shader shader-memory))))))

(defun create-shader-program (vertex-shader-name fragment-shader-name)
  (let ((vs (load-shader vertex-shader-name))
        (fs (load-shader fragment-shader-name)))
    (create-program vs fs t)))
    
   
  

