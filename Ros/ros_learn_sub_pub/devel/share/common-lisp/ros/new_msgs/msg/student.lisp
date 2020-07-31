; Auto-generated. Do not edit!


(cl:in-package new_msgs-msg)


;//! \htmlinclude student.msg.html

(cl:defclass <student> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (age
    :reader age
    :initarg :age
    :type cl:integer
    :initform 0))
)

(cl:defclass student (<student>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <student>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'student)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name new_msgs-msg:<student> is deprecated: use new_msgs-msg:student instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <student>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader new_msgs-msg:name-val is deprecated.  Use new_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'age-val :lambda-list '(m))
(cl:defmethod age-val ((m <student>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader new_msgs-msg:age-val is deprecated.  Use new_msgs-msg:age instead.")
  (age m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <student>) ostream)
  "Serializes a message object of type '<student>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let* ((signed (cl:slot-value msg 'age)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <student>) istream)
  "Deserializes a message object of type '<student>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'age) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<student>)))
  "Returns string type for a message object of type '<student>"
  "new_msgs/student")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'student)))
  "Returns string type for a message object of type 'student"
  "new_msgs/student")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<student>)))
  "Returns md5sum for a message object of type '<student>"
  "777a0ba04feb2b848668b8ed180bf7eb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'student)))
  "Returns md5sum for a message object of type 'student"
  "777a0ba04feb2b848668b8ed180bf7eb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<student>)))
  "Returns full string definition for message of type '<student>"
  (cl:format cl:nil "string name~%int64 age~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'student)))
  "Returns full string definition for message of type 'student"
  (cl:format cl:nil "string name~%int64 age~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <student>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <student>))
  "Converts a ROS message object to a list"
  (cl:list 'student
    (cl:cons ':name (name msg))
    (cl:cons ':age (age msg))
))
