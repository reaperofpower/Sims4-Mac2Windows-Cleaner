
# Define the target folder and log file path
$targetFolder = "E:\Mods"
$logFile = "E:\deleted_files_log.txt"

# Clear the log file if it exists
if (Test-Path $logFile) {
    Clear-Content -Path $logFile
}

# Get all files recursively that start with a dot
$dotFiles = Get-ChildItem -Path $targetFolder -Recurse -File -Force | Where-Object { $_.Name -like ".*" }

# Remove each file and log the result
foreach ($file in $dotFiles) {
    try {
        Remove-Item -Path $file.FullName -Force
        $logEntry = "Deleted: $($file.FullName)"
        Write-Host $logEntry
        Add-Content -Path $logFile -Value $logEntry
    } catch {
        $logEntry = "Failed to delete: $($file.FullName) - $_"
        Write-Host $logEntry
        Add-Content -Path $logFile -Value $logEntry
    }
}
