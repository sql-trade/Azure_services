# Skript zur Auflistung installierter Software
$installedSoftware = Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version, Vendor
$installedSoftware | Sort-Object Name | Format-Table -AutoSize
