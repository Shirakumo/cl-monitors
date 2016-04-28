#|
 This file is a part of cl-monitors
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(defpackage #:cl-monitors-cffi
  (:nicknames #:org.shirakumo.fraf.monitors.cffi)
  (:use #:cl #:cffi)
  ;; low-level.lisp
  (:export
   #:libmonitors
   
   #:mode
   #:mode-monitor
   #:mode-width
   #:mode-height
   #:mode-refresh
   #:mode-data
   
   #:monitor
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
   #:mode
   #:monitor
   #:width
   #:height
   #:refresh
   
   #:monitor
   #:modes
   #:mode
   #:name
   #:primary-p
   #:width
   #:height
   
   #:init
   #:definit
   #:detect
   #:make-current))
