<#
.SYNOPSIS
    Tests the network-check.ps1 script logic by simulating Wi-Fi SSIDs.

.DESCRIPTION
    This test script mocks different SSIDs and verifies that network-check.ps1
    correctly passes or fails based on the required SSID from config/wifi.json.
    It does NOT require changing actual Wi-Fi connections.

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Paths
$scriptPath = Join-Path $PSScriptRoot "..\scripts\network-check.ps1"
$configPath = Join-Path $PSScriptRoot "..\config\wifi.json"

# Load config
if (-not (Test-Path $configPath)) {
    Write-Error "Config not found: $configPath"
    exit 1
}

$config = Get-Content $configPath | ConvertFrom-Json
$requiredSSID = $config.requiredForPrinterAccess

Write-Host "Running network-check tests using required SSID: $requiredSSID"
Write-Host "------------------------------------------------------------`n"

# Mock test cases
$testCases = @(
    @{ Name = "Correct SSID"; SSID = $requiredSSID; ExpectedExit = 0 }
    @{ Name = "Wrong SSID";   SSID = "BUILD Guest";   ExpectedExit = 1 },
    @{ Name = "No SSID";      SSID = $null;         ExpectedExit = 1 }
)

foreach ($test in $testCases) {
    Write-Host "Test: $($test.Name)" -ForegroundColor Cyan
    
    # Load the script into memory(network-check.ps1)
    $original = Get-Content $scriptPath -Raw
    
    try {
        # Replace the whole $ssid assignment line with a mock value
        $mockScript = [regex]::Replace($original, '(?s)\$ssid\s*=\s*\(.*?\)\s*\r?\n', "`$ssid = '$($test.SSID)'`r`n")

        # Fix config path so it points to the actual path not temp
        $mockScript = $mockScript -replace '\$configPath\s*=\s*Join-Path.*', "`$configPath = '$configPath'"
        
        # Builds a file path in your Windows Temp folder for modified script
        $tempFile = Join-Path $env:TEMP "network-check-test.ps1"

        # Write the modified script text ($mockScript) into that temp file
        Set-Content $tempFile $mockScript -Encoding UTF8

        # Run test on modified script
        & powershell -NoProfile -ExecutionPolicy Bypass -File $tempFile | Out-Host
        $exitCode = $LASTEXITCODE

        if ($exitCode -eq $test.ExpectedExit) {
            Write-Host "[PASS] $($test.Name)`n" -ForegroundColor Green
        } else {
            Write-Host "[FAIL] $($test.Name) - expected $($test.ExpectedExit), got $exitCode`n" -ForegroundColor Red
        }
    } finally {
        if (Test-Path $tempFile) { Remove-Item $tempFile -Force }
    }
}
