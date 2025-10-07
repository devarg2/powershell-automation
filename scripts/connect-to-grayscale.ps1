<#
.SYNOPSIS
    Connects the current user to a shared network printer hosted on \\bld-print,
    only if they pass the Wi-Fi validation check.

.DESCRIPTION
    - Runs network-check.ps1 to ensure the user is on the correct Wi-Fi.
    - Uses logger.ps1 for structured logging.
    - If validation passes, connects to \\bld-print\FollowMe-Grayscale.

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Import logger
. "$PSScriptRoot\logger.ps1"

# --- Run Wi-Fi validation first ---
$networkCheckScript = Join-Path $PSScriptRoot "network-check.ps1"

if (-not (Test-Path $networkCheckScript)) {
    Write-Log "network-check.ps1 not found at $networkCheckScript" "ERROR"
    exit 1
}

Write-Log "Running Wi-Fi validation before connecting to printer..." "INFO"

& powershell -NoProfile -ExecutionPolicy Bypass -File $networkCheckScript
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    Write-Log "Wi-Fi validation failed. Printer connection aborted." "ERROR"
    exit 1
}

Write-Log "Wi-Fi validation passed. Proceeding with printer connection..." "INFO"

# --- Define printer ---
$printerName = "FollowMe-Grayscale"
$printerShare = "\\bld-print\$printerName"

# --- Check for existing printer ---
$existingPrinter = Get-Printer | Where-Object { $_.Name -eq $printerName }

if ($existingPrinter) {
    Write-Log "Printer '$printerName' is already installed." "INFO"
    exit 0
}

# --- Attempt to add printer ---
try {
    Add-Printer -ConnectionName $printerShare
    Write-Log "Successfully connected to printer: $printerShare" "INFO"
    exit 0
} catch {
    Write-Log "Failed to connect to printer: $printerShare" "ERROR"
    Write-Log $_.Exception.Message "ERROR"
    exit 1
}
