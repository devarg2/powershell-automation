# ⚙️ PowerShell Automation Scripts

A growing collection of **PowerShell scripts** for automating IT tasks.  

---

## 📂 Repository Structure

```
PowerShell-Automation/
│
├── README.md
├── .gitignore
│
├── scripts/
│   ├── network-check.ps1           # Checks Wi-Fi or network environment
│   └── <future-scripts>.ps1        # Additional automation scripts
│
├── config/
│   ├── wifi.json                   # Wi-Fi settings or restrictions
│   └── <future-configs>.json       # Other script configs
│
├── tests/
│   ├── test-network-check.ps1      # Unit tests for network script
│   └── <future-tests>.ps1          # Add test files for new scripts
│
└── docs/
    ├── network-check-tests.md      # Documentation for test logic
    └── <future-docs>.md            # Documentation for new modules
```

---

## 🧠 Design Principles

- **Config over Code:** All environment-specific settings live in `/config` files.
- **Test Before Deploy:** Each major script has a companion test under `/tests`.
- **No Assumptions:** Scripts validate system state before running actions.

---

## 🧰 Getting Started
> Development and testing are done in **Visual Studio Code (VS Code)**
### 1. Clone the Repository
```powershell
git clone https://github.com/mtusalexis/build-scripts.git
```

### 2. Configure
Update config files under `/config` to match your environment:
```json
{
    "requiredForPrinterAccess": "Build Wifi"
}
```

### 3. Run a Script
```powershell
cd scripts
.\network-check.ps1
```

### 4. Run Tests
```powershell
cd tests
.\test-network-check.ps1
```

---

## 🧩 Adding New Scripts

To extend the suite:
1. Add your new PowerShell script to `/scripts`.
2. Create any needed config file(s) under `/config`.
3. (Optional) Add a companion test script under `/tests`.
4. Document your new module in `/docs`.

---

## 🪶 Logging

All scripts should log to a common location (e.g. `/logs/` or system temp).  
Include timestamps and exit codes for consistency.