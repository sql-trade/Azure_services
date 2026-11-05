
####  run as Administrator !!

cmd-command          net start Audiosrv  
cmd-command          sc config Audiosrv start= auto

powershell    cmd /c net start Audiosrv  
####          ---------------------------


powershell    Start-Service    -Name "Audiosrv"         
              Restart-Service  -Name "Audiosrv" -Force  

####  Startmode "Auto"
Set-Service -Name "Audiosrv"  -StartupType Automatic                  
Get-Service -Name "Audiosrv" | Select-Object Name, StartType, Status  

####  Ausgabe eines "beep"
powershel     [console]::beep( 800, 2000)    ##   800 Hertz, ( 2 sec ) = 2000 millisekunden
powershel     [console]::beep(1000, 2000)    ##                                            
powershel     [console]::beep(1500, 2000)    ##                                            


####  check der "Soundtreiber-Version"
powershell    Get-CimInstance Win32_SoundDevice | Select-Object Manufacturer, Name, Status

## ----  end  ----
