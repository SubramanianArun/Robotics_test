;; Auto-generated. Do not edit!


(when (boundp 'buggy_robot::Command)
  (if (not (find-package "BUGGY_ROBOT"))
    (make-package "BUGGY_ROBOT"))
  (shadow 'Command (find-package "BUGGY_ROBOT")))
(unless (find-package "BUGGY_ROBOT::COMMAND")
  (make-package "BUGGY_ROBOT::COMMAND"))

(in-package "ROS")
;;//! \htmlinclude Command.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass buggy_robot::Command
  :super ros::object
  :slots (_stamp _cmd ))

(defmethod buggy_robot::Command
  (:init
   (&key
    ((:stamp __stamp) (instance std_msgs::Time :init))
    ((:cmd __cmd) 0.0)
    )
   (send-super :init)
   (setq _stamp __stamp)
   (setq _cmd (float __cmd))
   self)
  (:stamp
   (&rest __stamp)
   (if (keywordp (car __stamp))
       (send* _stamp __stamp)
     (progn
       (if __stamp (setq _stamp (car __stamp)))
       _stamp)))
  (:cmd
   (&optional __cmd)
   (if __cmd (setq _cmd __cmd)) _cmd)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Time _stamp
    (send _stamp :serialization-length)
    ;; float64 _cmd
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Time _stamp
       (send _stamp :serialize s)
     ;; float64 _cmd
       (sys::poke _cmd (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Time _stamp
     (send _stamp :deserialize buf ptr-) (incf ptr- (send _stamp :serialization-length))
   ;; float64 _cmd
     (setq _cmd (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get buggy_robot::Command :md5sum-) "74f77447b8a55be4787813997e92e85b")
(setf (get buggy_robot::Command :datatype-) "buggy_robot/Command")
(setf (get buggy_robot::Command :definition-)
      "std_msgs/Time stamp
float64 cmd
================================================================================
MSG: std_msgs/Time
time data

")



(provide :buggy_robot/Command "74f77447b8a55be4787813997e92e85b")


