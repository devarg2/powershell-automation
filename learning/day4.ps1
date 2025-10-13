<#
.SYNOPSIS
    Day 4 of learning the fundamentals of Powershell

.DESCRIPTION
    Learning -Item methods such as create, copy, remove, move, and rename.
.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Clean up
Remove-Item .\NewFile.txt
Remove-Item .\NewFolder

# Create a new Directory
New-Item -Path . -Name "NewFolder" -type Directory

# Create a file
New-Item -Path .\NewFolder -Name "NewFile.txt" -ItemType File -Value "Test text file for day 4."

# Copy a file
Copy-Item .\text.txt -Destination .\NewFolder

# Move a file
Move-Item -path .\NewFolder\NewFile.txt -Destination .

# Remove a file
Remove-Item .\NewFolder\text.txt

# Rename a file
Rename-Item -path .\text.txt -NewName text2.txt
