#!/usr/bin/env bash
# ==============================================================================
# Scenario 02: break.sh
# Purpose: Simulates a crashed/stopped web service daemon.
# ==============================================================================

echo ">>> [ALERT] Injecting Scenario 02: Stopping Nginx web service..."

# Stop the Nginx service
sudo systemctl stop nginx

echo ">>> Done! Nginx service has been stopped."
echo ">>> Symptom: curl http://localhost will immediately say 'Connection refused'."
echo ">>> Try it: curl http://localhost"
echo ">>> When fixed, run: ./verify.sh"
