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
$numeroAlunni=0
$numeroFile=0
$numeroFileFuoriTempo=0

# colori
$OK_Color = "Green"
$Test_Color = "White"
$TooBig_Color = "Magenta"
$TooLateAccepted_Color = "Yellow"
$TooLateNotAccepted_Color = "Gray"
$Wrong_Color = "Red"
$DoubleDelivery_Color = "Cyan"

$ESTENSIONE="zip"
$GIORNI_VALIDITA_PRECEDENTI = 38
$ORE_VALIDITA_PRECEDENTI = 1
$RITIRO=$true            # Abilita la copia dei file
$RITIRO_RITARDI=$false   # Abilita il ritiro anche se in ritardo
$TAB="`t"                # Aiuta a formattare meglio l'output
$verboseParam = "--verbosity q"


# La path dove sta girando il nostro script
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
#$ScriptDirectory = (Get-Location.Path)
#. ($ScriptDirectory + "\settings\" + "global.ps1")

# Impone che stia girando PWSH 
#Requires -PSEdition Core

Start-Transcript -Path ($ScriptDirectory + "\Log\Log.txt")

if ( $PSVersionTable.Platform -eq "Unix" )
{
    # path macbook
    Write-Host "Sono su mac"
    $ROOT="/Volumes/GoogleDrive/Il mio Drive/Classroom"
    $ROOT_DESTINAZIONE="/Users/maurizio/Desktop"
}
else 
{
    Write-Host "Sono su windows"
    # path windows10 casa mia
    $ROOT="D:\Il mio Drive\Classroom"
    $ROOT_DESTINAZIONE="C:\Users\posta\Desktop"
}

. ($ScriptDirectory + "\lib\tools.ps1")
. ($ScriptDirectory + "\lib\" + "Write-PSObject.ps1")

#Ritira-Compito 4H Informatica "Grani"
#Ritira-Compito 4H Informatica "Nanp"
#Ritira-Compito 4H Informatica "Acronimo"
#Ritira-Compito 4H Informatica "Alfabeto"
#Ritira-Compito 4H Informatica "Scramble"
Ritira-Compito 4H Informatica "ScrambleDictionary"
#Ritira-Compito 4H Informatica "CambioCodice"
#Ritira-Compito 4H Informatica "Media"
#Ritira-Compito 4H Informatica "Somma"
#Ritira-Compito 4H Informatica "Eta"
#Ritira-Compito 4H Informatica "Serie"

$attuale = Get-Location 
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$workDir = $DesktopPath + "\Consegnati\4H\Informatica"
Set-Location -Path $workDir
Get-ChildItem -Filter *KO.csv -Recurse | Select-Object -ExpandProperty FullName | Import-Csv | Export-Csv .\4H-Informatica-KO.csv -NoTypeInformation -Append
Get-ChildItem -Filter *OK.csv -Recurse | Select-Object -ExpandProperty FullName | Import-Csv | Export-Csv .\4H-Informatica-OK.csv -NoTypeInformation -Append

# Chiude le danze
Set-Location -Path $attuale
Stop-Transcript

