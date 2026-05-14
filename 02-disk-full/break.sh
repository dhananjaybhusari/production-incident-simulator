#!/usr/bin/env bash
# fills /var to ~100% so apache can't write logs and starts returning 500s
set -euo pipefail

FILL="/var/tmp/sim-fill"

if [ -f "$FILL" ]; then
  echo "already broken, run fix.sh first"
  exit 0
fi

AVAILABLE=$(df -m /var | awk 'NR==2 {print $4}')
FILL_MB=$((AVAILABLE - 30))

if [ "$FILL_MB" -le 0 ]; then
  echo "/var already nearly full (${AVAILABLE}MB left)"
  exit 1
fi

echo "filling ${FILL_MB}MB on /var..."
sudo dd if=/dev/zero of="$FILL" bs=1M count="$FILL_MB" status=progress 2>&1 || true
echo "done. try: curl http://localhost"
