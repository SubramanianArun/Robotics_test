import math
import time
import threading

#########################################################
##### NO TOUCHING :-) ###################################
#########################################################
class Hardware:
    '''
    A class to model potentially buggy robot hardware;
    includes phyics modeling and driver interface for expediency
    '''

    def __init__(self):
        # Hard code dynamics
        self._M = 1.0 
        self._k = 2.0  
        self._c = 0.2

        # Track system state explicitly
        self._x = 0.0
        self._x_dot = 0.0
        self._x_dot_dot = 0.0
        self._x_dot_last = 0.0
        self._x_dot_dot_last = 0.0
        
        self._dt = 0.005 # Timestep to fake physics
        self._cmd = 0.0  # keep track of command
        self._physics_thread = None
        self._running = False
        self.reset(new_hardware=True)

    def set_command(self, cmd):
        self._cmd = cmd
    
    def get_state(self):
        return (self._x, self._x_dot)

    # Unplug it and plug it (or another one) back in
    def reset(self, new_hardware=False):
        if self._physics_thread is not None:
            self._stop()

        self._x = 0.0
        self._x_dot = 0.0
        self._x_dot_last = 0.0
        self._x_dot_dot_last = 0.0
        self._cmd = 0.0
        if new_hardware:
            self._model_mfg_variation()
        
        self._start()
    
    def stop_physics(self):
        self._stop()

    def _start(self):
        self._running = True
        self._physics_thread = threading.Thread(
            target=self._integrate_physics,
            daemon=True)
        self._physics_thread.start()

    def _stop(self):
        self._running = False
        self._physics_thread.join()
        self._physics_thread = None

    def _integrate_physics(self):
        # Compute instantaneous acceleration
        while self._running:
            F = -self._k * self._x - self._c * self._x_dot + self._cmd
            self._x_dot_dot = F / self._M   

            # Quick and dirty midpoint rule.
            self._x_dot = self._x_dot + (self._x_dot_dot + self._x_dot_dot_last) * 0.5 * self._dt  
            self._x = self._x + (self._x_dot + self._x_dot_last) * 0.5 * self._dt
            
            # Hard stop at 0
            if self._x < 0:
                self._x = 0
                self._x_dot = 0

            # Update last quantities for the next step
            self._x_dot_dot_last = self._x_dot_dot
            self._x_dot_last = self._x_dot 

            # sleep for the integration time
            time.sleep(self._dt)

#########################################################
##### NO PEEKING :-) ####################################
#########################################################
    def _model_mfg_variation(self):
        from random import random
        c_rand = random()
        k_rand = random()

        # Ruh roh... out of spec
        if c_rand >= 0.9:
            print("NOOOOOO")
            self._c = 200.0
        else:
            self._c = 0.2
        
        # Some variation from the mean
        self._k = 2.0 * (1 + k_rand/100)
         
