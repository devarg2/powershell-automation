<#
.SYNOPSIS
    Learning the fundamentals of Powershell

.DESCRIPTION
    From simple "Hello World" to more advanced topics

.NOTES
    Author: Alexis Rodriguez
    Date: October 2025
#>

# Print Hello World
Write-Host "Hello World"

# Make a variable
$name = "Alexis"

# Print variable
Write-Host $name

# Pip variable into file
$name | Out-File text.txt

# Print file contents
Get-Content .\text.txt

# Clear variable
Clear-Variable -name "name"

# Print variable after clearing
Write-Host $name

# Set variable to new value
Set-Variable -name "name" -Value "Erik"

# Print variable after changing it
Write-Host $name

# Get type of variable
$name.GetType()

# Get length of variable
$name.Length

# Check if variable contains letter 'e'
$name.Contains('E')

# Simple if check
if ($name.Contains('r')) {
    Write-Host "Yes"
} else {
    Write-Host "No"
}

# Use variable in string
Write-Host "Hello $name"

# Concatenation
$name = $name + " Rosas"

# Print variable after Concatenation
$name

# Change variable type to double
Set-Variable -name "name" -Value 5.5

# Check variable type
$name.GetType()

# Print variable after change
$name

# Change variable type to boolean
Set-Variable -name "name" -Value $false

# Check variable type
$name.GetType()

# Print variable after change
$name

# Simple math
$x = 4
$y = 10
$z = $x + $y

# Print z variable
$z

# Make new variable
New-Variable -Name "name2" -Value "Alexis"

# Print new variable
$name2

# Make an array
$animals = @( 'cat', 'dog', 'cow', 'fox')

# Print array
$animals

# Print array values next to each other separate by a space
Write-Host($animals -join, " ")

# Print array using for loop
$animals | ForEach-Object {
    Write-Host "Animal: $_"
}

# Add to array
$animals += "bat"

# Print array after change
$animals

# Get first index of array
$animals[0]

# Make a hash table
$hashtable = @{key1 = "item1"; key2 = "item2"; key3 = "item3"}

# Print hash table
$hashtable

# Add to hash table
$hashtable.Add("key4", "item4")

# Print hash table after adding
Write-Host "After:`n"
$hashtable

# Set item in hash table
$hashtable.Set_Item("key1","item0")

# Print new value
$hashtable["key1"]

# Remove key pair from hash table
$hashtable.Remove("key1")

# Print hash table after removing
Write-Host "After removing:`n"
$hashtable

# Get input from user
Write-Host "Hello User"
$UserName = Read-Host -Prompt "What is your name?"

# Print welcome message with user's name from input
Write-Host "Hello $UserName!"

# Make an array
$movies = @( 'Ready Player 1', 'Scarface', 'The Dark Knight', 'The Shining', "Toy Story")


# Counter for For Loop
$counter = 1

# Loop through movies array
$movies | ForEach-Object {
    Write-Host "$counter : $_"
    $counter++
}

# Get input from user
$answer = Read-Host -Prompt "What is your favorite movie?"

# If check with or, less than, and greather than plus response with answer
If ( $answer -lt 1 -or $answer -gt 5) {
    Write-Host "Wrong choice!"
} else {
    Write-Host "I like $($movies[$answer-1]) too!"
}
