#!/usr/bin/env bash
# ==============================================================================
# setup-ec2.sh
# Purpose: Prepares a fresh Ubuntu EC2 instance for the incident simulator.
# ==============================================================================

# Exit immediately if a command fails
set -e

echo "=== Setting up EC2 Incident Simulator Environment ==="

# 1. Update package list
echo "[1/3] Updating package repositories..."
sudo apt-get update -y

# 2. Install essential tools for networking and troubleshooting
echo "[2/3] Installing Nginx, curl, and network diagnostic tools..."
sudo apt-get install -y nginx curl net-tools iptables

# 3. Ensure Nginx web server is started and running
echo "[3/3] Starting Nginx web server..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "=== Setup Complete! Nginx is running on port 80 ==="
echo "Test it locally with: curl http://localhost"
