#!/usr/bin/env bash
# ==============================================================================
# Scenario 02: verify.sh
# Purpose: Tests if Nginx service is running and returning HTTP 200.
# ==============================================================================

echo ">>> Verifying Nginx service status..."

# Check if Nginx systemd unit is active
if ! systemctl is-active --quiet nginx; then
    echo "[FAIL] Nginx service is currently NOT running."
    echo "Tip: Run 'sudo systemctl status nginx' to inspect why."
    exit 1
fi

# Test HTTP response
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 3 http://localhost || echo "FAILED")

if [ "$HTTP_CODE" = "200" ]; then
    echo "[PASS] Nginx is running and returning HTTP 200 OK!"
else
    echo "[FAIL] Nginx is running, but port 80 returned: $HTTP_CODE"
fi
