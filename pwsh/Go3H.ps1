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

#Ritira-Compito 3H Informatica "Collatz"
#Ritira-Compito 3H Informatica "Fibonacci"
#Ritira-Compito 3H Informatica "MediaStream"
#Ritira-Compito 3H Informatica "NumeroStream"
#Ritira-Compito 3H Informatica "Spazio"

Esporta-CSV 3H Informatica

# Chiude le danze
Stop-Transcript

