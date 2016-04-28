#|
 This file is a part of cl-monitors
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.monitors)

;; low-level.lisp
(docs:define-docs
  (variable *here*
    "Variable containing the path to this very file, hopefully.")

  (variable *static*
    "Variable containing a pathname to the static directory.")
  
  (type mode-struct
    "CL type for the C mode struct.

See MODE-MONITOR
See MODE-WIDTH
See MODE-HEIGHT
See MODE-REFRESH
See MODE-DATA")
  
  (function mode-monitor
    "Reads the pointer to the monitor struct this mode originated from.

See MODE-STRUCT")
  
  (function mode-width
    "Reads the mode's width in pixels.

See MODE-STRUCT")
  
  (function mode-height
    "Reads the mode's height in pixels.

See MODE-STRUCT")
  
  (function mode-refresh
    "Reads the mode's refresh rate in Herz.

See MODE-STRUCT")
  
  (function mode-data
    "Reads the pointer to the system-dependant data struct of the mode.

You should not need this for anything.

See MODE-STRUCT")
  
  (type monitor-struct
    "CL type for the C monitor struct.

See MONITOR-NAME
See MONITOR-PRIMARY
See MONITOR-WIDTH
See MONITOR-HEIGHT
See MONITOR-MODE-COUNT
See MONITOR-CURRENT-MODE
See MONITOR-MODES
See MONITOR-DATA
See MONITORS-FREE-MONITOR")
  
  (function monitor-name
    "Reads the monitor's name string.

See MONITOR-STRUCT")
  
  (function monitor-primary
    "Reads whether the monitor is the primary monitor of the system.

See MONITOR-STRUCT")
  
  (function monitor-width
    "Reads the monitor's physical width in millimetres.

See MONITOR-STRUCT")
  
  (function monitor-height
    "Reads the monitor's physical height in millimetres.

See MONITOR-STRUCT")
  
  (function monitor-mode-count
    "Reads the count for how many mode structs there are in the mode field of the monitor.

See MONITOR-MODES
See MONITOR-STRUCT")
  
  (function monitor-current-mode
    "Reads the pointer to the current mode of the monitor.

See MONITOR-STRUCT")
  
  (function monitor-modes
    "Reads the pointer to the packed mode struct array of the monitor.

See MONITOR-MODE-COUNT
See MONITOR-STRUCT")
  
  (function monitor-data
    "Reads the pointer to the system-dependant data struct of the monitor.

You should not need this for anything.

See MONITOR-STRUCT")
  
  (function monitors-init
    "Initializes the monitors library. You should call this before anything.

If NIL is returned, the initialisation failed and other library calls
will most likely too.")
  
  (function monitors-deinit
    "Cleans up the monitors library. You should call this once you are done with everything.")
  
  (function monitors-detect
    "Detects the monitors and their modes on the system.

You need to pass this two \"empty\" pointers. The first will be set to
reference an int for the number of monitors that were detected, and the
second to an array of pointers to monitor structs.

If NIL is returned, the detection failed and the two pointers you passed will not have changed.

See MONITOR-STRUCT")
  
  (function monitors-make-mode-current
    "Attempts to make the given mode the current mode on its monitor.

If NIL is returned, the mode change failed. Otherwise the monitor's
current mode is updated to reflect the newly chose none.

See MODE-STRUCT
See MONITOR-CURRENT-MODE")
  
  (function monitors-free-monitors
    "Frees an array of pointers to monitor objects, including the monitors referenced by it.

See MONITORS-FREE-MONITOR")
  
  (function monitors-free-monitor
    "Frees a monitor struct.

See MONITOR-STRUCT"))

;; wrapper.lisp
(docs:define-docs
  (type monitor-condition
    "Base condition class for conditions relating to this library.")
  
  (type initialization-failed-error
    "Condition for when the monitor initialization fails.

See INIT
See MONITOR-CONDITION")
  
  (type detection-failed-error
    "Condition for when the monitor detection fails.

See DETECT
See MONITOR-CONDITION")
  
  (type mode-switch-failed-error
    "Condition for when the mode switch call fails.

See MODE
See MONITOR-CONDITION")
  
  (type mode
    "Class representing a possible display mode of a monitor.

See MONITOR
See WIDTH
See HEIGHT
See REFRESH
See CURRENT-P")
  
  (function monitor
    "Returns the monitor the mode belongs to.

See MONITOR
See MODE")
  
  (function width
    "Returns the width.

For a mode, this is in pixels.
For a monitor, this is in physical millimetres.

See MODE
See MONITOR")
  
  (function height
    "Returns the height.

For a mode, this is in pixels.
For a monitor, this is in physical millimetres.

See MODE
See MONITOR")
  
  (function refresh
    "Returns the mode's refresh rate in Herz.

See MODE")
  
  (function current-p
    "Returns whether the mode is the current mode of the monitor.

See MODE")
  
  (type monitor
    "Class representing a physical monitor on the system.

See MODES
See MODE
See NAME
See PRIMARY-P
See WIDTH
See HEIGHT")
  
  (function modes
    "Returns the list of possible modes the monitor can assume.

A pox upon those that modify this list.

See MONITOR")
  
  (function mode
    "Returns the current mode of the monitor.

SETFable. When set with a suitable mode, it will attempt to switch
the current mode of the monitor to the new one. 
Signals a MODE-SWITCH-FAILED-ERROR on failure.

See MODE
See MONITOR")
  
  (function name
    "Returns the monitor's name on the system.

See MONITOR")
  
  (function primary-p
    "Returns whether the monitor is the system's primary monitor.

See MONITOR")
  
  (function init
    "Initializes the library.

You should call this before any other function to the library is called.
Signals an INITIALIZATION-FAILED-ERROR on failure.")
  
  (function deinit
    "Cleans up the library.

You should call this once you are done with everything.")
  
  (function detect
    "Detects the monitors and modes on the system.

Returns a list of monitors on the system.
Signals a DETECTION-FAILED-ERROR on failured.

See MONITOR")
  
  (function make-current
    "Attempts to make the passed mode the current one.

This is equivalent to doing (SETF (MODE (MONITOR mode)) mode).

See MODE"))
