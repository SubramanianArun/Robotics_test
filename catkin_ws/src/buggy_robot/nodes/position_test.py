#! /usr/bin/env python3

import unittest
import rostest
import rospy
import math
import time
from std_srvs.srv import Trigger, TriggerResponse

from buggy_robot.msg import (Command, State)
from controller_node import ControllerNode
from buggy_robot.srv import SetTarget, SetTargetResponse


# class ActuatorTest(unittest.TestCase):
#
#     def __init__(self):
#         self.object = ControllerNode()
#         pass
#
#     def test_checkposition(self):
#         self.assertLessEqual(self.object.run(0.1), 0.5)
#         self.assertLessEqual(self.object.run(0.2), 0.5)
#         self.assertLessEqual(self.object.run(0.3), 0.5)
#         self.assertLessEqual(self.object.run(0.4), 0.5)
#         self.assertLessEqual(self.object.run(0.5), 0.5)
#
#     def test_checkEdges(self):
#         '''
#         TO DO:
#         Need to handle how the run method responds to various inputs
#         '''
#         self.assertTrue(self.object.run(1), True)
#         self.assertFalse(self.object.run(100))
#         self.assertFalse(self.object.run(3.4))
#         self.assertFalse(self.object.run('0.4'))
#         self.assertFalse(self.object.run('s'))
#         self.assertFalse(self.object.run('@'))
#         with self.assertRaises(TypeError):
#             print ('Edge case exception')
# if __name__ == "__main__":
#     rostest.rosrun('buggy_robot', 'position_test', ActuatorTest)

class ActuatorTest():

    def __init__(self):
        rospy.init_node('tester')
        self.test_state_sub = rospy.Subscriber('/hardware/state', State, self.state_test)
        # self.current_position = self.current_state.x
        # self.current_velocity = self.current_state.x_dot
        # print ('Initial position: %d ' %(self.current_position))
        # print ('Initial velocity: %d ' %(self.current_velocity))
        rospy.wait_for_service('/controller/enable')
        try:
            controller_enable_srvhandler = rospy.ServiceProxy('/controller/enable', Trigger)
            self.controller_response = controller_enable_srvhandler()
            print(self.controller_response.message)

        except Exception as e:
            print(e)

    def state_test(self, state_msg):
        self.current_state = state_msg

    def SetTargetHandler(self, target_distance):
        rospy.wait_for_service('/controller/set_target')
        try:
            controller_target_srvhandler = rospy.ServiceProxy('/controller/set_target', SetTarget)
            self.settarget_response = controller_target_srvhandler(target_distance)
            print('Target Set')
            print(self.settarget_response.message)

        except Exception as e:
            print(e)

    def tolerance_check(self, targetValue, currentValue):
        '''
        Checks if the actuator position is within the tolerance limit

            Parameters:
                targetValue (float): The target position
                currentValue (float): The current position

            Returns:
                OK (bool): Pass or Fail
        '''
        if abs(targetValue - currentValue) <= 0.05:
            return True
        else:
            return False

    def test_checkposition(self):
        '''
        A quick method to test position that sends different input values within the range
        over time
        '''
        rate = rospy.Rate(20) # 20 Hz
        input_value = 0.4
        start_time = time.time()
        self.SetTargetHandler(input_value)
        #target_distances = [0.1, 0.2, 0.3, 0.4, 0.5]
        threshold_time = 8 #Eight second threshold time to fail the actuator
        while not rospy.is_shutdown():
            print ('Current position: %.3f ' %(self.current_state.x))
            current_time = time.time()
            if current_time > (start_time + threshold_time):
                if self.tolerance_check(input_value, self.current_state.x):
                    print ('Test case passed')
                    rospy.signal_shutdown('Target Reached')
                    print ('Time taken: %f' %(current_time - start_time))
                else:
                    print ('Test case failed')
                    rospy.signal_shutdown('Unable to reach target')
                    print ('Time taken: %f' %(current_time - start_time))
            rate.sleep()


if __name__ == "__main__":
    object = ActuatorTest()
    object.test_checkposition()
