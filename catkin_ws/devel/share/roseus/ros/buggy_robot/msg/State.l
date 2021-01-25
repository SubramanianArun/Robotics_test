;; Auto-generated. Do not edit!


(when (boundp 'buggy_robot::State)
  (if (not (find-package "BUGGY_ROBOT"))
    (make-package "BUGGY_ROBOT"))
  (shadow 'State (find-package "BUGGY_ROBOT")))
(unless (find-package "BUGGY_ROBOT::STATE")
  (make-package "BUGGY_ROBOT::STATE"))

(in-package "ROS")
;;//! \htmlinclude State.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass buggy_robot::State
  :super ros::object
  :slots (_stamp _x _x_dot ))

(defmethod buggy_robot::State
  (:init
   (&key
    ((:stamp __stamp) (instance std_msgs::Time :init))
    ((:x __x) 0.0)
    ((:x_dot __x_dot) 0.0)
    )
   (send-super :init)
   (setq _stamp __stamp)
   (setq _x (float __x))
   (setq _x_dot (float __x_dot))
   self)
  (:stamp
   (&rest __stamp)
   (if (keywordp (car __stamp))
       (send* _stamp __stamp)
     (progn
       (if __stamp (setq _stamp (car __stamp)))
       _stamp)))
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:x_dot
   (&optional __x_dot)
   (if __x_dot (setq _x_dot __x_dot)) _x_dot)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Time _stamp
    (send _stamp :serialization-length)
    ;; float64 _x
    8
    ;; float64 _x_dot
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Time _stamp
       (send _stamp :serialize s)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _x_dot
       (sys::poke _x_dot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Time _stamp
     (send _stamp :deserialize buf ptr-) (incf ptr- (send _stamp :serialization-length))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _x_dot
     (setq _x_dot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get buggy_robot::State :md5sum-) "3f7c1e71ff724a5e596d059e9f465816")
(setf (get buggy_robot::State :datatype-) "buggy_robot/State")
(setf (get buggy_robot::State :definition-)
      "std_msgs/Time stamp
float64 x
float64 x_dot
================================================================================
MSG: std_msgs/Time
time data

")



(provide :buggy_robot/State "3f7c1e71ff724a5e596d059e9f465816")


