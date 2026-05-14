# production-incident-simulator

I built this to practice diagnosing real infrastructure failures on AWS EC2 + Linux.

Each folder is one scenario. Something is broken. You have to figure out what and fix it.

---

## scenarios

| folder | what breaks | symptom |
|--------|-------------|---------|
| [01-port-blocked](./01-port-blocked/) | iptables blocks port 80 | connection timeout |
| [02-disk-full](./02-disk-full/) | /var partition at 100% | HTTP 500 error |
| [03-service-crash](./03-service-crash/) | apache stopped + disabled | connection refused |

---

## setup

EC2 instance with Apache running. t2.micro free tier works fine.

```bash
# Ubuntu
sudo apt update && sudo apt install -y apache2

# Amazon Linux
sudo yum install -y httpd && sudo systemctl start httpd
```

```bash
git clone https://github.com/dhananjaybhusari/production-incident-simulator.git
cd production-incident-simulator
find . -name "*.sh" -exec chmod +x {} \;
```

## usage

```bash
cd 01-port-blocked

sudo bash break.sh      # breaks the system
sudo bash fix.sh        # fixes it
cat notes.md            # what I learned
```

Try to fix it yourself before looking at notes.md.

---

**stack:** AWS EC2, Ubuntu 22.04, Apache2, Bash, Systemd
