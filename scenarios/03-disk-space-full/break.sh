#!/usr/bin/env bash
# ==============================================================================
# Scenario 03: break.sh
# Purpose: Simulates a 100% full disk partition in a safe, controlled way.
# ==============================================================================

echo ">>> [ALERT] Injecting Scenario 03: Creating 100% full storage partition..."

# Create a safe 50MB mock storage disk using a loopback image
# (This simulates a full disk without risking crashing your main EC2 root drive!)
MOCK_IMG="/tmp/mock_disk.img"
MOUNT_POINT="/mnt/app-storage"

sudo mkdir -p "$MOUNT_POINT"

# If not mounted yet, create and mount the 50MB disk
if ! mountpoint -q "$MOUNT_POINT"; then
    sudo dd if=/dev/zero of="$MOCK_IMG" bs=1M count=50 status=none
    sudo mkfs.ext4 -F "$MOCK_IMG" >/dev/null 2>&1
    sudo mount -o loop "$MOCK_IMG" "$MOUNT_POINT"
fi

# Fill the mount point to 100% by writing a dummy log file
echo ">>> Writing runaway mock log file to fill the disk to 100%..."
sudo dd if=/dev/zero of="$MOUNT_POINT/runaway_error.log" bs=1M count=50 status=none 2>&1 || true

echo ""
echo ">>> Done! $MOUNT_POINT is now 100% FULL."
echo ">>> Symptom: Any write or touch in $MOUNT_POINT will fail with 'No space left on device'."
echo ">>> Try it: touch $MOUNT_POINT/new_file.txt"
echo ">>> When fixed, run: ./verify.sh"
