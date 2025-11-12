
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

Write-Host 
Write-Host "installed .NET version: "

$release = Get-ItemPropertyValue -LiteralPath 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Release
switch ($release) {
    { $_ -ge 533320 } { $version = '4.8.1 or later' ; break }
    { $_ -ge 528040 } { $version = '4.8'   ; break }
    { $_ -ge 461808 } { $version = '4.7.2' ; break }
    { $_ -ge 461308 } { $version = '4.7.1' ; break }
    { $_ -ge 460798 } { $version = '4.7'   ; break }
    { $_ -ge 394802 } { $version = '4.6.2' ; break }
    { $_ -ge 394254 } { $version = '4.6.1' ; break }
    { $_ -ge 393295 } { $version = '4.6'   ; break }
    { $_ -ge 379893 } { $version = '4.5.2' ; break }
    { $_ -ge 378675 } { $version = '4.5.1' ; break }
    { $_ -ge 378389 } { $version = '4.5'   ; break }
    default { $version = $null; break }
}

Write-Host
if ($version) {
    Write-Host -Object ".NET Framework Version: $version"
} else {
    Write-Host -Object '.NET Framework Version 4.5 or later is not detected.'
}
Write-Host

## https://learn.microsoft.com/en-us/dotnet/framework/install/how-to-determine-which-versions-are-installed

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


$path = "C:\software\winTools\"
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
$to_folder = "C:\software\winTools\GoogleChromeStandaloneEnterprise64.msi" 
Start-BitsTransfer -Source $download -Destination $to_folder 

####  install   google Chrome.msi
Start-Process msiexec.exe -Wait -ArgumentList "/I C:\software\winTools\GoogleChromeStandaloneEnterprise64.msi /quiet "

##--------------------------------------------------------

####  download  notepad++

$download  = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.8.7/npp.8.8.7.Installer.exe"
$to_folder = "C:\software\winTools\npp.8.8.7.Installer.exe" 
Invoke-WebRequest $download -OutFile $to_folder

####  install   notepad++
Start-Process $to_folder /S -NoNewWindow -Wait -PassThru
##--------------------------------------------------------

####  download  BGinfo.zip

$download  = "https://testfabrik.blob.core.windows.net/tradersdownload/BGInfo.zip" 
$to_folder = "C:\software\winTools\BGInfo.zip"
Invoke-WebRequest $download -OutFile $to_folder

####  apply
Expand-Archive -LiteralPath "C:\software\winTools\BGInfo.zip" -DestinationPath "C:\software\winTools" -Force
cmd.exe /c " C:\software\winTools\BGinfo\Bginfo64.exe  C:\software\winTools\BGinfo\config_BGinfo.bgi  /timer:0  /accepteula " 

##--------------------------------------------------------

####  download  dotnet-sdk-7.0.410-win-x64.exe 

$download  = "https://testfabrik.blob.core.windows.net/tradersdownload/dotnet-sdk-7.0.410-win-x64.exe" 
$to_folder = "C:\software\dotnet-sdk-7.0.410-win-x64.exe"
Invoke-WebRequest $download -OutFile $to_folder

####  install   dotnet-sdk-7.0.410-win-x64.exe 

##--------------------------------------------------------

####  download  Lightshot 
####  https://app.prntscr.com/en/translate-lightshot.html

$download  = "https://app.prntscr.com/build/setup-lightshot.exe" 
$to_folder = "C:\software\winTools\setup-lightshot.exe"
Invoke-WebRequest $download -OutFile $to_folder

####  install   Lightshot
##--  Start-Process $to_folder 

##--------------------------------------------------------

####  download  git-for-windows

$download  = "https://github.com/git-for-windows/git/releases/download/v2.51.0.windows.1/Git-2.51.0-64-bit.exe"
$to_folder = "C:\software\winTools\Git-2.51.0-64-bit.exe" 
Invoke-WebRequest $download -OutFile $to_folder

####  install   git-for-windows
##--  Start-Process $to_folder /S -NoNewWindow -Wait -PassThru

##--------------------------------------------------------


####  show File Extensions

Set-Itemproperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0

####  end
####  *******************************************************************************************************

