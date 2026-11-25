# Runbook: Scenario 01 - Network Port Drop

---

## 1. What is the Problem?
* **Symptom:** You run `curl http://localhost` and it hangs for 15 seconds, then fails with `Connection timed out`.
* **Root Cause:** A firewall rule in Linux (`iptables`) is secretly dropping all packets coming to port 80.

---

## 2. Step-by-Step Troubleshooting

### Step 1: Test the connection
```bash
curl --connect-timeout 5 http://localhost
```
* If it says **Connection timed out**, it means the packet was dropped on the way. The server never sent any reply back.

### Step 2: Check if Nginx is actually running
```bash
sudo systemctl status nginx
```
* If Nginx is `active (running)`, you know the software itself is healthy.

### Step 3: Check if Nginx is listening on port 80
```bash
sudo ss -tuln | grep :80
```
* You should see port `80` listed in `LISTEN` state. This proves Nginx is ready and waiting for requests.

### Step 4: Check the Linux firewall
```bash
sudo iptables -L INPUT -n -v
```
* Look at the rules. You will see a rule that says **`DROP tcp dpt:80`**.
* Every time you run `curl`, the packet counter next to that rule increases. This proves the firewall is dropping your traffic.

---

## 3. How to Fix It
Remove the DROP rule from iptables:
```bash
sudo iptables -D INPUT -p tcp --dport 80 -j DROP
sudo ip6tables -D INPUT -p tcp --dport 80 -j DROP 2>/dev/null || true
```

Now test again:
```bash
curl -I http://localhost
```
You should immediately see `HTTP/1.1 200 OK`.
