#!/usr/bin/env python
import rospy
from std_srvs.srv import Trigger, TriggerResponse

from buggy_robot.hardware import Hardware
from buggy_robot.msg import (Command, State)
from buggy_robot.srv import SetTarget, SetTargetResponse

#########################################################
##### OK To EDIT :-) ####################################
#########################################################

class HardwareNode:

    def __init__(self):
        # Setup ROS stuff
        rospy.init_node('hardware')
        self.cmd_sub = rospy.Subscriber('/controller/command', Command, self.command_cb)
        self.reset_srv = rospy.Service('~reset', Trigger, self.reset_cb)
        self.next_srv = rospy.Service('~next', Trigger, self.next_cb)
        self.state_pub = rospy.Publisher('~state', State, queue_size=5)
        self.hardware = Hardware()

    def command_cb(self, cmd_msg):
        self.hardware.set_command(cmd_msg.cmd)
    
    def reset_cb(self, reset_req):
        resp = TriggerResponse()
        # Only reset state; do not swap hardware model
        self.hardware.reset(new_hardware = False)
        resp.success = True
        resp.message = 'Reset state for current hardware.'
        return resp
    
    def next_cb(self, reset_req):
        resp = TriggerResponse()
        # Only reset state; do not swap hardware model
        self.hardware.reset(new_hardware = True)
        resp.success = True
        resp.message = 'Swapped to new hardware sample.'
        return resp

    def send_state(self):
        state_msg = State()
        state_msg.stamp.data = rospy.Time.now()
        state_msg.x, state_msg.x_dot = self.hardware.get_state()
        self.state_pub.publish(state_msg)
    
    def run(self):
        rate = rospy.Rate(40) # 40Hz
        while not rospy.is_shutdown():
            self.send_state()
            rate.sleep()


if __name__ == '__main__':
    n = HardwareNode()
    try:
        n.run()
    except (rospy.ROSInterruptException, KeyboardInterrupt, SystemExit):
        pass