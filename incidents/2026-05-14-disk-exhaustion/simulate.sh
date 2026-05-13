#!/bin/bash
# WARNING: Simulates a runaway application filling up the /tmp directory

echo "🚨 [ALERT] Starting simulation: Application log rotation failure..."
echo "Generating 1GB bloated log file in /tmp..."

# Safely create a 1GB dummy file using zeros
dd if=/dev/zero of=/tmp/bloated_app.log bs=1M count=1024 status=progress

echo "❌ [CRITICAL] Simulation active. Disk space consumed."
echo "Run 'ls -lh /tmp/bloated_app.log' to verify."