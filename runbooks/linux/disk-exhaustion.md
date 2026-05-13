# Runbook: Linux Disk Space Exhaustion

## Description
This runbook provides diagnostic and remediation steps for when a Linux instance reports critically high (90%+) disk utilization, often triggering monitoring alarms.

## Diagnostic Steps
1. **Verify overall usage:** Run `df -h` to see which partition is full.
2. **Locate the bloat:** Run `du -sh /* 2>/dev/null | sort -rh | head -n 10` to find the largest top-level directories.
3. **Drill down:** If `/var` or `/tmp` is full, navigate inside and repeat the `du` command to pinpoint the exact file (often runaway logs).

## Remediation Steps
1. **Identify active processes:** Check if a running application is actively writing to the file using `lsof | grep <filename>`.
2. **Truncate (Don't Delete):** If an active process is writing to a log, deleting it will *not* free the disk space (the process keeps the file handle open). Instead, truncate it to zero bytes:
   ```bash
   > /path/to/bloated.log
   ```
3. **Automate Rotation:** Ensure `logrotate` is configured correctly for the offending application to prevent recurrence.