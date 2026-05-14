#!/usr/bin/env bash
# removes the fill file and restarts apache
set -euo pipefail

FILL="/var/tmp/sim-fill"

if [ -f "$FILL" ]; then
  sudo rm -f "$FILL"
  echo "fill file removed"
else
  echo "fill file not found, already clean"
fi

sudo systemctl restart apache2 2>/dev/null || sudo systemctl restart httpd 2>/dev/null
echo "apache restarted"

df -h /var | awk 'NR==2 {print "/var usage: " $5}'
curl -s -o /dev/null -w "status: %{http_code}\n" --max-time 5 http://localhost || echo "still not responding"
