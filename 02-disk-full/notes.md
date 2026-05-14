# 02 — disk full

**symptom:** `curl http://localhost` returns 500. apache is running, port is open.

---

## what I checked

```bash
# got 500, not timeout/refused — so apache is running but failing
curl -I http://localhost
# HTTP/1.1 500 Internal Server Error

# check the error log first for 500s
sudo tail -20 /var/log/apache2/error.log
# No space left on device

# that points straight to disk
df -h
# /var is at 100%

# find what's eating the space
du -sh /var/* | sort -rh | head -5
# /var/tmp is massive

sudo find /var/tmp -size +100M
# found: /var/tmp/sim-fill
```

---

## the fix

```bash
sudo rm -f /var/tmp/sim-fill
sudo systemctl restart apache2
```

---

## what I learned

500 means apache is running but something is failing at the application layer. the error log always tells you what — don't guess, just read it.

in this case apache couldn't write the access log because the disk was full. every request failed because of a logging write, not the request itself.

for production I'd set a CloudWatch alarm at 80% disk usage so this never reaches 100%.
