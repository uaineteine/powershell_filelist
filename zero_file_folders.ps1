# Define the master directory path
$masterDirectory = "C:\Path\To\Master\Directory"

# Define the output CSV file path
$outputCsv = "C:\Path\To\Output\EmptyFolders.csv"

# Function to check for empty folders
function Get-EmptyFolders {
    param (
        [string]$path
    )
    Get-ChildItem -Path $path -Directory -Recurse | Where-Object {
        (Get-ChildItem -Path $_.FullName -File).Count -eq 0
    } | Select-Object FullName
}

# Get the list of empty folders
$emptyFolders = Get-EmptyFolders -path $masterDirectory

# Export the list of empty folders to a CSV file
$emptyFolders | Export-Csv -Path $outputCsv -NoTypeInformation

Write-Output "Empty folders have been saved to $outputCsv"
