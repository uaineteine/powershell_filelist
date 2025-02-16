# Define the master directory path
$masterDirectory = "C:\Path\To\Master\Directory"

# Define the output CSV file path
$outputCsv = "C:\Path\To\Output\FileList.csv"

# Get the list of files, their sizes, and their paths recursively
$fileList = Get-ChildItem -Path $masterDirectory -Recurse -File | Select-Object FullName, Length

# Export the list to a CSV file
$fileList | Export-Csv -Path $outputCsv -NoTypeInformation

Write-Output "File list has been generated and saved to $outputCsv"
