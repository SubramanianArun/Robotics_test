# Testing a Buggy Robot

## System Setup

This project was developed and tested using ROS Noetic + Python 3.  If you already have a different ROS version installed, you may tweak the source code as needed. For a quick promer on ROS, see http://wiki.ros.org/ROS/Tutorials.

### ROS Noetic (option 1)

Follow these steps to setup ROS: http://wiki.ros.org/noetic/Installation/Ubuntu (see Dockerfile for a reference).

### Docker (option 2)

Ensure you have a relatively recent version of docker (https://docs.docker.com/engine/install/).  From the root of the project directory 

```
docker build . -t buggy_robot
docker run -it buggy_robot:latest /bin/bash
```

## Running the Buggy Robot

Once ROS is installed and your workspace is setup, build the message files (e.g. use `catkin_make` from the root of the `catkin_ws`).  If you're in the container this will already be done.

Then, launch both nodes with:

```
roslaunch buggy_robot buggy_robot.launch
```

Additional notes on how the buggy robot node operate can be found in the package's README.
