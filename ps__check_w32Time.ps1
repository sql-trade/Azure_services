##--------------------------------------------------------------
Write-Host
Write-Host "check w32Time ..."
Write-Host

w32tm /stripchart /computer:us.pool.ntp.org /dataonly /samples:5
Write-Host

w32tm /stripchart /computer:de.pool.ntp.org /dataonly /samples:5
Write-Host

w32tm /stripchart /computer:ptbtime1.ptb.de /dataonly /samples:5
Write-Host

Write-Host "----  finished  ----"
