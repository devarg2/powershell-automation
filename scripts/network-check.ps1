<#
.SYNOPSIS
    Verifies the user is connected to the required corporate Wi-Fi network.

.DESCRIPTION
    Reads the approved network(s) from config/wifi.json.
    Fails if the user is not on the required SSID.

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Load Wi-Fi config
$configPath = Join-Path $PSScriptRoot "..\config\wifi.json"
if (-not (Test-Path $configPath)) {
    Write-Error "Wi-Fi config file not found: $configPath"
    exit 1
}

$config = Get-Content $configPath | ConvertFrom-Json
$requiredSSID = $config.requiredForPrinterAccess

# Get current Wi-Fi SSID
try {
    $ssid = (netsh wlan show interfaces | Select-String '^ *SSID' |
             ForEach-Object { ($_ -split ':')[1].Trim() } |
             Where-Object { $_ -ne "" } | Select-Object -First 1)
} catch {
    Write-Error "Unable to determine current Wi-Fi network."
    exit 1
}

if (-not $ssid) {
    Write-Host "No Wi-Fi connection detected." -ForegroundColor Yellow
    exit 1
}

Write-Host "Connected to SSID: $ssid"

if ($ssid -eq $requiredSSID) {
    Write-Host "[OK] Verified: Connected to required network '$requiredSSID'." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[FAIL] You are not on '$requiredSSID'. Access denied." -ForegroundColor Red
    exit 1
}