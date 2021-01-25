; Auto-generated. Do not edit!


(cl:in-package buggy_robot-srv)


;//! \htmlinclude SetTarget-request.msg.html

(cl:defclass <SetTarget-request> (roslisp-msg-protocol:ros-message)
  ((x_target
    :reader x_target
    :initarg :x_target
    :type cl:float
    :initform 0.0))
)

(cl:defclass SetTarget-request (<SetTarget-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTarget-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTarget-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name buggy_robot-srv:<SetTarget-request> is deprecated: use buggy_robot-srv:SetTarget-request instead.")))

(cl:ensure-generic-function 'x_target-val :lambda-list '(m))
(cl:defmethod x_target-val ((m <SetTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader buggy_robot-srv:x_target-val is deprecated.  Use buggy_robot-srv:x_target instead.")
  (x_target m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTarget-request>) ostream)
  "Serializes a message object of type '<SetTarget-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x_target))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTarget-request>) istream)
  "Deserializes a message object of type '<SetTarget-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_target) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTarget-request>)))
  "Returns string type for a service object of type '<SetTarget-request>"
  "buggy_robot/SetTargetRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTarget-request)))
  "Returns string type for a service object of type 'SetTarget-request"
  "buggy_robot/SetTargetRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTarget-request>)))
  "Returns md5sum for a message object of type '<SetTarget-request>"
  "4e189454548dc258e2bec03d6806f911")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTarget-request)))
  "Returns md5sum for a message object of type 'SetTarget-request"
  "4e189454548dc258e2bec03d6806f911")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTarget-request>)))
  "Returns full string definition for message of type '<SetTarget-request>"
  (cl:format cl:nil "float64 x_target~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTarget-request)))
  "Returns full string definition for message of type 'SetTarget-request"
  (cl:format cl:nil "float64 x_target~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTarget-request>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTarget-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTarget-request
    (cl:cons ':x_target (x_target msg))
))
;//! \htmlinclude SetTarget-response.msg.html

(cl:defclass <SetTarget-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass SetTarget-response (<SetTarget-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTarget-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTarget-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name buggy_robot-srv:<SetTarget-response> is deprecated: use buggy_robot-srv:SetTarget-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetTarget-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader buggy_robot-srv:success-val is deprecated.  Use buggy_robot-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetTarget-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader buggy_robot-srv:message-val is deprecated.  Use buggy_robot-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTarget-response>) ostream)
  "Serializes a message object of type '<SetTarget-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTarget-response>) istream)
  "Deserializes a message object of type '<SetTarget-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTarget-response>)))
  "Returns string type for a service object of type '<SetTarget-response>"
  "buggy_robot/SetTargetResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTarget-response)))
  "Returns string type for a service object of type 'SetTarget-response"
  "buggy_robot/SetTargetResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTarget-response>)))
  "Returns md5sum for a message object of type '<SetTarget-response>"
  "4e189454548dc258e2bec03d6806f911")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTarget-response)))
  "Returns md5sum for a message object of type 'SetTarget-response"
  "4e189454548dc258e2bec03d6806f911")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTarget-response>)))
  "Returns full string definition for message of type '<SetTarget-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTarget-response)))
  "Returns full string definition for message of type 'SetTarget-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTarget-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTarget-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTarget-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetTarget)))
  'SetTarget-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetTarget)))
  'SetTarget-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTarget)))
  "Returns string type for a service object of type '<SetTarget>"
  "buggy_robot/SetTarget")