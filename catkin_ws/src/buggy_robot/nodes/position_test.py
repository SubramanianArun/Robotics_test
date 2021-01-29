#! /usr/bin/env python3

import unittest
import rostest
import time
from controller_node import ControllerNode

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
#         self.assertFalse(self.object.run(1))
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
        pass

    def test_checkposition(self):
        '''
        A quick method to test position that sends different input values within the range
        over time
        '''
        controllerTestObject = ControllerNode()
        inputvalues = [0.1,0.2,0.3,0.4,0.5]
        for value in inputvalues:
            controllerTestObject.run(value)
            time.sleep(5)
        print("Position Test cases executed")
        pass

if __name__ == "__main__":
    object = ActuatorTest()
    object.test_checkposition()
