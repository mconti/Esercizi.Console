#
# Ritiro Compiti - posta@maurizioconti.com
# Versione  2 Dicembre 2019

#$PROGETTO="Grani"
#$PROGETTO="Nanp"
#$PROGETTO="Acronimo"
#$PROGETTO="Alfabeto"
#$PROGETTO="Scramble"
#$PROGETTO="Media"
#$PROGETTO="CambioCodice"
#$PROGETTO="Somma"
#$PROGETTO="Eta"
#$PROGETTO="Serie"
$PROGETTO="ScrambleDictionary"

$CLASSE="4H"

$ESTENSIONE="zip"
$MATERIA="Informatica"
$ALUNNI = @( 
"Alessandri.Giacomo", "Alessi.Lorenzo", "Bianchi.Denise", "Busi.Alessandro", "Cavalli.Sarah", 
"Cecchetti.Mattia", "Cesarini.Filippo", "Dhamo.Aleksander", "Giorgetti.Alessio", "Goci.Erdi" 
"Lombardi.Giacomo", "Marazzi.Kevin", "Mingrone.Lorenzo", "Mitrotti.Francesco", "Montanari.Giorgia", "Nasini.Michele", 
"Pasquinelli.Martina", "Placucci.Gabriele", "Semproli.Mattia", "Shepilov.Nikita", "Tombini.Jacopo", "Zaghini.Mattia", "Zavatta.Lorenzo"
)


# Data del compito 
# Usato per dare il nome alla cartella. 
# Va impostato alla data che verrà usata nel registro
$STR_DATA_COMPITO=(Get-Date).DateTime
$GIORNI_VALIDITA_PRECEDENTI = 50
$ORE_VALIDITA_PRECEDENTI = 1

# Data del compito in formato directory di Archiviazione per CercoPiteko
#$DATA=(Get-Date $STR_DATA_COMPITO -format dd)+(Get-Date $STR_DATA_COMPITO -format MM)+(Get-Date $STR_DATA_COMPITO -format yy)+(Get-Date $STR_DATA_COMPITO -format HH)
$DATA=(Get-Date $STR_DATA_COMPITO -format yy)+(Get-Date $STR_DATA_COMPITO -format MM)+(Get-Date $STR_DATA_COMPITO -format dd)+(Get-Date $STR_DATA_COMPITO -format HH)

# $VALIDITA_DAL=(Get-Date "10/5/2016 8:00:00")
# $VALIDITA_AL=(Get-Date "10/05/2016 12:00:00")
$VALIDITA_DAL=(Get-Date $STR_DATA_COMPITO).AddDays(-$GIORNI_VALIDITA_PRECEDENTI).AddHours(-$ORE_VALIDITA_PRECEDENTI)
$VALIDITA_AL=(Get-Date $STR_DATA_COMPITO).AddDays(1)

# Per vedere chi ha consegnato senza effettuare copie
$RITIRO=$true

# Normalmente non si consegna in ritardo
$RITIRO_RITARDI=$false

# Directory predefinite
$TAB="`t"

# RDP
$REMOTE_ROOT="/Volumes/GoogleDrive/Il mio Drive/Classroom/INFO 4H 2019_2020 4H"
$REMOTE_ROOT_DEST="/Users/maurizio/Desktop/"

# Casa
#$REMOTE_ROOT=$env:USERPROFILE + "\Google Drive (maurizio.conti@ittsrimini.gov.it)\Classroom\INFO 4H 2019_2020 4H"
#$REMOTE_ROOT_DEST=$env:USERPROFILE + "\Google Drive (maurizio.conti@ittsrimini.gov.it)\ITTS\2019-20\Consegne"


# Fisso
#$REMOTE_ROOT=$env:USERPROFILE + "\ITTS Drive\ITTS\2016-17\Consegne"

$PRJ_DEST_DIR = $REMOTE_ROOT_DEST + "\CONSEGNATI\" + $CLASSE + "\" + $MATERIA + "\" + $PROGETTO + "\" + $DATA + "\"
$PRJ_DEST_DIR_RITARDO = $REMOTE_ROOT_DEST + "\CONSEGNATI\" + $CLASSE + "\" + $MATERIA + "\" + $PROGETTO + "\" + $DATA + "R\"

$numeroAlunni=0
$numeroFile=0
$numeroFileFuoriTempo=0

$OK_Color = "Green"
$Test_Color = "White"
$TooBig_Color = "Magenta"
$TooLateAccepted_Color = "Yellow"
$TooLateNotAccepted_Color = "Gray"
$Wrong_Color = "Red"
$DoubleDelivery_Color = "Cyan"

Write-host ""
Write-Host "Compito:" $PROGETTO"."$ESTENSIONE
Write-host "Sorgente:" $REMOTE_ROOT\$PROGETTO
Write-host "Destinazione:" $PRJ_DEST_DIR
Write-host "Valido dal:" $VALIDITA_DAL " al: " $VALIDITA_AL
Write-host ""
Write-host "Legenda:"
Write-host "- - - - - - - - - - - - - - - - - -"
Write-host "Presente" -foreground $OK_Color
Write-host "Non Presente" -foreground $Wrong_Color
Write-host "Ritardo (non ritirato)" -foreground $TooLateNotAccepted_Color
Write-host "Ritardo (accettato ugualmente)" -foreground $TooLateAccepted_Color
Write-host "Troppo grande!" -Background $TooBig_Color
Write-host "Nomi (1) presenti" -BackgroundColor $DoubleDelivery_Color
Write-host "- - - - - - - - - - - - - - - - - -"

# Cancella la vecchia directory 
if ((Test-Path $PRJ_DEST_DIR) -eq $true) {
    Remove-Item -LiteralPath $PRJ_DEST_DIR -Force -Recurse
}

# Punta al file di ogni alunno e lo copia nella destinazione
foreach( $alunno in $ALUNNI )
{
    $numeroAlunni++
    #$SOURCE_FILE = $CLASSE + "\" + $alunno + "\" + $alunno + "." + $CLASSE + "." + $PROGETTO + "." + $ESTENSIONE
    $SOURCE_FILE = $alunno + "." + $CLASSE + "." + $PROGETTO + "." + $ESTENSIONE
    $SOURCE = $REMOTE_ROOT + "\" + $PROGETTO + "\" + $SOURCE_FILE

    # Se il file sorgente è stato duplicato ... ( ha (1) nel nome del file )
    #$SOURCE_FILE_01 = $CLASSE + "\" + $alunno + "\" + $alunno + "." + $CLASSE + "." + $PROGETTO + " (1)." + $ESTENSIONE
    #$SOURCE_01 = $REMOTE_ROOT + "\" + $SOURCE_FILE_01
    #if ((Test-Path $SOURCE_01) -eq $true) {
    #    Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE_01).BaseName, (Get-ChildItem $SOURCE_01).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $DoubleDelivery_Color
    #    continue
    #}

    # Se il file sorgente esiste...
    if ((Test-Path $SOURCE) -eq $true) {

        # Verifica validità della consegna
        if( ((Get-ChildItem $SOURCE).LastWriteTime -gt $VALIDITA_DAL) -and ((Get-ChildItem $SOURCE).LastWriteTime -lt $VALIDITA_AL) ) {
            if( ((Get-ChildItem $SOURCE).Length) -lt 5000000 ) {
                if( $RITIRO -eq $true ) {

                    # Crea la directory di destinazione pulita
                    New-Item -ItemType Directory -Path $PRJ_DEST_DIR\$alunno -Force | Out-Null
                    
                    #Dezippa il file nella destinazione
                    Expand-Archive -LiteralPath $SOURCE -DestinationPath $PRJ_DEST_DIR\$alunno -Force
                
                    # Cerca il .csproj
                    $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    
                    # Se nello zip non trovo il file -.csproj lo segnalo giallo
                    if( $sorgenteConPath -eq $null ){
                        Write-host ("{0}" -f (Get-ChildItem $sorgenteConPath)) -ForegroundColor $TooLateAccepted_Color
                    }
                    else {
                        # Copia i file nella giusta posizone  
                        $soloPath = (Split-Path $sorgenteConPath) + "\*.*"
                        $destinazione = $PRJ_DEST_DIR + "\" + $alunno
                        Move-Item -Path $soloPath -Destination $destinazione
                    
                        # Cancella la vecchia directory 
                        Remove-Item -LiteralPath (Split-Path $sorgenteConPath)  -Force -Recurse

                        Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $OK_Color
                        
                        # Cerca la sln
                        $fileSln = Get-ChildItem -Path $PRJ_DEST_DIR -Filter ("*.sln") -ErrorAction SilentlyContinue -Force
                        $attuale = Get-Location 
                        Set-Location -Path $PRJ_DEST_DIR
                        if( $fileSln -eq $null ){
                            dotnet new sln -n $PROGETTO 
                            #Write-host ("{0}" -f $PRJ_DEST_DIR ) -ForegroundColor $OK_Color
                        }
                        $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                        Rename-Item -Path $sorgenteConPath -NewName ($alunno + ".csproj")
                        $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                        #Write-host ("{0}" -f $sorgenteConPath ) -ForegroundColor $OK_Color
                        dotnet sln ($PROGETTO + ".sln") add $sorgenteConPath
                        
                        Set-Location -Path $attuale
                    }
                    
                    #Write-host ("{0}" -f $soloPath) -ForegroundColor $TooLateNotAccepted_Color
                    #Write-host ("{0}" -f $destinazione ) -ForegroundColor $OK_Color

                   # Write-host ("{0}" -f $sorgenteConPath) -ForegroundColor $OK_Color
                }
                else{
                    Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $Test_Color
                }
            }
            else{
                Write-host ( "{0}{1}$TAB({2})$TAB({3})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime, (Get-ChildItem $SOURCE).Length) -BackgroundColor $TooBig_Color
            }

            $numeroFile++
        }
        else {
            if( $RITIRO_RITARDI -eq $true ){ 
        
                # Crea la directory di destinazione "fuori tempo" 
                if ((Test-Path $PRJ_DEST_DIR_RITARDO/$alunno) -eq $false)  {
                    New-Item -ItemType Directory -Path $PRJ_DEST_DIR_RITARDO/$alunno -Force | Out-Null
                } 
            
                # Copia il file fuori tempo
                #Copy-Item -Path $SOURCE -Destination $PRJ_DEST_DIR_RITARDO\$alunno
                Unzip $SOURCE $PRJ_DEST_DIR_RITARDO/$alunno
                $numeroFileFuoriTempo++

                Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $TooLateAccepted_Color
            }
            else {
                Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $TooLateNotAccepted_Color
                $numeroFileFuoriTempo++
            }
        }
    } 
    else {
        # Altrimenti lo segnala in rosso
        write-host ("{0}" -f $SOURCE_FILE) -foreground $Wrong_Color
    }
}


Write-host ""
Write-Host "Compito:" $PROGETTO"."$ESTENSIONE
Write-host "Previsti: "$numeroAlunni
Write-Host "Consegnati:" $numeroFile
Write-Host "Ritardo:" $numeroFileFuoriTempo
Write-Host "Mancanti:" ($numeroAlunni-$numeroFile-$numeroFileFuoriTempo)
Write-host "- - - - - - - - - - - - - - - - - -"
