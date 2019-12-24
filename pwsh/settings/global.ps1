#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#
# define and global functions
#


# colori
$OK_Color = "Green"
$Test_Color = "White"
$TooBig_Color = "Magenta"
$TooLateAccepted_Color = "Yellow"
$TooLateNotAccepted_Color = "Gray"
$Wrong_Color = "Red"
$DoubleDelivery_Color = "Cyan"

$ESTENSIONE="zip"
$GIORNI_VALIDITA_PRECEDENTI = 50
$ORE_VALIDITA_PRECEDENTI = 1
$RITIRO=$true            # Abilita la copia dei file
$RITIRO_RITARDI=$false   # Abilita il ritiro anche se in ritardo
$TAB="`t"                # Aiuta a formattare meglio l'output

# Data del compito 
# Usato per dare il nome alla cartella. 
# Va impostato alla data che verrà usata nel registro
$STR_DATA_COMPITO=(Get-Date).DateTime

# Data del compito in formato directory di Archiviazione per CercoPiteko
#$DATA=(Get-Date $STR_DATA_COMPITO -format dd)+(Get-Date $STR_DATA_COMPITO -format MM)+(Get-Date $STR_DATA_COMPITO -format yy)+(Get-Date $STR_DATA_COMPITO -format HH)
$DATA=(Get-Date $STR_DATA_COMPITO -format yy)+(Get-Date $STR_DATA_COMPITO -format MM)+(Get-Date $STR_DATA_COMPITO -format dd)+(Get-Date $STR_DATA_COMPITO -format HH)

# $VALIDITA_DAL=(Get-Date "10/5/2016 8:00:00")
# $VALIDITA_AL=(Get-Date "10/05/2016 12:00:00")
$VALIDITA_DAL=(Get-Date $STR_DATA_COMPITO).AddDays(-$GIORNI_VALIDITA_PRECEDENTI).AddHours(-$ORE_VALIDITA_PRECEDENTI)
$VALIDITA_AL=(Get-Date $STR_DATA_COMPITO).AddDays(1)

$ROOT_SORGENTE=($ROOT + "/" + $LOCAL)

$PRJ_DEST_DIR = $ROOT_DESTINAZIONE + "\CONSEGNATI\" + $CLASSE + "\" + $MATERIA + "\" + $PROGETTO + "\" + $DATA + "\"
$PRJ_DEST_DIR_RITARDO = $ROOT_DESTINAZIONE + "\CONSEGNATI\" + $CLASSE + "\" + $MATERIA + "\" + $PROGETTO + "\" + $DATA + "R\"
