;; Auto-generated. Do not edit!


(when (boundp 'buggy_robot::SetTarget)
  (if (not (find-package "BUGGY_ROBOT"))
    (make-package "BUGGY_ROBOT"))
  (shadow 'SetTarget (find-package "BUGGY_ROBOT")))
(unless (find-package "BUGGY_ROBOT::SETTARGET")
  (make-package "BUGGY_ROBOT::SETTARGET"))
(unless (find-package "BUGGY_ROBOT::SETTARGETREQUEST")
  (make-package "BUGGY_ROBOT::SETTARGETREQUEST"))
(unless (find-package "BUGGY_ROBOT::SETTARGETRESPONSE")
  (make-package "BUGGY_ROBOT::SETTARGETRESPONSE"))

(in-package "ROS")





(defclass buggy_robot::SetTargetRequest
  :super ros::object
  :slots (_x_target ))

(defmethod buggy_robot::SetTargetRequest
  (:init
   (&key
    ((:x_target __x_target) 0.0)
    )
   (send-super :init)
   (setq _x_target (float __x_target))
   self)
  (:x_target
   (&optional __x_target)
   (if __x_target (setq _x_target __x_target)) _x_target)
  (:serialization-length
   ()
   (+
    ;; float64 _x_target
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x_target
       (sys::poke _x_target (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x_target
     (setq _x_target (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass buggy_robot::SetTargetResponse
  :super ros::object
  :slots (_success _message ))

(defmethod buggy_robot::SetTargetResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass buggy_robot::SetTarget
  :super ros::object
  :slots ())

(setf (get buggy_robot::SetTarget :md5sum-) "4e189454548dc258e2bec03d6806f911")
(setf (get buggy_robot::SetTarget :datatype-) "buggy_robot/SetTarget")
(setf (get buggy_robot::SetTarget :request) buggy_robot::SetTargetRequest)
(setf (get buggy_robot::SetTarget :response) buggy_robot::SetTargetResponse)

(defmethod buggy_robot::SetTargetRequest
  (:response () (instance buggy_robot::SetTargetResponse :init)))

(setf (get buggy_robot::SetTargetRequest :md5sum-) "4e189454548dc258e2bec03d6806f911")
(setf (get buggy_robot::SetTargetRequest :datatype-) "buggy_robot/SetTargetRequest")
(setf (get buggy_robot::SetTargetRequest :definition-)
      "float64 x_target
---
bool success
string message
")

(setf (get buggy_robot::SetTargetResponse :md5sum-) "4e189454548dc258e2bec03d6806f911")
(setf (get buggy_robot::SetTargetResponse :datatype-) "buggy_robot/SetTargetResponse")
(setf (get buggy_robot::SetTargetResponse :definition-)
      "float64 x_target
---
bool success
string message
")



(provide :buggy_robot/SetTarget "4e189454548dc258e2bec03d6806f911")


