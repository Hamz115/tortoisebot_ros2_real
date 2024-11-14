#!/bin/bash

source devel/setup.bash

# First source the ROS2 Galactic setup
source /opt/ros/galactic/setup.bash

# Then source your workspace setup
source /root/colcon_ws/install/setup.bash

# Launch the bring up
ros2 launch tortoisebot_bringup bringup.launch.py use_sim_time:=False


# Execute the command passed into this entrypoint
exec "$@"