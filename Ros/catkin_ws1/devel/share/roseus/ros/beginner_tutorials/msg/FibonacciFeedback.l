;; Auto-generated. Do not edit!


(when (boundp 'beginner_tutorials::FibonacciFeedback)
  (if (not (find-package "BEGINNER_TUTORIALS"))
    (make-package "BEGINNER_TUTORIALS"))
  (shadow 'FibonacciFeedback (find-package "BEGINNER_TUTORIALS")))
(unless (find-package "BEGINNER_TUTORIALS::FIBONACCIFEEDBACK")
  (make-package "BEGINNER_TUTORIALS::FIBONACCIFEEDBACK"))

(in-package "ROS")
;;//! \htmlinclude FibonacciFeedback.msg.html


(defclass beginner_tutorials::FibonacciFeedback
  :super ros::object
  :slots (_sequence ))

(defmethod beginner_tutorials::FibonacciFeedback
  (:init
   (&key
    ((:sequence __sequence) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _sequence __sequence)
   self)
  (:sequence
   (&optional __sequence)
   (if __sequence (setq _sequence __sequence)) _sequence)
  (:serialization-length
   ()
   (+
    ;; int32[] _sequence
    (* 4    (length _sequence)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[] _sequence
     (write-long (length _sequence) s)
     (dotimes (i (length _sequence))
       (write-long (elt _sequence i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[] _sequence
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sequence (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _sequence i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get beginner_tutorials::FibonacciFeedback :md5sum-) "b81e37d2a31925a0e8ae261a8699cb79")
(setf (get beginner_tutorials::FibonacciFeedback :datatype-) "beginner_tutorials/FibonacciFeedback")
(setf (get beginner_tutorials::FibonacciFeedback :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
#feedback
int32[] sequence

")



(provide :beginner_tutorials/FibonacciFeedback "b81e37d2a31925a0e8ae261a8699cb79")

