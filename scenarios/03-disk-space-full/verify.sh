#!/usr/bin/env bash
# ==============================================================================
# Scenario 03: verify.sh
# Purpose: Tests if /mnt/app-storage has free space and can write files.
# ==============================================================================

MOUNT_POINT="/mnt/app-storage"

echo ">>> Verifying disk space on $MOUNT_POINT..."

# Check if mount point exists
if ! mountpoint -q "$MOUNT_POINT"; then
    echo "[FAIL] $MOUNT_POINT is not mounted. Run ./break.sh first."
    exit 1
fi

# Check available megabytes on the mount point
AVAIL_MB=$(df -m "$MOUNT_POINT" | awk 'NR==2 {print $4}')

# Try writing a small test file
if sudo touch "$MOUNT_POINT/test_health.tmp" 2>/dev/null; then
    sudo rm -f "$MOUNT_POINT/test_health.tmp"
    CAN_WRITE="YES"
else
    CAN_WRITE="NO"
fi

if [ "$AVAIL_MB" -ge 10 ] && [ "$CAN_WRITE" = "YES" ]; then
    echo ""
    echo "[PASS] Disk has ${AVAIL_MB}MB free space and can write files successfully!"
    echo ""
else
    echo ""
    echo "[FAIL] Still broken! Available space: ${AVAIL_MB}MB (Writable: $CAN_WRITE)"
    echo "Tip: Run 'df -h $MOUNT_POINT' and 'du -sh $MOUNT_POINT/*' to find the space hog."
    echo ""
fi
