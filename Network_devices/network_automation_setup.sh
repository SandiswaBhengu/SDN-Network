#!/bin/bash
# Network Automation Appliance Download Script
# Downloads the GNS3 network automation appliance

set -e

APPLIANCE_URL="https://raw.githubusercontent.com/GNS3/gns3-registry/master/appliances/network_automation.gns3a"
OUTPUT_DIR="network_automation"
OUTPUT_FILE="$OUTPUT_DIR/network_automation.gns3a"

# Step 1: Create folder if it doesn't exist
mkdir -p $OUTPUT_DIR

# Step 2: Download the appliance
echo "Downloading Network Automation appliance..."
wget -O $OUTPUT_FILE $APPLIANCE_URL

echo "Download completed: $OUTPUT_FILE"

# Step 3: Instructions for importing into GNS3
echo ""
echo "To import the appliance into GNS3:"
echo "1. Open GNS3."
echo "2. Go to File → Import Appliance."
echo "3. Select $OUTPUT_FILE and follow the wizard."
echo "4. The appliance will be added and ready to use."

