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
