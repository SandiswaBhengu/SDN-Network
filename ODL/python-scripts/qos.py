import requests
import json
from requests.auth import HTTPBasicAuth

# ----------------------
# Controller info
# ----------------------
ODL_IP = "192.168.122.182"
ODL_PORT = 8181
USERNAME = "****"
PASSWORD = "****"

# ----------------------
# Switches in topology
# ----------------------
switches = ["openflow:3", "openflow:5", "openflow:8"]  # Replace with your switch node IDs
TABLE_ID = 0

# ----------------------
# High-priority networks
# ----------------------
high_priority_networks = ["10.10.10.80/28", "192.168.122.0/24"]

# ----------------------
# Priority and queues
# ----------------------
HIGH_PRIORITY = 5000
LOW_PRIORITY = 1000
HIGH_QUEUE = 0  # Full speed
LOW_QUEUE = 1   # Throttled

# ----------------------
# Function to push a flow to ODL
# ----------------------
def push_flow(node, flow_id, priority, dst_network, queue_id):
    url = f"http://{ODL_IP}:{ODL_PORT}/restconf/config/opendaylight-inventory:nodes/node/{node}/table/{TABLE_ID}/flow/{flow_id}"
    
    flow_data = {
        "flow": [
            {
                "id": str(flow_id),
                "table_id": TABLE_ID,
                "priority": priority,
                "match": {
                    "ipv4-destination": dst_network
                },
                "instructions": {
                    "instruction": [
                        {
                            "order": 0,
                            "apply-actions": {
                                "action": [
                                    {
                                        "order": 0,
                                        "set-queue-action": {"queue-id": queue_id}
                                    },
                                    {
                                        "order": 1,
                                        "output-action": {"output-node-connector": "NORMAL"}
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        ]
    }

    headers = {"Content-Type": "application/json"}
    response = requests.put(url, auth=HTTPBasicAuth(USERNAME, PASSWORD),
                            headers=headers, data=json.dumps(flow_data))
    if response.status_code in [200, 201, 204]:
        print(f"{node}: Flow to {dst_network} installed successfully (priority={priority}, queue={queue_id})")
    else:
        print(f"{node}: Failed to install flow to {dst_network}")
        print(response.text)

# ----------------------
# Push flows to all switches
# ----------------------
for node in switches:
    flow_id = 1
    
    # High-priority flows
    for net in high_priority_networks:
        push_flow(node, flow_id, HIGH_PRIORITY, net, HIGH_QUEUE)
        flow_id += 1

    # Low-priority catch-all flow
    push_flow(node, flow_id, LOW_PRIORITY, "0.0.0.0/0", LOW_QUEUE)

