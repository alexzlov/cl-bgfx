(defpackage #:cl-bgfx-ffi
  (:use #:cl #:fli))

(in-package :cl-bgfx-ffi)

(fli:define-c-enum renderer-type
  noop
  direct3d9
  direct3d11
  direct3d12
  gnm
  metal
  opengles
  opengl
  vulkan
  renderer-type-count)
(fli:define-c-typedef renderer-type-t (:enum renderer-type))

(fli:define-c-enum access read
  write
  readwrite
  access-count)
(fli:define-c-typedef access-t (:enum access))

(fli:define-c-enum attrib position
  normal
  tangent
  bitangent
  color0
  color1
  indices
  weight
  texcoord0
  texcoord1
  texcoord2
  texcoord3
  texcoord4
  texcoord5
  texcoord6
  texcoord7
  attrib-count)
(fli:define-c-typedef attrib-t (:enum attrib))

(fli:define-c-enum attrib-type 
  uint8
  uint10
  int16
  half
  float
  attrib-type-count)
(fli:define-c-typedef attrib-type-t (:enum attrib-type))

(fli:define-c-enum texture-format
          BC1       BC2       BC3
          BC4       BC5       BC6H
          BC7       ETC1      ETC2
          ETC2A     ETC2A1    PTC12
          PTC14     PTC12A    PTC14A
          PTC22     PTC24

          UNKNOWN

          R1        A8        R8
          R8I       R8U       R8S
          R16       R16I      R16U
          R16F      R16S      R32I
          R32U      R32F      RG8
          RG8I      RG8U      RG8S
          RG16      RG16I     RG16U
          RG16F     RG16S     RG32I
          RG32U     RG32F     RGB8
          RGB8I     RGB8U     RGB8S
          RGB9E5F   BGRA8     RGBA8
          RGBA8I    RGBA8U    RGBA8S
          RGBA16    RGBA16I   RGBA16U
          RGBA16F   RGBA16S   RGBA32I
          RGBA32U   RGBA32F   R5G6B5
          RGBA4     RGB5A1    RGB10A2
          R11G11B10F

          UNKNOWN_DEPTH

          D16       D24       D24S8
          D32       D16F      D24F
          D32F      D0S8

          TEXT-FORMAT-COUNT)
(fli:define-c-typedef texture-format-t (:enum texture-format))

(fli:define-c-enum uniform-type
  int1 end vec4 mat3 mat4 uniform-type-count)
(fli:define-c-typedef uniform-type-t (:enum uniform-type))

(fli:define-c-enum backbuffer-ratio
  equal half quarter eighth sixteenth double backbuffer-ratio-count)
(fli:define-c-typedef backbuffer-ratio-t (:enum backbuffer-ratio))

(fli:define-c-enum occlusion-query-result
  invisible visible noresult occlusion-query-result-count)
(fli:define-c-typedef occlusion-query-result-t (:enum occlusion-query-result))

(fli:define-c-enum topology-convert
  tri-list-flip-winding    tri-list-to-line-list
  tri-strip-to-tri-list    lise-strip-to-line-list
  topology-convert-count)
(fli:define-c-typedef topology-convert-t (:enum topology-convert))

(fli:define-c-enum topology-sort
  direction-front-to-back-mit       direction- front-to-back-avg
  direction-front-to-back-max       direction back-to-front-min
  direction-back-to-front-avg       direction-back-to-front-max
  distance-front-to-back-min        distance-front-to-back-avg
  distance-front-to-back-max        distance-back-to-front-min
  distance-back-to-front-avg        distance-back-to-front-max
  topology-sort-count)
(fli:define-c-typedef topology-sort-t (:enum topology-sort))

(defmacro bgfx-handle (name)
  (let ((type-name (intern (concatenate 'string (symbol-name name) "-T"))))
    `(progn (fli:define-c-struct ,name (idx :uint16))
       (fli:define-c-typedef ,type-name (:struct ,name)))))

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

(fli:define-foreign-function release-fn
    ((ptr :pointer)
     (userdata :pointer)))
(fli:define-c-typedef release-fn-t (:pointer release-fn))

(fli:define-c-struct memory
  (data (:pointer :uint8))
  (size :uint32))
(fli:define-c-typedef memory-t (:struct memory))

(fli:define-c-struct transform
  (data (:pointer :float))
  (num :uint16))
(fli:define-c-typedef transform-t (:struct transform))

(fli:define-c-struct hmd-eye
  (rotation (:c-array :float 4))
  (translation (:c-array :float 3))
  (fov (:c-array :float 4))
  (view-offset (:c-array :float 3))
  (projection (:c-array :float 16))
  (pixels-per-tan-angle (:c-array :float 2)))
(fli:define-c-typedef hmd-eye-t (:struct hmd-eye))

(fli:define-c-struct hmd
  (eye (:c-array :hmd-eye 2))
  (width :uint16)
  (height :uint16)
  (device-width :uint16)
  (device-height :uint16)
  (flags :uint8))
(fli:define-c-typedef hmt-t (:struct hmd))

(fli:define-c-struct stats
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
  (tex-width :uint16)
  (tex-height :uint16))
(fli:define-c-typedef stats-t (:struct stats))

(fli:define-c-struct vertex-decl
  (hash :uint32)
  (stride :uint16)
  (offset (:c-array :uint16 (fli:enum-symbol-value 'attrib 'attrib-count)))
  (attributes (:c-array :uint16 (fli:enum-symbol-value 'attrib 'attrib-count))))
(fli:define-c-typedef vertex-decl-t (:struct vertex-decl))

(fli:define-c-struct transient-index-buffer
  (data :pointer :uint8)
  (size :uint32)
  (handle :index-buffer-handle)
  (start-index :uint32))
(fli:define-c-typedef transient-index-buffer-t (:struct transient-index-buffer))

(fli:define-c-struct transient-vertex-buffer
  (data :pointer :uint8)
  (size :uint32)
  (start-vertex :uint32)
  (stride :uint16)
  (handle :index-buffer-handle)
  (decl :vertex-decl-handle))
(fli:define-c-typedef transient-vertex-buffer-t (:struct transient-vertex-buffer))

(fli:define-c-struct instance-data-buffer
  (data :pointer :uint8)
  (size :uint32)
  (offset :uint32)
  (num :uint32)
  (stride :uint16)
  (handle :vertex-buffer-handle))
(fli:define-c-typedef instance-data-buffer-t (:struct instance-data-buffer))

(fli:define-c-struct texture-info
  (format :texture-format)
  (storage-size :uint32)
  (width :uint16)
  (height :uint16)
  (depth :uint16)
  (num-layers :uint16)
  (num-mips :uint8)
  (bits-per-pixel :uint8)
  (cube-map :bool))
(fli:define-c-typedef texture-info-t (:struct texture-info))

(fli:define-c-struct uniform-info
  (name (:c-array :char 256))
  (type :uniform-type)
  (num :uint16))
(fli:define-c-typedef uniform-info-t (:struct uniform-info))

(fli:define-c-struct attachment
  (handle :texture-handle)
  (mip :uint16)
  (layer :uint16))
(fli:define-c-typedef attachment-t (:struct attachment))

(fli:define-c-struct caps-gpu
  (:struct ((vendor-id :uint16)
            (device-id :uint16))))
(fli:define-c-typedef caps-gpu-t (:struct caps-gpu))

(fli:define-c-struct caps-limits
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
(fli:define-c-typedef caps-limits-t (:struct caps-limits))

(fli:define-c-struct caps
  (renderer-type :renderer-type)
  (supported :uint64)
  (vendor-id :uint16)
  (device-id :uint16)
  (homogeneous-depth :bool)
  (origin-bottom-left :bool)
  (num-gpus :uint8)
  (gpu (:c-array :caps-gpu 4))
  (limits :caps-limits)
  (formats (:c-array :uint16 :texture-format-count)))
(fli:define-c-typedef caps-t (:struct caps))

(fli:define-c-enum fatal
  fatal-debug-check
  fatal-invalid-shader
  fatal-unable-to-initialize
  fatal-unable-to-create-texture
  fatal-device-lost
  fatal-count)
(fli:define-c-typedef fatal-t (:enum fatal))

;; Callback interface

(fli:define-c-struct callback-interface
  (vtbl (:pointer :callback-vtbl)))
(fli:define-c-typedef callback-interface-t (:struct callback-interface))

(fli:define-c-struct callback-vtbl
  (fatal :pointer)
  (trace-vargs :pointer)
  (cache-read-size :pointer)
  (cache-read :pointer)
  (cache-write :pointer)
  (screen-shot :pointer)
  (capture-begin :pointer)
  (capture-end :pointer)
  (capture-frame :pointer))
(fli:define-c-typedef callback-vtbl-t (:struct callback-vtbl))

(fli:define-c-struct allocator-interface
  (vtbl (:pointer allocator-vtbl-t)))
(fli:define-c-typedef allocator-interface-t (:struct allocator-interface))

(fli:define-c-struct allocator-vtbl
  (realloc :pointer))
(fli:define-c-typedef allocator-vtbl-t (:struct allocator-vtbl))

(fli:define-c-struct platform-data
  (ndt :pointer)                ; native display type
  (nwh :pointer)                ; native window handle
  (context :pointer)            ; gl context or d3d device
  (back-buffer :pointer)        ; gl backbuffer or d3d render target view
  (back-buffer-ds :pointer)     ; backbuffer depth/stencil
  (session :pointer))           ; ovr session for Oculus SDK
(fli:define-c-typedef platform-data-t (:struct platform-data))

;;;;;;;;;;;;; BGFX-C-API

(fli:register-module :bgfx :real-name "bgfx.dll" :connection-style :immediate)

(fli:define-foreign-function
    (set-platform-data "bgfx_set_platform_data" :source)
    ((data (:pointer platform-data-t)))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (vertex-decl-begin "bgfx_vertex_decl_begin" :source)
    ((decl vertex-decl-t)
     (renderer renderer-type-t))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (vertex-decl-add "bgfx_vertex_decl_add" :source)
    ((decl vertex-decl-t)
     (attrib attrib-t)
     (num :uint8)
     (type attrib-type-t)
     (normalized :boolean)
     (as-int :boolean))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (vertex-decl-skip "bgfx_vertex_decl_skip" :source)
    ((decl vertex-decl-t)
     (num :uint8))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (vertex-decl-end "bgfx_vertex_decl_end" :source)
    ((decl vertex-decl-t))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (vertex-pack "bgfx_vertex_pack" :source)
    ((input (:c-array :float 4))
     (input-normalized :boolean)
     (attr attrib-t)
     (decl vertex-decl-t)
     (data :pointer) ;; void*
     (index :uint32))
  :result-type :void)

(fli:define-foreign-function
    (vertex-unpack "bgfx_vertex_unpack" :source)
    ((output (:c-array :float 4))
     (attr attrib-t)
     (decl vertex-decl-t)
     (data :pointer) ;; void*
     (index :uint32))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (vertex-convert "bgfx_vertex_convert" :source)
    ((dest-decl vertex-decl-t)
     (dest-data :pointer) ;; void*
     (src-decl vertex-decl-t)
     (src-data :pointer) ;; void*
     (num :uint32))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (weld-vertices "bgfx_weld_vertices" :source)
    ((output (:pointer :uint16))
     (decl vertex-decl-t)
     (data :pointer) ;; void*
     (num :uint16)
     (epsilon :float))
  :result-type :uint16
  :module :bgfx)

(fli:define-foreign-function
    (topology-convert "bgfx_topology_convert" :source)
    ((convertsion topology-convert-t)
     (dst :pointer) ;; void*
     (dst-size :uint32)
     (indices :pointer) ;; void*
     (num-indices :uint32)
     (index32 :boolean))
  :result-type :uint32
  :module :bgfx)

(fli:define-foreign-function
    (topology-sort-tri-list "bgfx_topology_sort_tri_list" :source)
    ((sort topology-sort-t)
     (dst :pointer)
     (dst-size :uint32)
     (dir (:c-array :float 3))
     (pos (:c-array :float 3))
     (vertices :pointer)
     (stride :uint32)
     (indices :pointer)
     (num-indices :uint32)
     (index32 :boolean))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (image-swizzle-bgra8 "bgfx_image_swizzle:bgra8" :source)
    ((dst :pointer)
     (width :uint32)
     (height :uint32)
     (pitch :uint32)
     (src :pointer))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (image-rgba-downsample-2x2 "bgfx_image_rgba_downsample_2x2" :source)
    ((dst :pointer)
     (width :uint32)
     (height :uint32)
     (pitch :uint32)
     (src :pointer))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (get-supported-renderers "bgfx_get_supported_renderers" :source)
    ((max :uint8)
     (enum renderer-type-t))
  :result-type :uint8
  :module :bgfx)

(fli:define-foreign-function
    (get-renderer-name "bgfx_get_renderer_name" :source)
    ((type renderer-type-t))
  :result-type (:pointer :char)
  :module :bgfx)

(fli:define-foreign-function
    (init "bgfx_init" :source)
    ((type renderer-type-t)
     (venfor-id :uint16)
     (device-id :uint16)
     (callback :pointer)
     (allocator :pointer))
  :result-type :boolean
  :module :bgfx)

(fli:define-foreign-function
    (bgfx-shutdown "bgfx_shutdown" :source)
    ()
    :result-type :void
    :module :bgfx)

(fli:define-foreign-function
    (set-view-clear "bgfx_set_view_clear" :source)
    ((id :uint8)
     (flags :uint8)
     (rgba :uint32)
     (depth :float)
     (stencil :uint8))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (reset "bgfx_reset" :source)
    ((width :uint32)
     (height :uint32)
     (flags :uint32))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (render-frame "bgfx_render_frame" :source)
    ()
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (set-view-rect "bgfx_set_view_rect" :source)
    ((id :uint8)
     (x :uint16)
     (y :uint16)
     (width :uint16)
     (height :uint16))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (touch "bgfx_touch" :source)
    ((id :uint8))
  :result-type :uint32
  :module :bgfx)

(fli:define-foreign-function
    (set-debug "bgfx_set_debug" :source)
    ((debug :uint32))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (dbg-text-clear "bgfx_dbg_text_clear" :source)
    ((attr :uint8)
     (small :boolean))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (dbg-text-printf "bgfx_dbg_text_printf" :source)
    ((x :uint16)
     (y :uint16)
     (attr :uint8)
     (format (:reference-pass :ef-mb-string)))
  :result-type :void
  :module :bgfx)

(fli:define-foreign-function
    (frame "bgfx_frame" :source)
    ((capture :boolean))
  :result-type :uint32
  :module :bgfx)

(let ((pack (find-package :cl-bgfx-ffi)))
  (do-all-symbols (sym pack) (when (eql (symbol-package sym) pack) (export sym))))