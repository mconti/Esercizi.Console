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

# Usabili
#Ritira-Compito 3H Informatica "Collatz" "force"
#Ritira-Compito 3H Informatica "NumeroStream" "force"
#Ritira-Compito 3H Informatica "MediaStream" "force"
Ritira-Compito 3H Informatica "Punteggio" "force"

# Fibonacci e Euclide 
#non sono stati fatti con il sistema dei test

# Spazio 
# Ha problemi con hash del file dei test
# I ragazzi hanno passato un argomento perchè non usavano il costruttore dato
#Ritira-Compito 3H Informatica "Spazio" "force"

# Numeri 
# I ragazzi hanno consegnato solo un file non la cartella.
# E comunque era un esercizio molto semplice, non vale la pena.


Esporta-CSV 3H Informatica

# Chiude le danze
Stop-Transcript

