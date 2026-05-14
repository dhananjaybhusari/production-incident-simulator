#!/usr/bin/env bash
# removes the iptables drop rule
set -euo pipefail

if sudo iptables -L INPUT -n | grep -q "DROP.*dpt:80"; then
  sudo iptables -D INPUT -p tcp --dport 80 -j DROP
  echo "rule removed"
else
  echo "no block found, nothing to do"
fi

curl -s -o /dev/null -w "status: %{http_code}\n" --max-time 5 http://localhost || echo "still not responding"
