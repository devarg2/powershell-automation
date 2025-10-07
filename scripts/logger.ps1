<#
.SYNOPSIS
    Simple reusable logger for all build scripts.

.DESCRIPTION
    Provides Write-Log function to write timestamped messages to both
    the console and a shared log file in ../logs.
    Automatically rotates logs larger than 1MB and keeps the 3 most recent backups.

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Ensure logs directory exists
$logDir = Join-Path $PSScriptRoot "..\logs"
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir | Out-Null
}

# Set default log file
$global:LogFile = Join-Path $logDir "build-scripts.log"

function Write-Log {
    param(
        [string]$Message,
        [ValidateSet("INFO", "WARN", "ERROR")]
        [string]$Level = "INFO"
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "[$timestamp] [$Level] $Message"

    # Console color based on level
    switch ($Level) {
        "INFO"  { Write-Host $entry -ForegroundColor Gray }
        "WARN"  { Write-Host $entry -ForegroundColor Yellow }
        "ERROR" { Write-Host $entry -ForegroundColor Red }
    }

    # Write to file
    Add-Content -Path $global:LogFile -Value $entry
}

# --- Log rotation and cleanup ---
if ((Test-Path $global:LogFile) -and ((Get-Item $global:LogFile).Length -gt 50KB)) {
    $timestamp = (Get-Date).ToString('yyyyMMdd_HHmmss')
    $archive = "$global:LogFile.$timestamp.bak"

    Move-Item $global:LogFile $archive -Force
    Write-Host "[INFO] Rotated log file: $archive" -ForegroundColor Cyan

    # Keep only the 3 newest backups
    $backups = Get-ChildItem $logDir -Filter "build-scripts.log.*.bak" |
               Sort-Object LastWriteTime -Descending

    if ($backups.Count -gt 3) {
        $oldOnes = $backups | Select-Object -Skip 3
        foreach ($file in $oldOnes) {
            Remove-Item $file.FullName -Force
            Write-Host "[INFO] Removed old log backup: $($file.Name)" -ForegroundColor DarkGray
        }
    }
}
