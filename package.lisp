(in-package #:cl-user)
(defpackage #:cl-monitors-cffi
  (:nicknames #:org.shirakumo.fraf.monitors.cffi)
  (:use #:cl #:cffi)
  ;; low-level.lisp
  (:export
   #:*static*
   #:libmonitors
   
   #:mode-struct
   #:mode-monitor
   #:mode-width
   #:mode-height
   #:mode-refresh
   #:mode-data
   
   #:monitor-struct
   #:monitor-name
   #:monitor-primary
   #:monitor-width
   #:monitor-height
   #:monitor-mode-count
   #:monitor-current-mode
   #:monitor-modes
   #:monitor-data
   
   #:monitors-init
   #:monitors-deinit
   #:monitors-detect
   #:monitors-make-mode-current
   #:monitors-free-monitors
   #:monitors-free-monitor))

(defpackage #:cl-monitors
  (:nicknames #:org.shirakumo.fraf.monitors)
  (:use #:cl #:org.shirakumo.fraf.monitors.cffi)
  ;; wrapper.lisp
  (:export
   #:monitor-condition
   #:initialization-failed-error
   #:detection-failed-error
   #:mode-switch-failed-error
   #:mode
   
   #:mode
   #:monitor
   #:width
   #:height
   #:refresh
   #:current-p
   
   #:monitor
   #:modes
   #:mode
   #:name
   #:primary-p
   #:width
   #:height
   
   #:init
   #:deinit
   #:detect
   #:make-current))
