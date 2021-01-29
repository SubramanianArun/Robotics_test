#!/usr/bin/env python
import rospy
from std_srvs.srv import Trigger, TriggerResponse

from buggy_robot.controller import Controller
from buggy_robot.msg import (Command, State)
from buggy_robot.srv import SetTarget, SetTargetResponse

#########################################################
##### OK To EDIT :-) ####################################
#########################################################

class ControllerNode:

    def __init__(self):
        # Setup ROS stuff
        rospy.init_node('controller')
        self.state_sub = rospy.Subscriber('/hardware/state', State, self.state_cb)
        self.enable_srv = rospy.Service('~enable', Trigger, self.enable_cb)
        self.disable_srv = rospy.Service('~disable', Trigger, self.disable_cb)
        self.target_srv = rospy.Service('~set_target', SetTarget, self.set_target_cb)
        self.cmd_pub = rospy.Publisher('~command', Command, queue_size=5)

        # Internal variables
        self.latest_state = State()
        self.controller = Controller()
        self.enabled = False

    def state_cb(self, state_msg):
        self.latest_state = state_msg

    def set_target_cb(self, target_req):
        resp = SetTargetResponse()
        resp.success = self.controller.set_target(target_req.x_target)
        if not resp.success:
            resp.message = 'Target out of range, must be in [0,0.5]'

        return resp

    def enable_cb(self, enable_req):
        self.enabled = True
        resp = TriggerResponse()
        resp.success = True
        resp.message = 'Enabled control'
        return resp

    def disable_cb(self, disable_req):
        self.enabled = False
        self.controller.reset()
        resp = TriggerResponse()
        resp.success = True
        resp.message = 'Disabled control'
        return resp

    def send_cmd(self):
        if self.enabled:
            cmd = self.controller.get_command(
                self.latest_state.x,
                self.latest_state.x_dot)
        else:
            cmd = 0.0
        cmd_msg = Command()
        cmd_msg.stamp.data = rospy.Time.now()
        cmd_msg.cmd = cmd
        self.cmd_pub.publish(cmd_msg)

    def run(self, inputvalue):
        rate = rospy.Rate(20) # 20Hz
        saturation_hashmap = {0.1:0.088, 0.2:0.176, 0.3:0.265, 0.4:0.353, 0.5:0.441} #Hashmap of known saturation values
        position = SetTarget() # Create a target object for setting position
        position.x_target = inputvalue # Assign values runtime from the function call
        while not rospy.is_shutdown():
            self.enable_cb(True)
            self.set_target_cb(position)
            self.send_cmd()
            print ("Position: %.3f " %self.latest_state.x) # Print current position
            if (float(str(self.latest_state.x)[:5]) == saturation_hashmap[inputvalue]): # If it reaches saturation value, stop the loop
                break
            rate.sleep()


if __name__ == '__main__':
    try:
        n = ControllerNode()
        n.run(0.2)
    except rospy.ROSInterruptException:
        n.disable_cb(True)
        pass
