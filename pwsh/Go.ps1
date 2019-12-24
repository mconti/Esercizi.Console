#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#

#
# Nota: Il disco locale GDrive e' sincronizzato con Drive File Stream di Google
#

# path macbook
#$ROOT="/Volumes/GoogleDrive/Il mio Drive/Classroom"
#$ROOT_DESTINAZIONE="/Users/maurizio/Desktop/"

# path windows10 casa mia
$ROOT="D:\Il mio Drive\Classroom"
$ROOT_DESTINAZIONE="C:\Users\posta\Desktop\"

# include
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. ($ScriptDirectory + "\lib\tools.ps1")

#Ritira-Compito 4H Informatica Grani
Ritira-Compito 4H Informatica Serie
