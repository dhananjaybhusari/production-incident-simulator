#!/usr/bin/env bash
# blocks port 80 with iptables — same effect as removing the AWS Security Group HTTP rule
set -euo pipefail

if ! systemctl is-active --quiet apache2 2>/dev/null && \
   ! systemctl is-active --quiet httpd 2>/dev/null; then
  echo "apache is not running, start it first"
  exit 1
fi

if sudo iptables -L INPUT -n | grep -q "DROP.*dpt:80"; then
  echo "already broken, run fix.sh first"
  exit 0
fi

sudo iptables -I INPUT -p tcp --dport 80 -j DROP
echo "broken. try: curl -m 5 http://localhost"
