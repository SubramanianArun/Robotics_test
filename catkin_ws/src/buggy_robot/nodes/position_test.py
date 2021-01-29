#! /usr/bin/env python3

import unittest
import rostest
import time
from controller_node import ControllerNode

# class ActuatorTest(unittest.TestCase):
#
#     def __init__(self):
#         pass
#
#     def test_checkposition(self):
#         controllerTestObject = ControllerNode()
#         inputvalues = [0.1,0.2,0.3,0.4,0.5]
#         for value in inputvalues:
#             controllerTestObject.run(value)
#             time.sleep(10)
#         print("Position Test passed")
#         pass
#
# if __name__ == "__main__":
#     rostest.rosrun('buggy_robot', 'position_test', ActuatorTest)

#class ActuatorTest(unittest.TestCase):
class ActuatorTest():

    def __init__(self):
        pass

    def test_checkposition(self):
        controllerTestObject = ControllerNode()
        inputvalues = [0.1,0.2,0.3,0.4,0.5]
        for value in inputvalues:
            controllerTestObject.run(value)
            time.sleep(10)
        print("Position Test passed")
        pass

if __name__ == "__main__":
    object = ActuatorTest()
    object.test_checkposition()
    #rostest.rosrun('buggy_robot', 'position_test', ActuatorTest)
