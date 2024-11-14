FROM arm64v8/ros:galactic-ros-base

# Install the neccecasry packages
RUN apt-get update && apt-get install -y \
    ros-galactic-joint-state-publisher \
    ros-galactic-robot-state-publisher \
    ros-galactic-cartographer \
    ros-galactic-cartographer-ros \
    ros-galactic-gazebo-plugins \
    ros-galactic-teleop-twist-keyboard \
    ros-galactic-teleop-twist-joy \
    ros-galactic-xacro \
    ros-galactic-nav2* \
    ros-galactic-urdf \
    && rm -rf /var/lib/apt/lists/*

# Colcon workspace
WORKDIR /root/colcon_ws/src
RUN /bin/bash -c "source /opt/ros/galactic/setup.bash && mkdir -p /root/colcon_ws/src"

# Other dependencies 
RUN apt-get update && apt-get install -y \
    ros-galactic-rviz2 \
    python3-rpi.gpio \
    ros-galactic-v4l2-camera \
    && rm -rf /var/lib/apt/lists/*

# Tortoisebot repository

RUN git clone -b ros2-galactic https://github.com/rigbetellabs/tortoisebot.git /root/colcon_ws/src/tortoisebot

WORKDIR /root/colcon_ws
RUN /bin/bash -c "source /opt/ros/galactic/setup.bash && colcon build"

# Source the workspace
RUN echo "source /root/colcon_ws/install/setup.bash" >> /root/.bashrc

# Set UP ENTRY
COPY ./real-entrypoint.sh ./entrypoint.sh
RUN chmod +x entrypoint.sh

# /bin/bash 
ENTRYPOINT ["/bin/bash"]

# Execute
CMD ["./entrypoint.sh"]