# Runbook: Scenario 03 - Disk Space Exhaustion

---

## 1. What is the Problem?
* **Symptom:** An application crashes or reports `No space left on device`. You try to create or write a file, and Linux rejects it.
* **Root Cause:** A runaway log file (`runaway_error.log`) filled the partition to 100% capacity.

---

## 2. Step-by-Step Troubleshooting

### Step 1: Check overall disk space
```bash
df -h
```
* Look at the `Use%` column.
* You will see that `/mnt/app-storage` is at **`100%`** capacity with `0` available space.

### Step 2: Try writing a test file to confirm the failure
```bash
touch /mnt/app-storage/test.txt
```
* Output: `touch: cannot touch '/mnt/app-storage/test.txt': No space left on device`

### Step 3: Find what is using the space
Run `du` (Disk Usage) inside the full partition and sort largest to smallest:
```bash
sudo du -sh /mnt/app-storage/* | sort -hr
```
* Output will immediately show the culprit:
  ```text
  50M   /mnt/app-storage/runaway_error.log
  ```

---

## 3. How to Fix It (The Senior SRE Trick: Truncate vs. RM)

### Why NOT just run `rm runaway_error.log`?
In Linux, if an application (like Nginx or Java) is currently writing to a log file and you delete it with `rm`, the file disappears from `ls`, **but the disk space is NOT freed** until the application restarts! The running process holds the file open.

### The Safe Production Fix: Truncate
Use `truncate -s 0` to empty the file to 0 bytes instantly without deleting the file or restarting the app:
```bash
sudo truncate -s 0 /mnt/app-storage/runaway_error.log
```

---

## 4. Verify Resolution
Check disk space again:
```bash
df -h /mnt/app-storage
```
* `Use%` will drop down to `1%` or `2%`.

Try creating a file:
```bash
touch /mnt/app-storage/test.txt
```
* The file is created with zero errors!
