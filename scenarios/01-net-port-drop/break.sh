#!/usr/bin/env bash
# ==============================================================================
# Scenario 01: break.sh
# Purpose: Simulates a network firewall drop on port 80.
# ==============================================================================

echo ">>> [ALERT] Injecting Scenario 01: Dropping port 80 traffic..."

# Add rule to Linux firewall (iptables) to DROP incoming packets on port 80
sudo iptables -A INPUT -p tcp --dport 80 -j DROP

echo ">>> Done! Port 80 packets are now silently dropped."
echo ">>> Symptom: curl http://localhost will hang and time out."
echo ">>> Try it: curl --connect-timeout 5 http://localhost"
echo ">>> When fixed, run: ./verify.sh"
