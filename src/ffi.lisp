(in-package :cl-bgfx)

(defconstant +BGFX-CLEAR-NONE+  #x0000)
(defconstant +BGFX-CLEAR-COLOR+ #x0001)
(defconstant +BGFX-CLEAR-DEPTH+ #x0002)

(defconstant +BGFX-RESET-VSYNC+ #x00000080)
(defconstant +BGFX-DEBUG-TEXT+  #x00000008)

(defcenum renderer-type
  :noop
  :direct3d9
  :direct3d11
  :direct3d12
  :gnm
  :metal
  :opengles
  :opengl
  :vulkan
  :renderer-type-count)
(defctype renderer-type-t renderer-type)

(defcenum access 
  :read
  :write
  :readwrite
  :access-count)
(defctype access-t access)

(defcenum attrib 
  :position
  :normal
  :tangent
  :bitangent
  :color0
  :color1
  :indices
  :weight
  :texcoord0
  :texcoord1
  :texcoord2
  :texcoord3
  :texcoord4
  :texcoord5
  :texcoord6
  :texcoord7
  :attrib-count)
(defctype attrib-t attrib)

(defcenum attrib-type 
  :at-uint8
  :at-uint10
  :at-int16
  :at-half
  :at-float
  :attrib-type-count)
(defctype attrib-type-t attrib-type)

(defcenum texture-format
          :BC1       :BC2       :BC3
          :BC4       :BC5       :BC6H
          :BC7       :ETC1      :ETC2
          :ETC2A     :ETC2A1    :PTC12
          :PTC14     :PTC12A    :PTC14A
          :PTC22     :PTC24

          :UNKNOWN

          :R1        :A8        :R8
          :R8I       :R8U       :R8S
          :R16       :R16I      :R16U
          :R16F      :R16S      :R32I
          :R32U      :R32F      :RG8
          :RG8I      :RG8U      :RG8S
          :RG16      :RG16I     :RG16U
          :RG16F     :RG16S     :RG32I
          :RG32U     :RG32F     :RGB8
          :RGB8I     :RGB8U     :RGB8S
          :RGB9E5F   :BGRA8     :RGBA8
          :RGBA8I    :RGBA8U    :RGBA8S
          :RGBA16    :RGBA16I   :RGBA16U
          :RGBA16F   :RGBA16S   :RGBA32I
          :RGBA32U   :RGBA32F   :R5G6B5
          :RGBA4     :RGB5A1    :RGB10A2
          :R11G11B10F

          :UNKNOWN_DEPTH

          :D16       :D24       :D24S8
          :D32       :D16F      :D24F
          :D32F      :D0S8

          :TEXT-FORMAT-COUNT)
(defctype texture-format-t texture-format)

(defcenum uniform-type
  :int1 :end :vec4 :mat3 :mat4 :uniform-type-count)
(defctype uniform-type-t uniform-type)

(defcenum backbuffer-ratio
  :equal :half :quarter :eighth :sixteenth :double :backbuffer-ratio-count)
(defctype backbuffer-ratio-t backbuffer-ratio)

(defcenum occlusion-query-result
  :invisible :visible :noresult :occlusion-query-result-count)
(defctype occlusion-query-result-t occlusion-query-result)

(defcenum topology-convert
  :tri-list-flip-winding    :tri-list-to-line-list
  :tri-strip-to-tri-list    :lise-strip-to-line-list
  :topology-convert-count)
(defctype topology-convert-t topology-convert)

(defcenum topology-sort
  :direction-front-to-back-mit       :direction- front-to-back-avg
  :direction-front-to-back-max       :direction back-to-front-min
  :direction-back-to-front-avg       :direction-back-to-front-max
  :distance-front-to-back-min        :distance-front-to-back-avg
  :distance-front-to-back-max        :distance-back-to-front-min
  :distance-back-to-front-avg        :distance-back-to-front-max
  :topology-sort-count)
(defctype topology-sort-t topology-sort)

(defmacro bgfx-handle (name)
  (let ((type-name (intern (concatenate 'string (symbol-name name) "-T"))))
    `(progn (defcstruct ,name (idx :uint16))
       (defctype ,type-name (:struct ,name)))))

(bgfx-handle dynamic-index-buffer-handle)
(bgfx-handle dynamic-vertex-buffer-handle)
(bgfx-handle frame-buffer-handle)
(bgfx-handle index-buffer-handle)
(bgfx-handle indirect-buffer-handle)
(bgfx-handle occlusion-query-handle)
(bgfx-handle program-handle)
(bgfx-handle shader-handle)
(bgfx-handle texture-handle)
(bgfx-handle uniform-handle)
(bgfx-handle vertex-buffer-handle)
(bgfx-handle vertex-decl-handle)

;(fli:define-foreign-function release-fn
;    ((ptr :pointer)
;     (userdata :pointer)))
;(fli:define-c-typedef release-fn-t (:pointer release-fn))

(defcstruct memory
  (data (:pointer :uint8))
  (size :uint32))
(defctype memory-t (:struct memory))

(defcstruct transform
  (data (:pointer :float))
  (num :uint16))
(defctype transform-t (:struct transform))

(defcstruct hmd-eye
  (rotation (:array :float 4))
  (translation (:array :float 3))
  (fov (:array :float 4))
  (view-offset (:array :float 3))
  (projection (:array :float 16))
  (pixels-per-tan-angle (:array :float 2)))
(defctype hmd-eye-t (:struct hmd-eye))

(defcstruct hmd
  (eye (:array (:struct hmd-eye) 2))
  (width :uint16)
  (height :uint16)
  (device-width :uint16)
  (device-height :uint16)
  (flags :uint8))
(defctype hmt-t (:struct hmd))

(defcstruct stats
  (cpu-time-begin :uint64)
  (cpu-time-end   :uint64)
  (cpu-timer-freq :uint64)
  (gpu-time-begin :uint64)
  (gpu-time-end   :uint64)
  (gpu-timer-freq :uint64)
  (wait-render :int64)
  (wait-submit :int64)
  (num-draw :uint32)
  (num-compute :uint32)
  (max-gpu-latency :uint32)
  (width :uint16)
  (height :uint16)
  (text-width :uint16)
  (text-height :uint16))
(defctype stats-t (:struct stats))

(defcstruct vertex-decl
  (hash :uint32)
  (stride :uint16)
  (offset (:array :uint16 #.(foreign-enum-value 'attrib-t :attrib-count)))
  (attributes (:array :uint16 #.(foreign-enum-value 'attrib-t :attrib-count))))
(defctype vertex-decl-t (:struct vertex-decl))

(defcstruct transient-index-buffer
  (data (:pointer :uint8))
  (size :uint32)
  (handle (:struct index-buffer-handle))
  (start-index :uint32))
(defctype transient-index-buffer-t (:struct transient-index-buffer))

(defcstruct transient-vertex-buffer
  (data (:pointer :uint8))
  (size :uint32)
  (start-vertex :uint32)
  (stride :uint16)
  (handle (:struct index-buffer-handle))
  (decl (:struct vertex-decl-handle)))
(defctype transient-vertex-buffer-t (:struct transient-vertex-buffer))

(defcstruct instance-data-buffer
  (data (:pointer :uint8))
  (size :uint32)
  (offset :uint32)
  (num :uint32)
  (stride :uint16)
  (handle (:struct vertex-buffer-handle)))
(defctype instance-data-buffer-t (:struct instance-data-buffer))

(defcstruct texture-info
  (format texture-format)
  (storage-size :uint32)
  (width :uint16)
  (height :uint16)
  (depth :uint16)
  (num-layers :uint16)
  (num-mips :uint8)
  (bits-per-pixel :uint8)
  (cube-map :bool))
(defctype texture-info-t (:struct texture-info))

(defcstruct uniform-info
  (name (:array :char 256))
  (type uniform-type)
  (num :uint16))
(defctype uniform-info-t (:struct uniform-info))

(defcstruct attachment
  (handle (:struct texture-handle))
  (mip :uint16)
  (layer :uint16))
(defctype attachment-t (:struct attachment))

(defcstruct caps-gpu
  (vendor-id :uint16)
  (device-id :uint16))
(defctype caps-gpu-t (:struct caps-gpu))

(defcstruct caps-limits
  (max-draw-calls :uint32)
  (max-blits :uint32)
  (max-texture-size :uint32)
  (max-views :uint32)
  (max-frame-buffers :uint32)
  (max-fb-attachments :uint32)
  (max-programs :uint32)
  (max-shaders :uint32)
  (max-textures :uint32)
  (max-texture-samplers :uint32)
  (max-vertex-decls :uint32)
  (max-vertex-streams :uint32)
  (max-index-buffers :uint32)
  (max-vertex-buffers :uint32)
  (max-dynamic-index-buffers :uint32)
  (max-dynamic-vertex-buffers :uint32)
  (max-uniforms :uint32)
  (max-occlusion-queries :uint32))
(defctype caps-limits-t (:struct caps-limits))

(defcstruct caps
  (renderer-type renderer-type)
  (supported :uint64)
  (vendor-id :uint16)
  (device-id :uint16)
  (homogeneous-depth :bool)
  (origin-bottom-left :bool)
  (num-gpus :uint8)
  (gpu (:array (:struct caps-gpu) 4))
  (limits (:struct caps-limits))
  (formats (:array :uint16 #.(foreign-enum-value 'texture-format-t :text-format-count))))
(defctype caps-t (:struct caps))

(defcenum fatal
  fatal-debug-check
  fatal-invalid-shader
  fatal-unable-to-initialize
  fatal-unable-to-create-texture
  fatal-device-lost
  fatal-count)
(defctype fatal-t fatal)

;; Callback interface

(defcstruct callback-vtbl
  (fatal :pointer)
  (trace-vargs :pointer)
  (cache-read-size :pointer)
  (cache-read :pointer)
  (cache-write :pointer)
  (screen-shot :pointer)
  (capture-begin :pointer)
  (capture-end :pointer)
  (capture-frame :pointer))
(defctype callback-vtbl-t (:struct callback-vtbl))

(defcstruct callback-interface
  (vtbl (:pointer (:struct callback-vtbl))))
(defctype callback-interface-t (:struct callback-interface))

(defcstruct allocator-vtbl
  (realloc :pointer))
(defctype allocator-vtbl-t (:struct allocator-vtbl))

(defcstruct allocator-interface
  (vtbl (:pointer allocator-vtbl-t)))
(defctype allocator-interface-t (:struct allocator-interface))



(defcstruct platform-data
  (ndt :pointer)                ; native display type
  (nwh :pointer)                ; native window handle
  (context :pointer)            ; gl context or d3d device
  (back-buffer :pointer)        ; gl backbuffer or d3d render target view
  (back-buffer-ds :pointer)     ; backbuffer depth/stencil
  (session :pointer))           ; ovr session for Oculus SDK
(defctype platform-data-t (:struct platform-data))

;;;;;;;;;;;;; BGFX-C-API

;(fli:register-module :bgfx :real-name "bgfx.dll" :connection-style :immediate)
(define-foreign-library bgfx (t (:default "bgfx")))
(use-foreign-library bgfx)

(defcfun ("bgfx_set_platform_data" set-platform-data) :void
    (data (:pointer platform-data-t)))

(defcfun ("bgfx_vertex_decl_begin" vertex-decl-begin) :void
    (decl (:pointer vertex-decl-t))
    (renderer renderer-type-t))

(defcfun ("bgfx_vertex_decl_add" vertex-decl-add) :void
  (decl (:pointer vertex-decl-t))
  (attrib attrib-t)
  (num :uint8)
  (type attrib-type-t)
  (normalized :boolean)
  (as-int :boolean))

(defcfun ("bgfx_vertex_decl_skip" vertex-decl-skip) :void
    (decl (:pointer vertex-decl-t))
    (num :uint8))

(defcfun ("bgfx_vertex_decl_end" vertex-decl-end) :void
    (decl (:pointer vertex-decl-t)))

(defcfun ("bgfx_vertex_pack" vertex-pack) :void
  (input (:array :float 4))
  (input-normalized :boolean)
  (attr attrib-t)
  (decl (:pointer vertex-decl-t))
  (data :pointer) ;; void*
  (index :uint32))

(defcfun ("bgfx_vertex_unpack" vertex-unpack) :void
  (output (:array :float 4))
  (attr attrib-t)
  (decl (:pointer vertex-decl-t))
  (data :pointer) ;; void*
  (index :uint32))

(defcfun ("bgfx_vertex_convert" vertex-convert) :void
    (dest-decl (:pointer vertex-decl-t))
    (dest-data :pointer) ;; void*
    (src-decl (:pointer vertex-decl-t))
    (src-data :pointer) ;; void*
    (num :uint32))

(defcfun ("bgfx_weld_vertices" weld-vertices) :uint16
  (output (:pointer :uint16))
  (decl (:pointer vertex-decl-t))
  (data :pointer) ;; void*
  (num :uint16)
  (epsilon :float))

(defcfun  ("bgfx_topology_convert" topology-convert) :uint32
  (convertsion topology-convert-t)
  (dst :pointer) ;; void*
  (dst-size :uint32)
  (indices :pointer) ;; void*
  (num-indices :uint32)
  (index32 :boolean))
 
(defcfun ("bgfx_topology_sort_tri_list" topology-sort-tri-list) :void
  (sort topology-sort-t)
  (dst :pointer)
  (dst-size :uint32)
  (dir (:array :float 3))
  (pos (:array :float 3))
  (vertices :pointer)
  (stride :uint32)
  (indices :pointer)
  (num-indices :uint32)
  (index32 :boolean))

(defcfun ("bgfx_image_swizzle_bgra8" image-swizzle-bgra8) :void
  (dst :pointer)
  (width :uint32)
  (height :uint32)
  (pitch :uint32)
  (src :pointer))

(defcfun ("bgfx_image_rgba_downsample_2x2" image-rgba-downsample-2x2) :void
  (dst :pointer)
  (width :uint32)
  (height :uint32)
  (pitch :uint32)
  (src :pointer))

(defcfun ("bgfx_get_supported_renderers" get-supported-renderers) :uint8
    (max :uint8)
    (enum renderer-type-t))

(defcfun ("bgfx_get_renderer_name" get-renderer-name) (:pointer :char)
  (type renderer-type-t))

(defcfun ("bgfx_get_renderer_type" get-renderer-type) renderer-type)

(defcfun ("bgfx_init" init) :bool
    (type renderer-type-t)
    (venfor-id :uint16)
    (device-id :uint16)
    (callback :pointer)
    (allocator :pointer))

(defcfun ("bgfx_shutdown" bgfx-shutdown) :void)

(defcfun ("bgfx_set_view_clear" set-view-clear) :void
  (id :uint8)
  (flags :uint8)
  (rgba :uint32)
  (depth :float)
  (stencil :uint8))

(defcfun ("bgfx_reset" reset) :void
  (width :uint32)
  (height :uint32)
  (flags :uint32))

(defcfun ("bgfx_render_frame" render-frame) :void)

(defcfun ("bgfx_set_view_rect" set-view-rect) :void
  (id :uint8)
  (x :uint16)
  (y :uint16)
  (width :uint16)
  (height :uint16))

(defcfun ("bgfx_touch" touch) :uint32
  (id :uint8))

(defcfun ("bgfx_set_debug" set-debug) :void
  (debug :uint32))

(defcfun ("bgfx_dbg_text_clear" dbg-text-clear) :void
  (attr :uint8)
  (small :boolean))

(defcfun ("bgfx_dbg_text_printf" dbg-text-printf) :void
  (x :uint16)
  (y :uint16)
  (attr :uint8)
  (format (:pointer :string))
  &rest)

(defcfun ("bgfx_frame" frame) :uint32
  (capture :boolean))

(defcfun ("bgfx_get_stats" get-stats) (:pointer stats-t))

(defcfun ("bgfx_dbg_text_image" dbg-text-image) :void
  (x :uint16)
  (y :uint16)
  (width :uint16)
  (height :uint16)
  (data :pointer)
  (pitch :uint16))

(defcfun ("bgfx_make_ref" make-ref) (:pointer memory-t)
         (data :pointer)
         (size :uint32))
         
(defcfun ("bgfx_create_vertex_buffer" create-vertex-buffer) (:pointer (:struct vertex-buffer-handle))
  (mem (:pointer memory-t))
  (decl (:pointer vertex-decl-t))
  (flags :uint16))

(defcfun ("bgfx_create_index_buffer" create-index-buffer) (:pointer (:struct index-buffer-handle))
  (mem (:pointer memory-t))
  (flags :uint16))

(defcfun ("bgfx_create_shader" create-shader) (:pointer (:struct shader-handle))
  (mem (:pointer memory-t)))

(defcfun ("bgfx_create_program" create-program) (:pointer (:struct program-handle))
  (vsh (:pointer shader-handle-t))
  (fsh (:pointer shader-handle-t))
  (destroy-shader :boolean))

(let ((pack (find-package :cl-bgfx)))
  (do-all-symbols (sym pack) (when (eql (symbol-package sym) pack) (export sym))))