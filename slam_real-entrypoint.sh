#!/bin/bash

# First source the ROS2 Galactic setup
source /opt/ros/galactic/setup.bash

# Then source your workspace setup
source /root/colcon_ws/install/setup.bash

# Launch the bring up sequentially
ros2 launch tortoisebot_slam cartographer.launch.py use_sim_time:=False slam:=True && \

sleep 5s && \

ros2 launch tortoisebot_description rviz.launch.py

# Execute the command passed into this entrypoint
exec "$@"