<#
.SYNOPSIS
    Day 3 of learning the fundamentals of Powershell

.DESCRIPTION
    Starting with functions with commandlet binding to more advance topics.

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Function that has parameter validation, you need to pass an integer
function PrintNumber {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int32]$number
    )
    Write-Host "$number"
}

PrintNumber 1