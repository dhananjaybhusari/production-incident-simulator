#!/usr/bin/env bash
# ==============================================================================
# Scenario 01: verify.sh
# Purpose: Tests if port 80 is reachable and working.
# ==============================================================================

echo ">>> Verifying Port 80 connection..."

# Try connecting to port 80 with a 3 second timeout
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 3 http://localhost || echo "FAILED")

if [ "$HTTP_CODE" = "200" ]; then
    echo "[PASS] Port 80 is reachable and web server returned HTTP 200 OK!"
else
    echo "[FAIL] Port 80 is still unreachable or timed out (Result: $HTTP_CODE)."
    echo "Tip: Run 'sudo iptables -L INPUT -n -v' to check for DROP rules."
fi
