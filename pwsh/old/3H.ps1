#
# Ritiro Compiti - posta@maurizioconti.com
# Versione  1.4 Ottobre 2019
# Cerca i file con (1) nel nome (consegna doppia per GDrive)!!!
# Colora in modo migliore i file e presenta una legenda dei colori
# Consente di impostare una dimensione max per i file
# Controlla anche l'ora, minuti, secondi di consegna

# Dati Essenziali
# Nota: il nome non contiene la DATA e la MATERIA perchè vengono gestite con nomi di cartelle assegnati automaticamente
# Tipico nome di progetto conti.maurizio.5H.Automobile

#$PROGETTO="Paga"
#$PROGETTO="Poligoni"
#$PROGETTO="Irpef"
#$PROGETTO="Giorno"
#$PROGETTO="Romani"
#$PROGETTO="Limiti"
#$PROGETTO="MediaPesata"

#$PROGETTO="Stream"

#$PROGETTO="Collatz"
#$FILE_SORGENTE="Collatz"

#$PROGETTO="NumeroStream"
#$FILE_SORGENTE="stream"

#$PROGETTO="MediaStream"
#$FILE_SORGENTE="mediaPesata"

#$PROGETTO="Fibonacci"
#$FILE_SORGENTE="Fibonacci"

$CLASSE="3H"

$ESTENSIONE="zip"
$MATERIA="Informatica"
#$ALUNNI = @z( 
#"Agyiri.Godfred", "Amadori.Alan", "Amantini.Davide")

$ALUNNI = @( 
"Agyiri.Godfred", "Amadori.Alan", "Amantini.Davide", "Amantini.Federico", "Bahri.Yassine", "Bartolini.Liam", "Battafarano.Giovanni",
"Bertozzi.Mattia", "Bianchi.Monica", "Bronzetti.Christian", "Caralli.Fabio", "Carnevali.Nicola", 
"Casadei.Samuele", "Curzi.Lorenzo", "Farneti.Michele", "Lu.William", "Mancini.Nicola", "Mari.Diego", "Mazzoni.Alex", 
"Menghi.Massimo", "Paz.Eyal", "Qordja.Francesco.Petrit", 
"Santarsieri.Andrea", "Santi.Federico", "Spaccamiglio.Luca")


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
$RITIRO_RITARDI=$true

# Directory predefinite
$TAB="`t"

# RDP
$ROOT_SORGENTE= "/Volumes/GoogleDrive/Il mio Drive/Classroom/3H-201920"
$ROOT_DESTINAZIONE= "/Users/maurizio/Desktop/"

# Casa
#$ROOT_SORGENTE=$env:USERPROFILE + "\Google Drive (maurizio.conti@ittsrimini.gov.it)\Classroom\3H-201920"
#$ROOT_DESTINAZIONE=$env:USERPROFILE + "\Google Drive (maurizio.conti@ittsrimini.gov.it)\ITTS\2019-20\Consegne"

# Fisso
#$ROOT_SORGENTE=$env:USERPROFILE + "\ITTS Drive\ITTS\2016-17\Consegne"

$PRJ_DEST_DIR = $ROOT_DESTINAZIONE + "\CONSEGNATI\" + $CLASSE + "\" + $MATERIA + "\" + $PROGETTO + "\" + $DATA + "\"
$PRJ_DEST_DIR_RITARDO = $ROOT_DESTINAZIONE + "\CONSEGNATI\" + $CLASSE + "\" + $MATERIA + "\" + $PROGETTO + "\" + $DATA + "R\"

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
Write-host "Sorgente:" $ROOT_SORGENTE\$PROGETTO
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

# Punta al file di ogni alunno e lo copia nella destinazione
foreach( $alunno in $ALUNNI )
{
    $numeroAlunni++
    #$SOURCE_FILE = $CLASSE + "\" + $alunno + "\" + $alunno + "." + $CLASSE + "." + $PROGETTO + "." + $ESTENSIONE
    $SOURCE_FILE = $alunno + "." + $CLASSE + "." + $PROGETTO + "." + $ESTENSIONE
    $SOURCE = $ROOT_SORGENTE + "\" + $PROGETTO + "\" + $SOURCE_FILE

    # Se il file sorgente è stato duplicato ... ( ha (1) nel nome del file )
    #$SOURCE_FILE_01 = $CLASSE + "\" + $alunno + "\" + $alunno + "." + $CLASSE + "." + $PROGETTO + " (1)." + $ESTENSIONE
    #$SOURCE_01 = $ROOT_SORGENTE + "\" + $SOURCE_FILE_01
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

                    # Cancella la vecchia directory 
                    if ((Test-Path $PRJ_DEST_DIR\$alunno) -eq $true) {
                        Remove-Item -LiteralPath $PRJ_DEST_DIR\$alunno -Force -Recurse
                    }

                    # Crea la directory di destinazione pulita
                    New-Item -ItemType Directory -Path $PRJ_DEST_DIR\$alunno -Force | Out-Null
                    
                    #Dezippa il file nella destinazione
                    Expand-Archive -LiteralPath $SOURCE -DestinationPath $PRJ_DEST_DIR\$alunno -Force
                    
                    # Copia i file nella giusta posizone  
                    #$sorgente = $FILE_SORGENTE + ".cs"
                    $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ($FILE_SORGENTE + ".cs") -Recurse -ErrorAction SilentlyContinue -Force
                    $soloPath = (Split-Path $sorgenteConPath) + "\*.*"
                    $destinazione = $PRJ_DEST_DIR + "\" + $alunno
                    Move-Item -Path $soloPath -Destination $destinazione
                    
                    # Cancella la vecchia directory 
                    Remove-Item -LiteralPath (Split-Path $sorgenteConPath)  -Force -Recurse

                    # Crea la directory pulita
                    # if ((Test-Path $PRJ_DEST_DIR\$alunno) -eq $false) {
                    #     New-Item -ItemType Directory -Path $PRJ_DEST_DIR\$alunno -Force | Out-Null
                    # } 

                    # Ci copia dentro il sorgente .cs  
                    # $destinazione = $PRJ_DEST_DIR + "\" + $alunno
                    # $sorgenteConPath = $PRJ_DEST_DIR + "\" + $alunno + "." + $FILE_SORGENTE + ".cs"
                    # Move-Item -Path $sorgenteConPath -Destination $destinazione
                    
                    #Write-host ("{0}" -f $soloPath) -ForegroundColor $TooLateNotAccepted_Color
                    #Write-host ("{0}" -f $destinazione ) -ForegroundColor $OK_Color

                    # Aggiornare il file sln con il progetto
                    # dotnet sln add progetto...
                    # $PRJ_DEST_DIR va bene come destinazione per la sln

                   # Write-host ("{0}" -f $sorgenteConPath) -ForegroundColor $OK_Color
                    Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $OK_Color
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
