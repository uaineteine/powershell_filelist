# Define the master directory path
$masterDirectory = "C:\Path\To\Master\Directory"

# Function to calculate SHA-256 checksum of a file
function Get-FileHash {
    param (
        [string]$filePath
    )
    $hashAlgorithm = [System.Security.Cryptography.SHA256]::Create()
    $fileStream = [System.IO.File]::OpenRead($filePath)
    $hashBytes = $hashAlgorithm.ComputeHash($fileStream)
    $fileStream.Close()
    return [BitConverter]::ToString($hashBytes) -replace "-", ""
}

# Concatenate all file hashes to calculate a folder checksum
$folderHash = Get-ChildItem -Path $masterDirectory -Recurse -File | ForEach-Object {
    Get-FileHash -filePath $_.FullName
} | ForEach-Object { $_ } | Out-String | % { [Text.Encoding]::UTF8.GetBytes($_) } | ForEach-Object {
    $hashAlgorithm.TransformBlock($_, 0, $_.Length, $_, 0)
}
$hashAlgorithm.TransformFinalBlock(@(), 0, 0)
$folderChecksum = [BitConverter]::ToString($hashAlgorithm.Hash) -replace "-", ""

Write-Output "The checksum for the folder is: $folderChecksum"
