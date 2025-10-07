# Logger Test Script

**File:** `tests/test-logger.ps1`  
**Depends on:**  
- `scripts/logger.ps1`  

---

## Purpose
This script verifies that the **logging utility** in `logger.ps1` works correctly across different log levels and file operations.

It confirms:
- Messages display with proper colors.  
- Log file is created and written correctly.  
- Automatic log **rotation** triggers when size exceeds the set threshold.  
- Old backups are cleaned up as expected.

---

## How It Works

1. Loads the real logger (`scripts/logger.ps1`).  
2. Prints where the log file is located.  
3. Writes several test messages (`INFO`, `WARN`, `ERROR`) to validate colors and formatting.  
4. Confirms the log file was actually created.  
5. Writes a large number of lines to simulate a “full” log and test automatic rotation.  
6. Displays checks to confirm rotation or file size behavior.  
7. Completes with a simple pass/fail output summary.

---

## Test Steps

| Step | Description | Expected Result |
|------|--------------|-----------------|
| 1 | Import `logger.ps1` | Logger loads successfully |
| 2 | Write sample INFO/WARN/ERROR logs | Messages appear with proper colors and tags |
| 3 | Verify log file creation | `build-scripts.log` exists under `/logs` |
| 4 | Simulate large log output | Log grows close to or beyond 50KB |
| 5 | Observe log rotation | New `.bak` log created with timestamp |
| 6 | Cleanup check | Only 3 newest backups retained |

---

## How To Run

From the repo root:

```powershell
PS> cd tests
PS> ./test-logger.ps1
```

Expected output:

```
=== Testing logger.ps1 ===
Log file: C:\path\to\repo\logs\build-scripts.log

[INFO] This is an informational message.
[WARN] This is a warning message.
[ERROR] This is an error message.
Simulating large log for rotation test...


[PASS] Log file created successfully: C:\path\to\repo\logs\build-scripts.log
[CHECK] Log should rotate soon if above threshold.

=== Logger test complete ===
```

After running, check the `/logs` folder — you should see:
- `build-scripts.log` (active log)  
- `build-scripts.log.<timestamp>.bak` (rotated backups)

---

## Troubleshooting

- **No log file created**  
  → Confirm `../logs` exists and PowerShell has write permission to that folder.  

- **Rotation doesn’t trigger**  
  → Lower the rotation threshold in `logger.ps1` (e.g., from `50KB` to `10KB`) and rerun.  

- **Too many backups**  
  → Ensure cleanup section in `logger.ps1` is intact (only 3 most recent `.bak` files kept).  

---

## Notes
- Safe to run multiple times — it only creates or rotates log files.  
- Does **not** require admin privileges.  
- Intended for verifying the logging subsystem used by all build scripts.  

---

**Author:** Alexis Rodriguez  
**Date:** October 2025
