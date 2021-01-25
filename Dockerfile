FROM ubuntu:20.04 as dev

ENV ROBOT_WS="/home/robot" \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    ROS_DISTRO=noetic \
    ROS_PYTHON_VERSION=3 \
    UBUNTU_NAME=focal

# Use /bin/bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

WORKDIR $ROBOT_WS
RUN apt-get update && \
    apt-get install -y lsb-release gnupg && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'  && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt update && \
    apt install -y ros-noetic-ros-base && \
    apt install -y cmake python3-catkin-pkg python3-empy python3-nose python3-setuptools libgtest-dev build-essential python3-catkin-tools

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && source ~/.bashrc

RUN mkdir -p catkin_ws/src
COPY catkin_ws/src catkin_ws/src/

RUN source /opt/ros/noetic/setup.bash && \
    cd catkin_ws && \
    catkin_make && \
    echo "source ${ROBOT_WS}/catkin_ws/devel/setup.bash" >> ~/.bashrc

