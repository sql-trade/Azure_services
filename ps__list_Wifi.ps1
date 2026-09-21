
## ----------------------------
Write-Host
Write-Host "show Wifi ..."

netsh wlan show profile

Write-Host
Write-Host "export Wifi-Details to Folder ..."

netsh wlan export profile folder=C:\Temp\wifi key=clear  


####  end
####  *************************************************  
