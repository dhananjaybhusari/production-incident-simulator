#!/usr/bin/env bash
# ==============================================================================
# Scenario 02: break.sh
# Purpose: Simulates a crashed/stopped web service daemon.
# ==============================================================================

# Pre-flight check: ensure systemctl and nginx exist
if ! command -v nginx &>/dev/null; then
    echo "[ERROR] 'nginx' is not installed!"
    echo "Please run: sudo bash setup-ec2.sh"
    exit 1
fi

echo ">>> [ALERT] Injecting Scenario 02: Stopping Nginx web service..."

# Stop the Nginx service
sudo systemctl stop nginx

echo ">>> Done! Nginx service has been stopped."
echo ">>> Symptom: curl http://localhost will immediately say 'Connection refused'."
echo ">>> Try it: curl http://localhost"
echo ">>> When fixed, run: ./verify.sh"
