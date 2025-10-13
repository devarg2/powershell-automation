<#
.SYNOPSIS
    Day 4 of learning the fundamentals of Powershell

.DESCRIPTION
    Learning about the try catch blocks

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Make a function that throws an error

function ThrowError {
    throw "A error has occurred!"
}

# Try catch block calls ThrowError function
try {
    ThrowError
}
catch {
    Write-Output "Caught an exception: $_"
}