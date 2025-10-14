<#
.SYNOPSIS
    Day 5 of learning the fundamentals of Powershell

.DESCRIPTION
    Learning about Piping, and Modules Management.
.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# List all services that are running then pipe to show only Name and Status
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table -Property Name, Status

# Count how many services are stopped
(Get-Service | Where-Object {$_.Status -eq "Stopped"} | Measure-Object).Count

# Sort all processes by memory usage and show top 5
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5

# Get all running services, pipe to Out-File to save to a text file.
Get-Service | Where-Object {$_.Status -eq "Running"} | Out-File test.txt

# Pipe that file into Get-Content and count the lines.
(Get-Content "test.txt" | Measure-Object -Line).Lines

# List all modules by name installed on your system
Get-Module -ListAvailable | Select-Object -ExpandProperty Name

# Find a module on the PowerShell Gallery
Find-Module -Name WindowsDefender

# Install module
Install-Module -Name Microsoft.Graph.Authentication -Scope CurrentUser

# Import the installed module
Import-Module -Name Microsoft.Graph.Authentication

# List all cmdlets for module
Get-Command -Module Microsoft.Graph.Authentication

# Get-Help on one of the cmdlets
Get-Help -Name Connect-MgGraph

#Check module version
(Get-Module -Name Microsoft.Graph.Authentication).Version.ToString()
