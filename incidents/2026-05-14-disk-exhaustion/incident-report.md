# Incident Report: Simulated /tmp Disk Exhaustion

**Date:** May 14, 2026
**Status:** Resolved
**Domain:** Linux

## Executive Summary
A simulated event was triggered to rapidly exhaust the available disk space, mimicking a scenario where an application's log rotation mechanism fails and bloated logs fill the `/tmp` directory.

## Timeline of Events
* **T+0:** `simulate.sh` executed. A process began writing a continuous stream of zero-bytes to `/tmp/bloated_app.log`.
* **T+2:** System reported critically high disk utilization.
* **T+5:** Diagnostics performed. The file `/tmp/bloated_app.log` was identified as consuming 1GB of space.
* **T+7:** `reset.sh` executed. The bloated file was removed, and normal system disk state was restored.

## Lessons Learned
* **Monitoring:** Alerts must be configured to trigger *before* 100% utilization (e.g., at 85%), as system services may crash if they cannot write to the disk.
* **Isolation:** Application logs should ideally be written to a separate partition (like `/var/log`) rather than the root partition to prevent full system lockups during an exhaustion event.