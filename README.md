# ROS 2 Hardware-Accelerated Docker Environment

This repository contains the foundational Docker infrastructure for ROS 2 Humble development. It is engineered to run natively on Ubuntu 22.04 with explicit NVIDIA GPU passthrough, completely bypassing WSL2 network bottlenecks and XLaunch software rendering issues.

## Architecture & Files

* **`Dockerfile`**: Builds the core environment from `osrf/ros:humble-desktop`. It installs essential dependencies (`mesa-utils`) and bakes in the required environment variables (`__NV_PRIME_RENDER_OFFLOAD=1` and `__GLX_VENDOR_LIBRARY_NAME=nvidia`) to force OpenGL rendering directly to the dedicated GPU instead of falling back to Intel integrated graphics.
* **`docker-compose.yml`**: Manages the runtime infrastructure as code. It mounts the host network, binds the X11 display socket (`/tmp/.X11-unix`), and reserves the physical NVIDIA GPU for the container, ensuring complex CLI flags aren't needed at runtime.
* **`launch_sellafield.sh`**: A lightweight bash script that grants local X11 display permissions (`xhost +local:root`) and boots the interactive container via Docker Compose.

## Usage Instructions

### 1. Launching the Environment
To spin up the container and attach the host display and GPU, execute the launch script
bash
./launch_sellafield.sh

*(Note: This is mapped locally to the `.bashrc` alias `sellafield-ros` for instant terminal access).*

### 2. Verifying GPU Passthrough
Once inside the container's root shell (`root@hostname:/ros2_ws#`), run the following command to test 3D hardware acceleration:
bash
glxgears
If the gears render smoothly at the monitor's refresh rate without `libGL` driver errors, the NVIDIA Prime offloading is functioning correctly.

### 3. Exiting
To kill the container and destroy the temporary file system, simply type:
bash
exit
