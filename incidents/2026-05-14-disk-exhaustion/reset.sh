#!/bin/bash
# Run this to clean up the environment after the simulation

echo "🛠️ [RECOVERY] Initiating auto-remediation..."

# Remove the dummy file
rm -f /tmp/bloated_app.log

echo "✅ [RESOLVED] System restored. Disk space normalized."