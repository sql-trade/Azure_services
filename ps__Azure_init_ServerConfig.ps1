
Write-Host ".. start Configuration"
##--------------------------------------------------------
Write-Host
Write-Host "show Windows-Version"
(Get-WmiObject -class Win32_OperatingSystem).Caption

[environment]::OSVersion.VersionString
##[environment]::OSVersion.Version

Write-Host 
Write-Host "MachineName: " ([environment]::MachineName)
Write-Host "DomainName:  " ([environment]::UserDomainName)
Write-Host "UserName:    " ([environment]::UserName)

##--------------------------------------------------------


####  IE  Security deaktivieren

$IEESC = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"

Set-ItemProperty -Path $IEESC -Name "IsInstalled" -Value 0
##--------------------------------------------------------

####  https://www.tachytelic.net/2018/11/disable-server-manager-from-starting-when-logging-in-to-windows-server-2016/

Write-Host "Disable Server Manager when logging in to Windows Server"
Get-ScheduledTask -TaskName ServerManager | Disable-ScheduledTask -Verbose

##--------------------------------------------------------


Write-Host "Setting Date and Time Settings"
####  TimeZone  -->  Berlin, Bern, Rome

##    verfügbare TimeZones
##    Get-TimeZone -ListAvailable

##Id                         : W. Europe Standard Time
##DisplayName                : (UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna

Set-TimeZone -Id "W. Europe Standard Time"
##--------------------------------------------------------

####  Date & TimeFormat

$culture = Get-Culture

$culture.DateTimeFormat.FirstDayOfWeek   = "Monday"

$culture.DateTimeFormat.ShortDatePattern = "dd. MMM yyyy"
$culture.DateTimeFormat.LongDatePattern  = "d. MMMM yyyy"

$culture.DateTimeFormat.ShortTimePattern = "HH:mm"
$culture.DateTimeFormat.LongTimePattern  = "HH:mm:ss"

Set-Culture $culture

####  alternative
####Set-ItemProperty -Path "HKCU:\Control Panel\International" -name sShortDate -value "dd. MMM yyyy"
####Set-ItemProperty -Path "HKCU:\Control Panel\International" -name sLongDate  -value "dddd-MMMM-yyyy"


##--------------------------------------------------------


####  create Directory


$path = "C:\software\"
Write-Host "Setting Directory ""$path"" "

If(!(test-path -PathType container $path) )
{
    New-Item -ItemType Directory -Path $path
}
##----

$path = "C:\temp\"
Write-Host "Setting Directory ""$path"" "

If(!(test-path -PathType container $path) )
{
    New-Item -ItemType Directory -Path $path
}

##----

$path = "C:\Projects\"
Write-Host "Setting Directory ""$path"" "

If(!(test-path -PathType container $path) )
{
    New-Item -ItemType Directory -Path $path
}

##--------------------------------------------------------

####  download  google Chrome.msi

##$WebClient = New-Object System.Net.WebClient

$download  = "https://testfabrik.blob.core.windows.net/tradersdownload/GoogleChromeStandaloneEnterprise64.msi"
$to_folder = "C:\software\GoogleChromeStandaloneEnterprise64.msi" 
Start-BitsTransfer -Source $download -Destination $to_folder 

####  install   google Chrome.msi

Start-Process msiexec.exe -Wait -ArgumentList "/I C:\software\GoogleChromeStandaloneEnterprise64.msi /quiet "

##--------------------------------------------------------

####  download  notepad++

$download  = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7.5/npp.8.7.5.Installer.exe"
$to_folder = "C:\software\npp.8.7.5.Installer.exe" 
Invoke-WebRequest $download -OutFile $to_folder

####  install   notepad++

Start-Process $to_folder /S -NoNewWindow -Wait -PassThru
##--------------------------------------------------------

####  download  Lightshot 
####  https://app.prntscr.com/en/translate-lightshot.html

$download  = "https://app.prntscr.com/build/setup-lightshot.exe" 
$to_folder = "C:\software\setup-lightshot.exe"
Invoke-WebRequest $download -OutFile $to_folder

####  install   Lightshot

Start-Process $to_folder 

##--------------------------------------------------------

####  download  git-for-windows

$download  = "https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/Git-2.45.1-64-bit.exe"
$to_folder = "C:\software\Git-2.45.1-64-bit.exe" 
Invoke-WebRequest $download -OutFile $to_folder

####  install   git-for-windows

## Start-Process $to_folder /S -NoNewWindow -Wait -PassThru

##--------------------------------------------------------


####  show File Extensions

Set-Itemproperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0

####  end
####  *******************************************************************************************************
