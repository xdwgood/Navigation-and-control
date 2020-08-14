;; Auto-generated. Do not edit!


(when (boundp 'beginner_tutorials::Area)
  (if (not (find-package "BEGINNER_TUTORIALS"))
    (make-package "BEGINNER_TUTORIALS"))
  (shadow 'Area (find-package "BEGINNER_TUTORIALS")))
(unless (find-package "BEGINNER_TUTORIALS::AREA")
  (make-package "BEGINNER_TUTORIALS::AREA"))

(in-package "ROS")
;;//! \htmlinclude Area.msg.html


(defclass beginner_tutorials::Area
  :super ros::object
  :slots (_triangleArea _squareAresa ))

(defmethod beginner_tutorials::Area
  (:init
   (&key
    ((:triangleArea __triangleArea) 0.0)
    ((:squareAresa __squareAresa) 0.0)
    )
   (send-super :init)
   (setq _triangleArea (float __triangleArea))
   (setq _squareAresa (float __squareAresa))
   self)
  (:triangleArea
   (&optional __triangleArea)
   (if __triangleArea (setq _triangleArea __triangleArea)) _triangleArea)
  (:squareAresa
   (&optional __squareAresa)
   (if __squareAresa (setq _squareAresa __squareAresa)) _squareAresa)
  (:serialization-length
   ()
   (+
    ;; float64 _triangleArea
    8
    ;; float64 _squareAresa
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _triangleArea
       (sys::poke _triangleArea (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _squareAresa
       (sys::poke _squareAresa (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _triangleArea
     (setq _triangleArea (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _squareAresa
     (setq _squareAresa (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get beginner_tutorials::Area :md5sum-) "5648e7ac35be221a65813918d3e85b48")
(setf (get beginner_tutorials::Area :datatype-) "beginner_tutorials/Area")
(setf (get beginner_tutorials::Area :definition-)
      "float64 triangleArea
float64 squareAresa
")



(provide :beginner_tutorials/Area "5648e7ac35be221a65813918d3e85b48")


