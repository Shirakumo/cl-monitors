#|
 This file is a part of cl-monitors
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.monitors.cffi)

(defvar *here* #.(or *compile-file-pathname* *load-pathname* *default-pathname-defaults*))
(defvar *static* (make-pathname :name NIL :type NIL :defaults (merge-pathnames "static/" *here*)))
(pushnew *static* cffi:*foreign-library-directories*)

(define-foreign-library libmonitors
  (:darwin (:or "libmonitors.dylib" "libmonitors.so"
                #+X86 "mac32-libmonitors.dylib"
                #+X86-64 "mac64-libmonitors.dylib"))
  (:unix (:or "libmonitors.so"
              #+X86 "lin32-libmonitors.so"
              #+X86-64 "lin64-libmonitors.so"))
  (:windows (:or "monitors.dll"
                 #+X86 "win32-libmonitors.dll"
                 #+X86-64 "win64-libmonitors.dll"))
  (t (:default "stem_gamepad")))

(use-foreign-library libmonitors)

(defcstruct (mode-struct :class mode-struct :conc-name mode-)
  (monitor :pointer)
  (width :int)
  (height :int)
  (refresh :int)
  (data :pointer))

(defcstruct (monitor-struct :class monitor-struct :conc-name monitor-)
  (name :string)
  (primary :bool)
  (width :int)
  (height :int)
  (mode-count :int)
  (current-mode :pointer)
  (modes :pointer)
  (data :pointer))

(defcfun (monitors-init "libmonitors_init") :bool)

(defcfun (monitors-deinit "libmonitors_deinit") :void)

(defcfun (monitors-detect "libmonitors_detect") :bool
  (count (:pointer :int))
  (monitors (:pointer :pointer)))

(defcfun (monitors-make-mode-current "libmonitors_make_mode_current") :bool
  (mode :pointer))

(defcfun (monitors-free-monitor "libmonitors_free_monitor") :void
  (monitor :pointer))

(defcfun (monitors-free-monitors "libmonitors_free_monitors") :void
  (count :int)
  (monitors :pointer))
