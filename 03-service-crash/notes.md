# 03 — service crash

**symptom:** `curl http://localhost` gives "connection refused" immediately. no timeout, instant fail.

---

## what I checked

```bash
# refused = nothing listening, check the service first
ss -tlnp | grep :80
# nothing

systemctl status apache2
# inactive (dead)

# also check if it's enabled — important for reboots
systemctl is-enabled apache2
# disabled
```

service was completely down. not just stopped — disabled too, so it wouldn't come back after a reboot either.

---

## the fix

```bash
sudo systemctl start apache2
sudo systemctl enable apache2
```

both commands matter. start fixes it now, enable makes sure it survives a reboot.

I've seen people only run start and wonder why it's broken again after the server restarts.

---

## what I learned

refused vs timeout again — refused means instant rejection, nothing is even listening on that port. go straight to systemctl.

also: always check `is-enabled` not just `is-active`. a service can be running but disabled, which means the next reboot will break it silently.

useful commands when a service is down:
```bash
sudo journalctl -u apache2 -n 50    # last 50 log lines
sudo journalctl -u apache2 --since "10 minutes ago"
sudo apache2ctl configtest          # check for config errors
```
