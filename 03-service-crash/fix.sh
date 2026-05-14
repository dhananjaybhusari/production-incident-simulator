#!/usr/bin/env bash
# starts and re-enables apache
set -euo pipefail

if systemctl list-unit-files | grep -q "^apache2"; then
  SERVICE="apache2"
elif systemctl list-unit-files | grep -q "^httpd"; then
  SERVICE="httpd"
else
  echo "apache not found"
  exit 1
fi

sudo systemctl start "$SERVICE"
sudo systemctl enable "$SERVICE"
echo "$SERVICE started and enabled"

curl -s -o /dev/null -w "status: %{http_code}\n" --max-time 5 http://localhost || echo "still not responding"
