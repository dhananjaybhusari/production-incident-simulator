#!/usr/bin/env bash
# ==============================================================================
# Scenario 01: break.sh
# Purpose: Simulates a network firewall drop on port 80.
# ==============================================================================

# Pre-flight check: ensure iptables is installed
if ! command -v iptables &>/dev/null; then
    echo "[ERROR] 'iptables' command not found!"
    echo "Please run: sudo bash setup-ec2.sh"
    exit 1
fi

echo ">>> [ALERT] Injecting Scenario 01: Dropping port 80 traffic..."

# Add rule to Linux firewall to DROP incoming packets on port 80 (IPv4 and IPv6)
sudo iptables -I INPUT 1 -p tcp --dport 80 -j DROP
if command -v ip6tables &>/dev/null; then
    sudo ip6tables -I INPUT 1 -p tcp --dport 80 -j DROP 2>/dev/null || true
fi

echo ">>> Done! Port 80 packets are now silently dropped."
echo ">>> Symptom: curl http://localhost will hang and time out."
echo ">>> Try it: curl --connect-timeout 5 http://localhost"
echo ">>> When fixed, run: ./verify.sh"
