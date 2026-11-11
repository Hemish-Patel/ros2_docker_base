#!/bin/bash
# Grant local Docker containers access to the X11 display
xhost +local:root

# Launch the interactive container using the compose file
sudo docker compose run --rm ros-dev bash
