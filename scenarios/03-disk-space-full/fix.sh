#!/usr/bin/env bash
# ==============================================================================
# Scenario 03: fix.sh
# Purpose: Clears the large log file and verifies recovery.
# ==============================================================================

MOUNT_POINT="/mnt/app-storage"

echo ">>> Applying fix: Truncating runaway log file..."

# Clear the large log file back to 0 bytes
if [ -f "$MOUNT_POINT/runaway_error.log" ]; then
    sudo truncate -s 0 "$MOUNT_POINT/runaway_error.log"
    echo "[OK] Truncated $MOUNT_POINT/runaway_error.log to 0 bytes."
else
    echo "[INFO] No runaway log found."
fi

echo ">>> Fix applied. Running verification..."
bash "$(dirname "$0")/verify.sh"
