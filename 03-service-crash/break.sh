#!/usr/bin/env bash
# stops and disables apache — simulates a crashed service that won't come back after reboot
set -euo pipefail

if systemctl is-active --quiet apache2 2>/dev/null; then
  SERVICE="apache2"
elif systemctl is-active --quiet httpd 2>/dev/null; then
  SERVICE="httpd"
else
  echo "apache is already stopped"
  exit 0
fi

sudo systemctl stop "$SERVICE"
sudo systemctl disable "$SERVICE"
echo "broken. $SERVICE stopped and disabled. try: curl http://localhost"
