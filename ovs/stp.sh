#!/bin/bash

BRIDGE="br0"

echo "Enabling STP on bridge $BRIDGE..."

# Enable STP on the bridge
ovs-vsctl set bridge "$BRIDGE" stp_enable=true

echo "STP enabled on $BRIDGE"

echo "Verifying STP status..."
ovs-vsctl list bridge "$BRIDGE" | grep stp
