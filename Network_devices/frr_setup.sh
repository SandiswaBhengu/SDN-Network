#!/bin/bash
# FRR Docker One-Click Setup Script
# This script pulls and runs the FRR container

set -e

IMAGE_NAME="paulcrossley/frr:latest"
CONTAINER_NAME="frr_container"

# Step 1: Pull the FRR Docker image
echo "Pulling Docker image $IMAGE_NAME..."
docker pull $IMAGE_NAME

# Step 2: Run the container
echo "Running FRR container as $CONTAINER_NAME..."
docker run -it --name $CONTAINER_NAME --privileged $IMAGE_NAME bash

# Step 3: Optional verification inside container
echo "Inside the container, you can check FRR version with:"
echo "  vtysh -c 'show version'"

# Bonus: quick host check
echo "From host, you can execute commands in the running container:"
echo "  docker exec -it $CONTAINER_NAME vtysh -c 'show version'"

