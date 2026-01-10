#!/bin/bash

BRIDGE="br0"
BOND="bond0"
IFACES=("eth1" "eth2")

echo "Removing existing interfaces from $BRIDGE..."

for IFACE in "${IFACES[@]}"; do
    ovs-vsctl --if-exists del-port "$BRIDGE" "$IFACE"
done

echo "Creating LACP bond $BOND on $BRIDGE..."

ovs-vsctl add-bond "$BRIDGE" "$BOND" "${IFACES[@]}" \
    lacp=active \
    bond_mode=balance-tcp \
    other_config:lacp-time=fast

echo "LACP bond configuration complete."

echo "Verifying bond status..."
ovs-appctl bond/show "$BOND"

