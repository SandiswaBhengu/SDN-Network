#!/bin/bash
# Open vSwitch Docker One-Click Setup Script
# This script builds, runs, and verifies an OVS Docker container

set -e

IMAGE_NAME="gns3/openvswitch"
CONTAINER_NAME="ovs_container"

# Step 1: Create Dockerfile if it doesn't exist
if [ ! -f Dockerfile ]; then
    echo "Creating Dockerfile..."
    cat << 'EOF' > Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install OVS and networking tools
RUN apt update && apt install -y \
    openvswitch-switch \
    iproute2 \
    iputils-ping \
    net-tools \
    tcpdump \
    && rm -rf /var/lib/apt/lists/*

# Start OVS service when container starts
CMD service openvswitch-switch start && bash
EOF
fi

# Step 2: Build the Docker image
echo "Building Docker image $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

# Step 3: Run the container
echo "Running OVS container as $CONTAINER_NAME..."
docker run -it --name $CONTAINER_NAME --privileged $IMAGE_NAME bash

# Step 4: Optional verification (inside container)
echo "To verify OVS is running, inside the container run:"
echo "  ovs-vsctl show"

# Bonus: quick host check
echo "You can also run:"
echo "  docker exec -it $CONTAINER_NAME ovs-vsctl show"
