#!/usr/bin/env bash
# ==============================================================================
# Scenario 01: fix.sh
# Purpose: Removes the iptables DROP rule and verifies port 80.
# ==============================================================================

echo ">>> Applying fix: Removing firewall DROP rule..."

# Delete the DROP rule from iptables (both IPv4 and IPv6)
sudo iptables -D INPUT -p tcp --dport 80 -j DROP 2>/dev/null || true
if command -v ip6tables &>/dev/null; then
    sudo ip6tables -D INPUT -p tcp --dport 80 -j DROP 2>/dev/null || true
fi

echo ">>> Fix applied. Running verification..."
bash "$(dirname "$0")/verify.sh"
