#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#
# Questi file non sono semplici documenti ma programmi eseguibili.
#
# Solo per uso didattico, ricerca e studio.
# Versione alfa, non verificata, 
# Non testata su PC differenti da quelli dell'autore.
#
# Attenzione!!!
# Non usare su PC o server di produzione.
# Non usare su PC di cui non si è in grado il ripristino.
#
# L'uso di queste precedure potrebbe portare a perdita di dati
# sul proprio PC o su cartelle remote GDrive
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

# Con molti errori
#Ritira-Compito 4H Informatica "Grani"
#Ritira-Compito 4H Informatica "Acronimo"

# Non so dove sia lo zip originale
#Ritira-Compito 4H Informatica "ScrambleDictionary"

# Usabili
#Ritira-Compito 4H Informatica "Nanp" "force"
#Ritira-Compito 4H Informatica "Alfabeto" "force"
#Ritira-Compito 4H Informatica "Scramble" "force"
#Ritira-Compito 4H Informatica "CambioCodice" "force"
#Ritira-Compito 4H Informatica "Media" "force"
#Ritira-Compito 4H Informatica "Somma" "force"
#Ritira-Compito 4H Informatica "Eta" "force"
#Ritira-Compito 4H Informatica "Serie" "force"
#Ritira-Compito 4H Informatica "SerieProdotto" "force"
#Ritira-Compito 4H Informatica "Armstrong" "force"
Ritira-Compito 4H Informatica "Docente" "force"
Ritira-Compito 4H Informatica "Docente2" "force"

Esporta-CSV 4H Informatica

# Chiude le danze
Stop-Transcript

