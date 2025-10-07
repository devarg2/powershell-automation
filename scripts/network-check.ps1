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

# Import the logger
. "$PSScriptRoot\logger.ps1"

# Load Wi-Fi config
$configPath = Join-Path $PSScriptRoot "..\config\wifi.json"
if (-not (Test-Path $configPath)) {
    Write-Log "Wi-Fi config file not found: $configPath" "ERROR"
    exit 1
}

$config = Get-Content $configPath | ConvertFrom-Json
$requiredSSID = $config.requiredForPrinterAccess

Write-Log "Loaded Wi-Fi config. Required SSID: $requiredSSID" "INFO"

# Get current Wi-Fi SSID
try {
    $ssid = (netsh wlan show interfaces | Select-String '^ *SSID' |
             ForEach-Object { ($_ -split ':')[1].Trim() } |
             Where-Object { $_ -ne "" } | Select-Object -First 1)
} catch {
    Write-Log "Unable to determine current Wi-Fi network." "ERROR"
    exit 1
}

if (-not $ssid) {
    Write-Log "No Wi-Fi connection detected." "WARN"
    exit 1
}

Write-Log "Connected to SSID: $ssid" "INFO"

if ($ssid -eq $requiredSSID) {
    Write-Log "Verified: Connected to required network '$requiredSSID'." "INFO"
    exit 0
} else {
    Write-Log "You are not on '$requiredSSID'. Access denied." "ERROR"
    exit 1
}
