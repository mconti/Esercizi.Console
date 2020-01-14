$numeroAlunni=0
$numeroFile=0
$numeroFileFuoriTempo=0

# colori
$OK_Color = "Green"
$Wrong_Color = "Red"
$Warning_Color = "Yellow"

$Test_Color = "White"
$TooBig_Color = "Magenta"
$TooLateAccepted_Color = "Yellow"
$TooLateNotAccepted_Color = "Gray"
$DoubleDelivery_Color = "Cyan"

$ESTENSIONE="zip"
$GIORNI_VALIDITA_PRECEDENTI = 38
$ORE_VALIDITA_PRECEDENTI = 1
$RITIRO=$true            # Abilita la copia dei file
$RITIRO_RITARDI=$false   # Abilita il ritiro anche se in ritardo
$TAB="`t"                # Aiuta a formattare meglio l'output
$verboseParam = "--verbosity q"

# Richiede PWSH
#Requires -PSEdition Core

Start-Transcript -Path ($ScriptDirectory + "\Log\Log.txt")

if ( $PSVersionTable.Platform -eq "Unix" )
{
    # path macbook
    Write-Host "Sono su mac"
    $ROOT="/Volumes/GoogleDrive/Il mio Drive/Classroom"
    $ROOT_ESERCIZI="/Volumes/GoogleDrive/Il mio Drive/ITTS/2019-20"
    $ROOT_DESTINAZIONE="/Users/maurizio/Desktop"
}
else 
{
    Write-Host "Sono su windows"
    # path windows10 casa mia
    $ROOT="G:\Il mio Drive\Classroom"
    $ROOT_ESERCIZI="G:\Il mio Drive\ITTS\2019-20"
    $ROOT_DESTINAZIONE="C:\Users\conti.maurizio\Desktop"
}
