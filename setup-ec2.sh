#!/usr/bin/env bash
# ==============================================================================
# setup-ec2.sh
# Purpose: Prepares an EC2 instance (Ubuntu, Amazon Linux 2023, or AL2)
# ==============================================================================

set -e

echo "=== Setting up EC2 Incident Simulator Environment ==="

# 1. Detect package manager (apt-get for Ubuntu/Debian, dnf for AL2023, yum for AL2)
if command -v dnf &>/dev/null; then
    echo "[1/3] Detected Amazon Linux 2023 / Fedora (dnf)"
    sudo dnf update -y
    echo "[2/3] Installing Nginx, net-tools, and iptables..."
    # AL2023 includes curl-minimal by default; do not specify curl to prevent dnf package conflicts
    PACKAGES="nginx net-tools iptables iptables-nft"
    if ! command -v curl &>/dev/null; then
        PACKAGES="$PACKAGES curl"
    fi
    sudo dnf install -y $PACKAGES
elif command -v yum &>/dev/null; then
    echo "[1/3] Detected Amazon Linux 2 / CentOS / RHEL (yum)"
    sudo yum update -y
    echo "[2/3] Installing Nginx, net-tools, and iptables..."
    # If Amazon Linux 2, nginx is in amazon-linux-extras
    if command -v amazon-linux-extras &>/dev/null; then
        sudo amazon-linux-extras enable nginx1 || true
    fi
    PACKAGES="nginx net-tools iptables iptables-services"
    if ! command -v curl &>/dev/null; then
        PACKAGES="$PACKAGES curl"
    fi
    sudo yum install -y $PACKAGES
elif command -v apt-get &>/dev/null; then
    echo "[1/3] Detected Ubuntu / Debian (apt-get)"
    sudo apt-get update -y
    echo "[2/3] Installing Nginx, curl, net-tools, and iptables..."
    sudo apt-get install -y nginx curl net-tools iptables
else
    echo "[ERROR] Unsupported package manager. Please install nginx, curl, net-tools, and iptables manually."
    exit 1
fi

# 3. Ensure Nginx web server is started and running
echo "[3/3] Starting and enabling Nginx service..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo ""
echo "=== Setup Complete! Nginx is running on port 80 ==="
echo "Test it with: curl http://localhost"
