;; Auto-generated. Do not edit!


(when (boundp 'beginner_tutorials::AddTwoInts)
  (if (not (find-package "BEGINNER_TUTORIALS"))
    (make-package "BEGINNER_TUTORIALS"))
  (shadow 'AddTwoInts (find-package "BEGINNER_TUTORIALS")))
(unless (find-package "BEGINNER_TUTORIALS::ADDTWOINTS")
  (make-package "BEGINNER_TUTORIALS::ADDTWOINTS"))
(unless (find-package "BEGINNER_TUTORIALS::ADDTWOINTSREQUEST")
  (make-package "BEGINNER_TUTORIALS::ADDTWOINTSREQUEST"))
(unless (find-package "BEGINNER_TUTORIALS::ADDTWOINTSRESPONSE")
  (make-package "BEGINNER_TUTORIALS::ADDTWOINTSRESPONSE"))

(in-package "ROS")





(defclass beginner_tutorials::AddTwoIntsRequest
  :super ros::object
  :slots (_a _b ))

(defmethod beginner_tutorials::AddTwoIntsRequest
  (:init
   (&key
    ((:a __a) 0)
    ((:b __b) 0)
    )
   (send-super :init)
   (setq _a (round __a))
   (setq _b (round __b))
   self)
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:serialization-length
   ()
   (+
    ;; int32 _a
    4
    ;; int32 _b
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _a
       (write-long _a s)
     ;; int32 _b
       (write-long _b s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _a
     (setq _a (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _b
     (setq _b (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass beginner_tutorials::AddTwoIntsResponse
  :super ros::object
  :slots (_sum ))

(defmethod beginner_tutorials::AddTwoIntsResponse
  (:init
   (&key
    ((:sum __sum) 0)
    )
   (send-super :init)
   (setq _sum (round __sum))
   self)
  (:sum
   (&optional __sum)
   (if __sum (setq _sum __sum)) _sum)
  (:serialization-length
   ()
   (+
    ;; int32 _sum
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _sum
       (write-long _sum s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _sum
     (setq _sum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass beginner_tutorials::AddTwoInts
  :super ros::object
  :slots ())

(setf (get beginner_tutorials::AddTwoInts :md5sum-) "f0b6d69ea10b0cf210cb349d58d59e8f")
(setf (get beginner_tutorials::AddTwoInts :datatype-) "beginner_tutorials/AddTwoInts")
(setf (get beginner_tutorials::AddTwoInts :request) beginner_tutorials::AddTwoIntsRequest)
(setf (get beginner_tutorials::AddTwoInts :response) beginner_tutorials::AddTwoIntsResponse)

(defmethod beginner_tutorials::AddTwoIntsRequest
  (:response () (instance beginner_tutorials::AddTwoIntsResponse :init)))

(setf (get beginner_tutorials::AddTwoIntsRequest :md5sum-) "f0b6d69ea10b0cf210cb349d58d59e8f")
(setf (get beginner_tutorials::AddTwoIntsRequest :datatype-) "beginner_tutorials/AddTwoIntsRequest")
(setf (get beginner_tutorials::AddTwoIntsRequest :definition-)
      "int32 a
int32 b
---
int32 sum
")

(setf (get beginner_tutorials::AddTwoIntsResponse :md5sum-) "f0b6d69ea10b0cf210cb349d58d59e8f")
(setf (get beginner_tutorials::AddTwoIntsResponse :datatype-) "beginner_tutorials/AddTwoIntsResponse")
(setf (get beginner_tutorials::AddTwoIntsResponse :definition-)
      "int32 a
int32 b
---
int32 sum
")



(provide :beginner_tutorials/AddTwoInts "f0b6d69ea10b0cf210cb349d58d59e8f")


