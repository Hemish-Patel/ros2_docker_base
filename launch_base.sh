#!/bin/bash
# Grant local Docker containers access to the X11 display
xhost +local:root

# Detect NVIDIA GPU and launch with Prime offloading
if command -v nvidia-smi &> /dev/null; then
    echo "NVIDIA GPU detected. Launching with hardware acceleration..."
    sudo docker compose -f docker-compose.yml -f docker-compose.nvidia.yml run --rm ros-dev bash
else
    echo "No NVIDIA GPU detected. Launching standard environment..."
    sudo docker compose -f docker-compose.yml run --rm ros-dev bash
fi
