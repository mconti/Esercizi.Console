#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#

#
# Nota: Il disco locale GDrive e' sincronizzato con 
# la app "Drive File Stream" di Google
#

#
# main
#

# La path dove sta girando il nostro script
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
#$ScriptDirectory = (Get-Location.Path)

# Include
. ($ScriptDirectory + "\settings\" + "global.ps1")
. ($ScriptDirectory + "\lib\tools.ps1")
. ($ScriptDirectory + "\lib\" + "Write-PSObject.ps1")

Ritira-Compito 3H Informatica "Collatz"
Ritira-Compito 3H Informatica "Fibonacci"
Ritira-Compito 3H Informatica "MediaStream"
Ritira-Compito 3H Informatica "NumeroStream"
Ritira-Compito 3H Informatica "Spazio"

$attuale = Get-Location 
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$workDir = $DesktopPath + "\Consegnati\3H\Informatica"
Set-Location -Path $workDir

Remove-Item .\3H-Informatica-ConErrori.csv
Remove-Item .\3H-Informatica-SenzaErrori.csv

Get-ChildItem -Filter *KO.csv -Recurse | Select-Object -ExpandProperty FullName | Import-Csv  | Export-Csv .\3H-Informatica-ConErrori.csv -NoTypeInformation -Append 
Get-ChildItem -Filter *OK.csv -Recurse | Select-Object -ExpandProperty FullName | Import-Csv  | Export-Csv .\3H-Informatica-SenzaErrori.csv -NoTypeInformation -Append

$ConErrori = Import-Csv .\3H-Informatica-ConErrori.csv
$SenzaErrori = Import-Csv .\3H-Informatica-SenzaErrori.csv
($ConErrori + $SenzaErrori) | Sort-Object -Property Alunno | Export-Csv .\3H-Informatica-PerAlunno.csv -NoTypeInformation
($ConErrori + $SenzaErrori) | Sort-Object -Property Progetto, Alunno | Export-Csv .\3H-Informatica-PerProgetto.csv -NoTypeInformation
($ConErrori + $SenzaErrori) | Sort-Object -Property Progetto, Risultato, Alunno | Export-Csv .\3H-Informatica-PerProgettoRisultato.csv -NoTypeInformation

# Chiude le danze
Set-Location -Path $attuale
Stop-Transcript

