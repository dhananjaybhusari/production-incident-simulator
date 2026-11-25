# Runbook: Scenario 02 - Service Down (Connection Refused)

---

## 1. What is the Problem?
* **Symptom:** You run `curl http://localhost` and it fails instantly with `curl: (7) Failed to connect to localhost port 80: Connection refused`.
* **Root Cause:** The Nginx web server service is stopped. No program is listening on port 80.

---

## 2. Key Concept: "Connection Refused" vs "Connection Timed Out"

* **Connection Timed Out (Scenario 01):** The request hangs. A firewall silently dropped the packet into a black hole.
* **Connection Refused (Scenario 02):** The response is instant. The packet reached the server, but the operating system kernel looked for a program on port 80, found nothing, and replied with a `TCP RST` (Reset) saying: *"Nobody is listening on this port."*

---

## 3. Step-by-Step Troubleshooting

### Step 1: Observe the error
```bash
curl http://localhost
```
* Notice that it fails **instantly** with `Connection refused`.

### Step 2: Check if any process is listening on port 80
```bash
sudo ss -tuln | grep :80
```
* Output is **empty**. Nothing is listening on port 80.

### Step 3: Check Nginx service status
```bash
sudo systemctl status nginx
```
* You will see: `Active: inactive (dead)`. This confirms Nginx is not running.

---

## 4. How to Fix It

### Start Nginx:
```bash
sudo systemctl start nginx
```

### Make sure Nginx starts automatically on reboot:
```bash
sudo systemctl enable nginx
```

### Verify it is working:
```bash
curl -I http://localhost
```
You will immediately get: `HTTP/1.1 200 OK`.
