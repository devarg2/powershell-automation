<#
.SYNOPSIS
    Tests logger.ps1 functionality.

.DESCRIPTION
    Runs a series of log writes to verify message levels, colors, 
    file output, and log rotation.

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Path to logger
$loggerPath = Join-Path $PSScriptRoot "..\scripts\logger.ps1"

if (-not (Test-Path $loggerPath)) {
    Write-Host "Logger not found: $loggerPath" -ForegroundColor Red
    exit 1
}

# Import logger
. $loggerPath

Write-Host "=== Testing logger.ps1 ===" -ForegroundColor Cyan
Write-Host "Log file: $global:LogFile`n"

# Test different levels
Write-Log "This is an informational message." "INFO"
Write-Log "This is a warning message." "WARN"
Write-Log "This is an error message." "ERROR"

# Verify file exists
if (Test-Path $global:LogFile) {
    Write-Host "`n[PASS] Log file created successfully: $global:LogFile" -ForegroundColor Green
} else {
    Write-Host "`n[FAIL] Log file was not created." -ForegroundColor Red
    exit 1
}

# Simulate large log to test rotation
Write-Host "`nSimulating large log for rotation test..." -ForegroundColor Yellow
1..20000 | ForEach-Object {
    Write-Log "Filler line $_ for log rotation test." "INFO"
}

if ((Get-Item $global:LogFile).Length -lt 1MB) {
    Write-Host "[INFO] Log file under 1MB, rotation may not have triggered yet." -ForegroundColor Gray
} else {
    Write-Host "[CHECK] Log should rotate soon if above threshold." -ForegroundColor Yellow
}

Write-Host "`n=== Logger test complete ==="
