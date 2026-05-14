# 01 — port blocked

**symptom:** `curl -m 5 http://localhost` times out. browser just spins.

---

## what I checked

```bash
# apache running?
systemctl status apache2
# yes, active

# anything on port 80?
ss -tlnp | grep :80
# yes, apache is listening

# so the problem is between the network and apache
sudo iptables -L INPUT -n
# found: DROP rule on dpt:80
```

apache was up, port was bound, but traffic never reached it. had to be the firewall.

---

## the fix

```bash
sudo iptables -D INPUT -p tcp --dport 80 -j DROP
```

in AWS the real version of this is: EC2 → Security Groups → Inbound rules → add HTTP port 80 back.

---

## what I learned

timeout vs refused means completely different things:

- **timeout** — packet is being dropped (firewall, security group). something is actively blocking it
- **refused** — nothing is listening on that port. the service is down

that one distinction saved me from wasting time checking the wrong thing. if it times out, check the network layer first, not the application.
