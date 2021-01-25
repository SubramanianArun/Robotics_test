# Package Summary

The buggy robot package implemements set point control for a 1d actuator, and exposes the actuator's firmware API to the ROS ecosystem (and includes a few hacks to simulate testing)

## controller_node.py
The controller node generates a command to acheive the desired set point for the hardware actuator.  The controller node sends a 0 command when it is disabled.

### Services
#### /controller/enable
Enables publishing of non-zero commands
```
rosservice call /controller/enable "{}"
```

#### /controller/disable
Resets internal variables (including x_target) and disables publishing non-zero commands
```
rosservice call /controller/enable "{}"
```

#### /controller/set_target
Sets the target set point. Should be called after `enable`
```
rosservice call /controller/set_target "x_target: 0.5"
```

### Published topics

#### /controller/command
The command to acheive the set point, or 0 when disabled.

### Subscribed topics

#### /hardware/state
The state of the actuator

### hardware_node.py
The hardware node exposes the actuator's API to the ROS ecosystem. ALSO includes a few services to facilitate spinning up your test script.

### Services

#### /hardware/reset
Resets the current hardware model. Equivalent to unplugging the actuator and plugging it back in again.
```
rosservice call /hardware/reset "{}"
```

#### /hardware/next
Swaps to a NEW hardware model. Equivalent to unplugging the actuator and plugging in A NEW ACTUATOR.
```
rosservice call /hardware/next "{}"
```

### Published topics

#### /hardware/state
The state of the actuator

### Subscribed topics

#### /controller/command
The command to acheive the set point, or 0 when disabled.
