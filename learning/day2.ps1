<#
.SYNOPSIS
    Day 2 of learning the fundamentals of Powershell

.DESCRIPTION
    Starting with while loop to more advance topcis

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Make a counter
$counter = 1

# While loop counting from 1 to 10 using less than or equal to
while ($counter -le 10) {
    Write-Host $counter
    $counter += 1
}

# Do while loop using greather than or equal to
Do {
    Write-Host $counter
    $counter -= 1
} while ($counter -ge 0)


# Function
function testing {
    Write-Host "Testing function"
}

# Call function
testing

# Function with param
function testing2 {
    param (
        $number
    )
    Write-Host "The number u entered was $number"
}

# Prompt for input
$answer = Read-Host -Prompt "Enter a number in"

# Call function
testing2 -number $answer