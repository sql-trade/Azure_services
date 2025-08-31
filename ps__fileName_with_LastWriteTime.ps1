
Write-Host
Write-Host "get fileNames plus fileLength and LastWriteTime ..."
##-----------------------------------------------------------
Write-Host

$folder  = "C:\Users\" + ([environment]::UserName) + "\Documents\NinjaTrader 8"
$outfile = "C:\temp\fileList_with_Length_and_LastWriteTime_v01.txt"

# get fileNames plus fileLength and LastWriteTime
Get-ChildItem -path $folder -Recurse | out-File $outFile

Write-Host
Write-Host "finished"
Write-Host "fileName:" $outFile 
Write-Host "----"