
Write-Host ".. start Configuration"
##--------------------------------------------------------

Write-Host "show Windows-Version"
(Get-WmiObject -class Win32_OperatingSystem).Caption

[environment]::OSVersion.VersionString
##[environment]::OSVersion.Version

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

##--------------------------------------------------------
