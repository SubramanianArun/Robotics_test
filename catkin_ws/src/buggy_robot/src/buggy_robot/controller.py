
import math

#########################################################
##### OK To EDIT :-) ####################################
#########################################################
class Controller:
    '''
    A class to represent a controller for robot hardware
    '''

    def __init__(self):
        self.x_target = 0.0
        
        self.p_gain = 15.0
        self.i_gain = 0.05
        self.d_gain = 8.0
        self.max_error_integral = 10.0

        self._cmd = 0.0
        self._x_error = 0.0
        self._x_error_integral = 0.0

    def reset(self):
        self.x_target = 0.0
        self._cmd = 0.0
        self._x_error = 0.0
        self._x_error_integral = 0.0

    def get_command(self, x_current, x_dot_current):
        '''
        Compute and return the PID command

            Parameters:
                x_current (float): The current position
                x_dot_current (float): The current velocity
            
            Returns:
                cmd (float): The PID command
        '''
        self._x_error = self.x_target - x_current
        # self._x_error = x_current - self.x_target
        self._x_error_integral = self._x_error_integral + self._x_error
        self._saturate_error_integral()

        self.cmd = self.p_gain * self._x_error \
            - self.d_gain * x_dot_current \
            + self.i_gain * self._x_error_integral
        
        return self.cmd
    
    def set_target(self, new_x_target):
        '''
        Set the target position; clear the integral error

            Parameters:
                new_x_target (float): The new target
            
            Returns:
                ok (bool): Whether the target was ok.
        '''
        if new_x_target >= 0.0 and new_x_target <= 0.5:
            self.x_target = new_x_target
            self._x_error_integral = 0.0
            return True
        
        return False
    
    def _saturate_error_integral(self):
        mag = math.fabs(self._x_error_integral)
        if mag > self.max_error_integral:
            self._x_error_integral = (self._x_error_integral / mag) * self.max_error_integral

