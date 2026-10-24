##  Pfad zur Datei definieren (bitte anpassen)
$dateiPfad = "C:\temp\cde_DemandIndex.pdf"

##  Gewünschtes neues Datum und Uhrzeit festlegen
$neuesDatum = Get-Date "2026-10-24 17:00:00"

##  Prüfen, ob die Datei existiert
if (Test-Path $dateiPfad) {
    # Datei-Objekt abrufen
    $datei = Get-Item $dateiPfad

    ##  Zeitstempel neu setzen
    $datei.CreationTime   = $neuesDatum  # Erstellungszeit
    $datei.LastWriteTime  = $neuesDatum  # Letzte Änderung
    $datei.LastAccessTime = $neuesDatum  # Letzter Zugriff

    ##  Bestätigung ausgeben
    Write-Host "Die Zeitstempel für '$($datei.Name)' wurden erfolgreich geändert." -ForegroundColor Green
    
    ##  Kontrolle: Neue Werte anzeigen
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
