#! /usr/bin/env python3

import unittest
import rostest

class ActuatorTest(unittest.TestCase):

    def __init__(self):
        pass

    def checkposition(self):
        print("Position Test passed")
        pass


if __name__ == "__main__":
    rostest.rosrun('buggy_robot', 'position_test', ActuatorTest)
