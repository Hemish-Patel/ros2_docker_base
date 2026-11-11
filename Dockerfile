FROM osrf/ros:humble-desktop

# Install basic development extensions
RUN apt-get update && apt-get install -y \
    nano \
    python3-colcon-common-extensions \
    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

# Enable NVIDIA GPU passthrough for X11/GLX rendering
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compute,utility
ENV __NV_PRIME_RENDER_OFFLOAD=1
ENV __GLX_VENDOR_LIBRARY_NAME=nvidia

# Set up the workspace
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws

# Auto-source ROS 2 on container entry
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

CMD ["/bin/bash"]
