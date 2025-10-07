# Network Check Test Script

**File:** `tests/test-network-check.ps1`  
**Depends on:**  
- `scripts/network-check.ps1`  
- `config/wifi.json`  

---

## Purpose
This script verifies that the **Wi-Fi validation logic** in `network-check.ps1` works as expected — without actually changing or connecting to different networks.

It does this by **mocking the Wi-Fi SSID** inside a temporary copy of the script and then running it to confirm it exits correctly.

---

## How It Works

1. Loads the real script (`scripts/network-check.ps1`) into memory.  
2. Replaces the `$ssid` assignment with a **fake (mocked)** value for each test case.  
3. Fixes `$configPath` so it still points to the actual repo’s config file (not the temp directory).  
4. Saves the modified script as a temporary file in the system’s Temp folder.  
5. Runs that file in a new PowerShell process.  
6. Compares the exit code:
   - `0` → expected pass  
   - `1` → expected fail  
7. Deletes the temp file after the test finishes.

---

## Test Cases

| Test Name     | Mock SSID        | Expected Exit | Description |
|----------------|------------------|----------------|--------------|
| Correct SSID   | BUILDers Wifi    | 0              | Matches required network |
| Wrong SSID     | BUILD Guest      | 1              | Should fail — wrong Wi-Fi |
| No SSID        | *(null)*         | 1              | Should fail — not connected |

---

## How To Run

From the repo root:

```powershell
PS> cd tests
PS> ./test-network-check.ps1
```

You should see results like:

```
Running network-check tests using required SSID: BUILDers Wifi
------------------------------------------------------------

Test: Correct SSID
Connected to SSID: BUILDers Wifi
[OK] Verified: Connected to required network 'BUILDers Wifi'.
[PASS] Correct SSID

Test: Wrong SSID
[FAIL] You are not on 'BUILDers Wifi'. Access denied.
[PASS] Wrong SSID
```

---

## Troubleshooting

- **Error: Wi-Fi config file not found**  
  → Make sure `config/wifi.json` exists and contains:
  ```json
  {
      "requiredForPrinterAccess": "BUILDers Wifi"
  }
  ```

- **Tests all fail**  
  → Check that `$PSScriptRoot` paths resolve correctly in your environment.

---

## Notes
- No admin rights needed.  
- Does not modify system settings or network connections.  
- Safe to run repeatedly.

---

**Author:** Alexis Rodriguez  
**Date:** October 2025
