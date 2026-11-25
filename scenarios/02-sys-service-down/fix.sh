#!/usr/bin/env bash
# ==============================================================================
# Scenario 02: fix.sh
# Purpose: Starts and enables Nginx, then verifies recovery.
# ==============================================================================

echo ">>> Applying fix: Starting Nginx service..."

# Start Nginx service
sudo systemctl start nginx

# Enable it so it automatically starts after a system reboot
sudo systemctl enable nginx

echo ">>> Fix applied. Running verification..."
bash "$(dirname "$0")/verify.sh"
