; Auto-generated. Do not edit!


(cl:in-package beginner_tutorials-msg)


;//! \htmlinclude Area.msg.html

(cl:defclass <Area> (roslisp-msg-protocol:ros-message)
  ((triangleArea
    :reader triangleArea
    :initarg :triangleArea
    :type cl:float
    :initform 0.0)
   (squareAresa
    :reader squareAresa
    :initarg :squareAresa
    :type cl:float
    :initform 0.0))
)

(cl:defclass Area (<Area>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Area>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Area)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name beginner_tutorials-msg:<Area> is deprecated: use beginner_tutorials-msg:Area instead.")))

(cl:ensure-generic-function 'triangleArea-val :lambda-list '(m))
(cl:defmethod triangleArea-val ((m <Area>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader beginner_tutorials-msg:triangleArea-val is deprecated.  Use beginner_tutorials-msg:triangleArea instead.")
  (triangleArea m))

(cl:ensure-generic-function 'squareAresa-val :lambda-list '(m))
(cl:defmethod squareAresa-val ((m <Area>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader beginner_tutorials-msg:squareAresa-val is deprecated.  Use beginner_tutorials-msg:squareAresa instead.")
  (squareAresa m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Area>) ostream)
  "Serializes a message object of type '<Area>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'triangleArea))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'squareAresa))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Area>) istream)
  "Deserializes a message object of type '<Area>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'triangleArea) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'squareAresa) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Area>)))
  "Returns string type for a message object of type '<Area>"
  "beginner_tutorials/Area")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Area)))
  "Returns string type for a message object of type 'Area"
  "beginner_tutorials/Area")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Area>)))
  "Returns md5sum for a message object of type '<Area>"
  "5648e7ac35be221a65813918d3e85b48")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Area)))
  "Returns md5sum for a message object of type 'Area"
  "5648e7ac35be221a65813918d3e85b48")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Area>)))
  "Returns full string definition for message of type '<Area>"
  (cl:format cl:nil "float64 triangleArea~%float64 squareAresa~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Area)))
  "Returns full string definition for message of type 'Area"
  (cl:format cl:nil "float64 triangleArea~%float64 squareAresa~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Area>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Area>))
  "Converts a ROS message object to a list"
  (cl:list 'Area
    (cl:cons ':triangleArea (triangleArea msg))
    (cl:cons ':squareAresa (squareAresa msg))
))
