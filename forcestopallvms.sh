#!/bin/bash
# Created by dyeadal
# GNU General Public Licence 3.0

# Prompt to confirm operation
read "DATA LOSS IMMINENT. Not responsible for data loss or system damage that can occur."
read -p "This will force stop all running VMs. Do you want to continue? (YES/n): " confirm

# Check user input
if [[ "$confirm" != "YES" ]]; then
    echo "Operation canceled."
    exit 0
fi

# List all VM IDs on the Proxmox node
vm_ids=$(qm list | awk '{print $1}' | grep -E '^[0-9]+$')

# Loop through each VM ID and force stop
for vmid in $vm_ids; do
    echo "Force stopping VM ID: $vmid"
    qm stop "$vmid"
done

echo "All VMs have been force-stopped."
