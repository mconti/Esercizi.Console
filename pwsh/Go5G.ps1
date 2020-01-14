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

#
# Usabili
#

# PesoLettere
# Era uno dei primi test e molti alunni hanno cambiato i test
#Ritira-Compito 5G Informatica "PesoLettere" "force"

# NANP
# Coci e Mascella sono uguali
# Molti file cambiati
#Ritira-Compito 5G Informatica "NANP" "force"

# Non usabile
# CercaLettere
# L'hanno consegnato in WPF per un errore mio
#Ritira-Compito 5G Informatica "CercaLettere"

# CercaLettere2
# Ho dato modo di riconsegnare durante le feste CercaLettere in una nuova cartella
# Solo Koci e Yang l'hanno consegnato
#Ritira-Compito 5G Informatica "CercaLettere2" "force"

# Datapump
# E' un compito WPF, non può essere testato.
Ritira-Compito 5G Informatica "DataPump"


# Ancora da dare
#Ritira-Compito 5G Informatica "Fattori"

Esporta-CSV 5G Informatica

# Chiude le danze
Stop-Transcript
