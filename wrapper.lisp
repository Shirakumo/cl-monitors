(in-package #:org.shirakumo.fraf.monitors)

(define-condition monitor-condition (condition)
  ())

(define-condition initialization-failed-error (monitor-condition error)
  ()
  (:report (lambda (c s) (format s "Failed to initialize the monitors library."))))

(define-condition detection-failed-error (monitor-condition error)
  ()
  (:report (lambda (c s) (format s "Failed to detect monitors."))))

(define-condition mode-switch-failed-error (monitor-condition error)
  ((mode :initarg :mode :reader mode))
  (:report (lambda (c s) (format s "Failed to switch mode to ~a." (mode c)))))

(defmacro define-foreign-reader ((name internal-name) (class))
  `(defmethod ,name ((,class ,class))
     (,internal-name (pointer ,class))))

(defclass foreign-object ()
  ((pointer :initarg :pointer :reader pointer)))

(defclass mode (foreign-object)
  ((monitor :initarg :monitor :reader monitor))
  (:default-initargs
   :monitor (error "MONITOR required.")))

(defmethod print-object ((mode mode) stream)
  (print-unreadable-object (mode stream :type T)
    (format stream "~a ~ax~a@~aHz~@[ CURRENT~]"
            (name (monitor mode))
            (width mode) (height mode) (refresh mode)
            (current-p mode))))

(defmethod current-p ((mode mode))
  (eql mode (mode (monitor mode))))

(define-foreign-reader (width mode-width) (mode))
(define-foreign-reader (height mode-height) (mode))
(define-foreign-reader (refresh mode-refresh) (mode))

(defclass monitor (foreign-object)
  ((modes :reader modes)
   (mode :initform NIL :reader mode)))

(defmethod print-object ((monitor monitor) stream)
  (print-unreadable-object (monitor stream :type T)
    (let ((mode (mode monitor)))
      (format stream "~a ~ax~a@~aHz~@[ PRIMARY~]"
              (name monitor) (width mode) (height mode) (refresh mode)
              (primary-p monitor)))))

(defmethod initialize-instance :after ((monitor monitor) &key pointer)
  ;; Create modes
  (setf (slot-value monitor 'modes)
        (loop for i from 0 below (monitor-mode-count pointer)
              for mode-pointer = (cffi:mem-aptr (monitor-modes pointer) '(:struct mode-struct) i)
              for mode = (make-instance 'mode :monitor monitor :pointer mode-pointer)
              collect mode
              do (when (cffi:pointer-eq mode-pointer (monitor-current-mode pointer))
                   (setf (mode monitor) mode))))
  ;; Handle cleanup
  (tg:finalize monitor (lambda () (monitors-free-monitor pointer))))

(defmethod (setf mode) ((mode mode) (monitor monitor))
  (unless (eql (monitor mode) monitor)
    (error 'mode-switch-failed-error :mode mode))
  (cond ((eql mode (mode monitor)))
        ((mode monitor)
         (if (monitors-make-mode-current (pointer mode))
             (setf (slot-value monitor 'mode) mode)
             (error 'mode-switch-failed-error :mode mode)))
        (T
         (setf (slot-value monitor 'mode) mode)))
  mode)

(define-foreign-reader (name monitor-name) (monitor))
(define-foreign-reader (primary-p monitor-primary) (monitor))
(define-foreign-reader (width monitor-width) (monitor))
(define-foreign-reader (height monitor-height) (monitor))

(defun init ()
  (unless (monitors-init)
    (error 'initialization-failed-error)))

(defun deinit ()
  (monitors-deinit))

(defun detect ()
  (cffi:with-foreign-objects ((count :pointer)
                              (monitors '(:pointer :pointer)))
    (unless (monitors-detect count monitors)
      (error 'detection-failed-error))
    (let ((monitors (cffi:mem-ref monitors :pointer)))
      (unwind-protect
           (loop for i from 0 below (cffi:mem-ref count :int)
                 for monitor-pointer = (cffi:mem-aref monitors :pointer i)
                 collect (make-instance 'monitor :pointer monitor-pointer))
        (monitors-free-monitors 0 monitors)))))

(defun make-current (mode)
  (setf (mode (monitor mode)) mode))
