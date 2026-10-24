##  Pfad zur Datei definieren (bitte anpassen)
$dateiPfad = "C:\temp\cde_DemandIndex.cs"

##  Prüfen, ob die Datei existiert
if (Test-Path $dateiPfad) {
    ##  Datei-Objekt abrufen
    $datei = Get-Item $dateiPfad

    ##  Zeitstempel auslesen
    [PSCustomObject]@{
        "Datei-Name"      = $datei.Name
        "Erstellungszeit" = $datei.CreationTime
        "Letzter Zugriff" = $datei.LastAccessTime
        "Letzte Änderung" = $datei.LastWriteTime
    } | Format-List
} else {
    Write-Host "Die angegebene Datei wurde nicht gefunden." -ForegroundColor Red
}
## ----
