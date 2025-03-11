
Write-Host "compare 2 Files with Hash-Algo ..."
##--------------------------------------------------------
Write-Host

$file1 = "C:\Users\" + ([environment]::UserName) + "\Documents\ATAS\Workspaces_v3\RAIN_workspace.ws"
$file2 = "C:\Projects\ATAS_ipc_learn\add.files\RAIN_workspace.ws"

# Get the file hashes
$hash1 = Get-FileHash $file1 -Algorithm "SHA256"
$hash2 = Get-FileHash $file2 -Algorithm "SHA256"

Write-Host "fileHash1: " $hash1
Write-Host "fileHash2: " $hash2

Write-Host
Write-Host "----"

