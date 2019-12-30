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

Ritira-Compito 4H Informatica "Grani"
Ritira-Compito 4H Informatica "Nanp"
Ritira-Compito 4H Informatica "Acronimo"
Ritira-Compito 4H Informatica "Alfabeto"
Ritira-Compito 4H Informatica "Scramble"
Ritira-Compito 4H Informatica "ScrambleDictionary"
Ritira-Compito 4H Informatica "CambioCodice"
Ritira-Compito 4H Informatica "Media"
Ritira-Compito 4H Informatica "Somma"
Ritira-Compito 4H Informatica "Eta"
Ritira-Compito 4H Informatica "Serie"

Esporta-CSV 4H Informatica

# Chiude le danze
Stop-Transcript

