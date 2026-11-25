#!/usr/bin/env bash
# ==============================================================================
# Scenario 01: fix.sh
# Purpose: Removes the iptables DROP rule and verifies port 80.
# ==============================================================================

echo ">>> Applying fix: Removing firewall DROP rule..."

# Delete the DROP rule from iptables
sudo iptables -D INPUT -p tcp --dport 80 -j DROP 2>/dev/null || true

echo ">>> Fix applied. Running verification..."
bash "$(dirname "$0")/verify.sh"
