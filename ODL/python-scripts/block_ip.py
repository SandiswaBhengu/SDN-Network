import requests
import json
import subprocess

# ODL controller info
ODL_IP = "192.168.122.182"
ODL_PORT = 8181
USERNAME = "****"
PASSWORD = "****"

# Flow details
NODE_ID = "openflow:1"
TABLE_ID = 0
FLOW_ID = 1
SRC_IP = "172.16.250.50/30"

url = f"http://{ODL_IP}:{ODL_PORT}/restconf/config/opendaylight-inventory:nodes/node/{NODE_ID}/table/{TABLE_ID}/flow/{FLOW_ID}"

flow_data = {
    "flow": [
        {
            "id": str(FLOW_ID),
            "table_id": TABLE_ID,
            "priority": 500,
            "match": {"ipv4-source": SRC_IP},
            "instructions": {
                "instruction": [
                    {"order": 0, "apply-actions": {"action": [{"order": 0, "drop-action": {}}]}}
                ]
            },
        }
    ]
}

headers = {"Content-Type": "application/json"}

# Push flow to ODL
response = requests.put(url, auth=(USERNAME, PASSWORD),
                        headers=headers, data=json.dumps(flow_data))

if response.status_code in [200, 201, 204]:
    print(f"Flow to block {SRC_IP} added successfully!")

    # Trigger Ansible playbook on Ansible VM silently
    subprocess.run([
        "ssh", "admin@192.168.122.182",
        "ansible-playbook -i /home/admin/ansible/inventory1.ini /home/admin/ansible/delete_route.yml > /dev/null 2>&1"
    ])
else:
    print(f"Failed to add flow. Status code: {response.status_code}")
    print(response.text)


