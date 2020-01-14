#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#
# general purpose funcions and utility
#
function Ritira-Compito {

    [CmdletBinding()]
    [OutputType("Void")]
    param( [string]$NOME_CLASSE, [string]$MATERIA, [string]$NPROGETTO, [String] $LANCIA_TEST )

    # Inizializza $CLASSE
    $INCLUDE_FILE_NAME = "$ScriptDirectory/settings/$NOME_CLASSE-$MATERIA.ps1"
    $INCLUDE_FILE_NAME

    if ((Test-Path $INCLUDE_FILE_NAME) -eq $true) {
        . ($ScriptDirectory + "/settings/" + $NOME_CLASSE + "-" + $MATERIA + ".ps1")        
    }
    else{
        Write-Host "Stai prelevando i compiti di $MATERIA della classe $NOME_CLASSE" 
        Write-Host "File $INCLUDE_FILE_NAME non trovato." -foreground $Wrong_Color
        Exit
    }
    
    # Verifica le path necessarie
    if ((Test-Path $ROOT) -eq $true) {
        Write-Host "Trovata la cartella sorgente $ROOT" -foreground $OK_Color
        $ROOT_SORGENTE = ($ROOT + "/" + $CLASSE.LOCAL)

        if ((Test-Path $ROOT_SORGENTE) -eq $true) {
            Write-Host "Trovata la cartella della classe "$CLASSE.LOCAL -foreground $OK_Color
    
            $DesktopPath = [Environment]::GetFolderPath("Desktop")
            Write-Host "Trovata la cartella di destinazione $DesktopPath" -foreground $OK_Color

            # Seleziona progetto
            $attivo = Get-Progetto $NPROGETTO $NOME_CLASSE
            $PROGETTO = $attivo.Nome

            # Sistema date di consegna e nomi delle cartelle legate alle date
            #$VALIDITA_DAL = (Get-Date ($attivo.Dal))
            $VALIDITA_AL = (Get-Date ($attivo.Al))
            $DATA = (Get-Date -format yy)+(Get-Date -format MM)+(Get-Date -format dd)+(Get-Date -format HH)
            
            # Preleva voto minimo e massimo
            $VOTO_MINIMO = $attivo.Minimo
            $VOTO_MASSIMO = $attivo.Massimo

            $ROOT_DEST_DIR = $DesktopPath + "/Consegnati/" + $CLASSE.NOME + "/" + $CLASSE.MATERIA
            $PROGETTO_DEST_DIR = "$ROOT_DEST_DIR/$PROGETTO"

            # Attenzione, ragionamento. 
            # Cancellando questa cartella,
            # si cancella solo la correzione di oggi.
            #
            # In alternativa, si potrebbe cancellare $ROOT_DEST_DIR, 
            # ma si cencellerebbero anche tutte le cartelle delle 
            # correzioni precedenti.
            #
            # Così invece rimane uno storico... serve? Boh?
            # 
            $PRJ_DEST_DIR = "$PROGETTO_DEST_DIR/$DATA"
            $PRJ_DEST_DIR_RITARDO = $PRJ_DEST_DIR + "R"

            $CSV_DEST_DIR = $PRJ_DEST_DIR + "/1-Csv"
            $CSV_DEST_DIR2 = $CLASSE.PATH_RISULTATI + "/" + $PROGETTO + "/" + $DATA
            
            $CSV_RIEPILOGO_DEST_DIR = $ROOT_DEST_DIR

            $PATH_ESERCIZIO_ORIGINALE = $CLASSE.PATH_ESERCIZI + "/$NPROGETTO.zip" 
            $PATH_DEST_ESERCIZIO_ORIGINALE = $PRJ_DEST_DIR + "/1-Orig" 

            # Controlla l'esistenza della cartella dei compiti originali
            if ((Test-Path $PATH_ESERCIZIO_ORIGINALE) -eq $true) {
                Write-Host "Trovato compito originale $NPROGETTO.zip." -foreground $OK_Color
            }
            else {
                Write-Host "File compito originale non trovato." -foreground $Wrong_Color                
                Write-Host $PATH_ESERCIZIO_ORIGINALE -foreground $Wrong_Color
                Write-Host "Controllo solo la consegna"
                $LANCIA_TEST = ""
            }
        }
        else {
            Write-Host "Cartella della classe "$CLASSE.LOCAL"non trovata." -foreground $Wrong_Color
            Write-host "Controllare il proprio classroom" -foreground $Wrong_Color
            Exit
        }
    }
    else {
        Write-Host "Cartella sorgente $ROOT non trovata" -foreground $Wrong_Color
        Write-host "E' necessario installare Google Drive File Stream sul tuo PC" -foreground $Wrong_Color
        Exit
    }
    
    # Messaggio iniziale
    Print-Header 
    
    # Cancella la vecchia directory 
    if ((Test-Path $PRJ_DEST_DIR) -eq $true) {
        Remove-Item -LiteralPath $PRJ_DEST_DIR -Force -Recurse
        Write-Host "Cancello " + $PRJ_DEST_DIR
    }

    # Memorizza la posizone della PATH attuale (alla fine la recupera)
    $attuale = Get-Location 
    
    # Risultati
    $Risultati = New-Object System.Collections.ArrayList
    $RisultatiKO = New-Object System.Collections.ArrayList

    # Cancella la directory delle vecchie correzioni 
    if ((Test-Path $PRJ_DEST_DIR) -eq $true) {
        Remove-Item -LiteralPath $PRJ_DEST_DIR -Force -Recurse
    }

    # ... e la ricrea
    New-Item -ItemType Directory -Path $PRJ_DEST_DIR -Force | Out-Null

    # Solo se da sopra ci chiedono di fate i test... altrimenti solo dezip.
    # Dezippa il file del compito originale
    if( $LANCIA_TEST -ne "" ) {
        Expand-Archive -LiteralPath $PATH_ESERCIZIO_ORIGINALE -DestinationPath $PATH_DEST_ESERCIZIO_ORIGINALE -Force

        # Cerca ed elimina cartelle del MAC che danno fastidio
        $sorgenteConPath = Get-ChildItem -Path $PATH_DEST_ESERCIZIO_ORIGINALE -Filter ("__MACOSX") -Recurse -ErrorAction SilentlyContinue -Force
        if( $sorgenteConPath -ne $null ){
            Remove-Item -LiteralPath ((Split-Path $sorgenteConPath) + "/__MACOSX") -Force -Recurse
        }

        # Calcola l'HASH del file dei test (per verificare che nessuno lo cambi)
        $tutti = Get-ChildItem -Path $PATH_DEST_ESERCIZIO_ORIGINALE -Filter ("*Test.cs") -Recurse -ErrorAction SilentlyContinue -Force
        $csTestFile = $tutti[0]
        $hashFileTestOriginale = (Get-FileHash $csTestFile -Algorithm MD5).Hash
    }

    #
    # main loop
    #    
    # Punta al file di ogni alunno e lo copia nella destinazione
    foreach( $alunno in $CLASSE.ALUNNI )
    {
        $numeroAlunni++
        #$SOURCE_FILE = $NOME_CLASSE + "\" + $alunno + "\" + $alunno + "." + $NOME_CLASSE + "." + $PROGETTO + "." + $ESTENSIONE
        $SOURCE_FILE = $alunno + "." + $CLASSE.NOME + "." + $PROGETTO + "." + $ESTENSIONE
        $SOURCE = $ROOT_SORGENTE + "/" + $PROGETTO + "/" + $SOURCE_FILE
        
        # Se il file sorgente è stato duplicato ... ( ha (1) nel nome del file )
        #$SOURCE_FILE_01 = $NOME_CLASSE + "\" + $alunno + "\" + $alunno + "." + $NOME_CLASSE + "." + $PROGETTO + " (1)." + $ESTENSIONE
        #$SOURCE_01 = $ROOT_SORGENTE + "\" + $SOURCE_FILE_01
        #if ((Test-Path $SOURCE_01) -eq $true) {
        #    Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE_01).BaseName, (Get-ChildItem $SOURCE_01).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $DoubleDelivery_Color
        #    continue
        #}

        # Verifica validità della consegna
        # Se il file sorgente esiste...
        if ((Test-Path $SOURCE) -eq $true) {

            # Gestione ritardi
            $DataConsegna = (Get-ChildItem $SOURCE).LastWriteTime
            #if( ($DataConsegna -gt $VALIDITA_DAL) -and ($DataConsegna -lt $VALIDITA_AL) ) {
            if($DataConsegna -lt $VALIDITA_AL) {
                    $compitoInRitardo = $false
            }
            else {
                $compitoInRitardo = $true
                $numeroFileFuoriTempo++
            }
            $strDataConsegna = Get-Date $DataConsegna -format "dd/MM hh:mm"
            $strDataScadenza = Get-Date $VALIDITA_AL -format "dd/MM hh:mm"

            # Gestione file enormi...
            if( ((Get-ChildItem $SOURCE).Length) -lt 5000000 ) {

                # Compito trovato
                write-host ("{0}" -f $SOURCE_FILE) -foreground $Ok_Color

                # Crea la directory di destinazione pulita
                New-Item -ItemType Directory -Path $PRJ_DEST_DIR/$alunno -Force | Out-Null
                
                # Dezippa il file nella destinazione
                Expand-Archive -LiteralPath $SOURCE -DestinationPath $PRJ_DEST_DIR/$alunno -Force
            
                # Cerca ed elimina cartelle del MAC che danno fastidio
                $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR/$alunno -Filter ("__MACOSX") -Recurse -ErrorAction SilentlyContinue -Force
                if( $sorgenteConPath -ne $null ){
                    Remove-Item -LiteralPath ((Split-Path $sorgenteConPath) + "/__MACOSX") -Force -Recurse
                }
                        
                if( $LANCIA_TEST -eq "" ) { 
                    $tr = @{
                        Alunno       = $alunno 
                        Classe       = $CLASSE.NOME
                        Consegna     = $strDataConsegna
                        Scadenza     = $strDataScadenza
                        Progetto     = $PROGETTO
                        Materia      = $CLASSE.MATERIA
                        Alterato     = "-"
                        Risultato    = "only unzip"
                        Quanti       = "0"
                        Passati      = "0"
                        Falliti      = "0"
                        Errori       = "0"
                        Timeout      = "0"
                        Hash         = "-"
                    }
                    $risultato = New-Object PSObject -Property $tr 
                    $Risultati.Add($risultato) | Out-Null

                    continue 
                }

                # Cerca il .csproj
                $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR/$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force

                # Se non lo trovo, segnalo in rosso
                if( $sorgenteConPath -eq $null ){
                    
                    # Errore Zip non decompresso
                    Write-host ("Manca .csproj {0}" -f (Get-ChildItem $sorgenteConPath)) -ForegroundColor $TooLateAccepted_Color
                    $tr = @{
                        Alunno       = $alunno 
                        Classe       = $CLASSE.NOME
                        Consegna     = $strDataConsegna
                        Scadenza     = $strDataScadenza
                        Progetto     = $PROGETTO
                        Materia      = $CLASSE.MATERIA
                        Alterato     = "-"
                        Risultato    = "Zip Err "
                        Quanti       = "0"
                        Passati      = "0"
                        Falliti      = "0"
                        Errori       = "0"
                        Timeout      = "0"
                        Hash         = "-"
                    }
                    $risultato = New-Object PSObject -Property $tr 
                    $RisultatiKO.Add($risultato) | Out-Null
                }
                else {
                    # Sistema quelli che hanno consegnato in directory annidate  
                    $destinazione = $PRJ_DEST_DIR + "/" + $alunno
                    if( $destinazione -ne (Split-Path $sorgenteConPath) ){
                        #$tutti_i_file_estratti = (Split-Path $sorgenteConPath) + "/*.*"
                        $tutti_i_file_estratti = (Split-Path $sorgenteConPath)
                        
                        # Porta su la vecchia directory 
                        Get-ChildItem -Path $tutti_i_file_estratti -Recurse | Move-Item -Destination $destinazione
        
                        # Cancella la vecchia directory 
                        Remove-Item -LiteralPath (Split-Path $sorgenteConPath)  -Force -Recurse
                    }
                    #$destinazione
                    #(Split-Path $sorgenteConPath)
                    #$tutti_i_file_estratti
                    #$sorgenteConPath
                    #return
                    
                    Set-Location -Path $PRJ_DEST_DIR

                    # Crea la solution se manca
                    #$fileSln = Get-ChildItem -Path $PRJ_DEST_DIR -Filter ("*.sln") -ErrorAction SilentlyContinue -Force
                    #if( $fileSln -eq $null ){
                    #    dotnet new sln -n $PROGETTO 
                    #    #Write-host ("Creo sln... ") -ForegroundColor $Test_Color
                    #}

                    # Rinomina in .old il file progetto dell'alunno (se serve... è li)
                    $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    Rename-Item -Path $sorgenteConPath -NewName ($alunno + ".csproj.old")

                    # Sovrascrive .csproj dell'alunno con quello originale dato da me"
                    $csprojFile = Get-ChildItem -Path $PATH_DEST_ESERCIZIO_ORIGINALE -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    #$csprojFile = ($ScriptDirectory + "/resource/csproj/v2.csproj")
                    Copy-Item -Path $csprojFile -Destination ($PRJ_DEST_DIR + "/" + $alunno + "/" + $alunno + ".csproj")

                    #
                    #
                    # Microscopico sistema di ricerca di compiti uguali... 
                    # (non adatto, è una prova)
                    # Si basa solo sul calcolo dell'HASH del file sorgente alunno
                    #
                    # Calcola Hash del file sorgente
                    $nomeFileProgetto = [System.IO.Path]::GetFileNameWithoutExtension($sorgenteConPath)
                    $pathFileProgetto = ("$PRJ_DEST_DIR/$alunno/$nomeFileProgetto" + ".cs")    
                    if ((Test-Path $pathFileProgetto) -eq $true) {
                        $csAlunno = Get-ChildItem -Path $pathFileProgetto  
                        $hashSorgenteAlunno = (Get-FileHash $csAlunno -Algorithm MD5).Hash
    
                        #write-host "->> $nomeFileProgetto <<-"
                        #write-host "->> $pathFileProgetto <<-"
                        #write-host "->> $csAlunno <<-"
    
                        #$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
                        #$hashSorgenteAlunno = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($csAlunno)))
                        }
                    else {
                        $hashSorgenteAlunno = "Sorgente rinominato? Controllare a mano!"
                    }

                    #write-host "->> $hashSorgenteAlunno <<-"
                    #Set-Location -Path $attuale
                    #return
                    
                    # Calcola Hash del file dei test alunno
                    $pathFileProgetto = ("$PRJ_DEST_DIR/$alunno/$nomeFileProgetto" + "Test.cs")
                    if ((Test-Path $pathFileProgetto) -eq $true) {
                        $csAlunno = Get-ChildItem -Path $pathFileProgetto  
                        $hashFileTestAlunno = (Get-FileHash $csAlunno -Algorithm MD5).Hash
                        
                        #$csAlunno | Format-List
                        
                        # Verifico se il file dei test è stato modificato
                        $fileTestModificato = ($hashFileTestOriginale -ne $hashFileTestAlunno)
                        if($fileTestModificato) {
                            # Se sono diversi lo segnala
                            Write-Host $hashFileTestAlunno -foreground $Wrong_Color
                            Write-Host $hashFileTestOriginale -foreground $OK_Color   
                            $nuovoFileName = ($csAlunno).Name + ".old" 
                            Rename-Item -Path $csAlunno -NewName $nuovoFileName
                        }

                        #Set-Location -Path $attuale
                        #return
    
                        # Lo copia fresco
                        Copy-Item -Path $csTestFile -Destination "$PRJ_DEST_DIR/$alunno"

                    }
                    else {
                        write-host "->> Non trovato file test alunno... $csAlunno <<-" -foreground "Red"
                        $hashFileTestAlunno = "??"
                    }

                    #$csTestAlunno = Get-ChildItem -Path "$PRJ_DEST_DIR/$alunno" -Filter ($nomeFileProgetto + "Test.cs")  
                    #$hashAlunno = (Get-FileHash $csTestAlunno -Algorithm MD5)
                    #$hashFileTestAlunno = $hashAlunno.Hash
                    #$fileNameFileTestAlunno = $hashAlunno.Path


                    #write-host "Test originale " + $csTestFileOriginale + ", hash: " + $hashFileTestOriginale
                    #$hashAlunno | Format-List
                    #write-host ""
                    #write-host "Alunno " + $fileNameFileTestAlunno + ", hash: " + $hashFileTestAlunno

                    #write-host "nome file test originale"
                    #write-host $csTestFileOriginale
                    #write-host "hash originale"
                    #write-host $hashFileTestOriginale
                    



                    
                    # Copia nella dir anche il runsettings per i test (timeout)
                    $runSettingFile = ($ScriptDirectory + "/resource/runsettings/test.runsettings")
                    Copy-Item -Path $runSettingFile -Destination "$PRJ_DEST_DIR/$alunno"

                    # Lancia il build
                    $csprojectFile = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    # Write-host ("Progetto " + $csprojectFile) -ForegroundColor $Test_Color
                    dotnet build $csprojectFile | Out-Null

                    # se $? è true, il comando build è riuscito
                    if( $? ){

                        # Da sopra, se ti chiamo con:
                        #  - "test"    fa il test a patto che il file dei test sia integro
                        #  - "force"   fa il test sempre e comunque
                        #
                        if ( ($LANCIA_TEST -eq "test" -and -not $fileTestModificato) -or ($LANCIA_TEST -eq "force")  ){
                            Write-Host "lancio..."

                            # Crea la cartella dei risultati di test
                            New-Item -ItemType directory -Path ($PRJ_DEST_DIR + "/" + $alunno + "/TestResults") | Out-Null
                            
                            #
                            # Lancia i test generando i file html
                            #
                            #$loggerParam = "--logger:"+'"'+"html" + '"'
                            #dotnet test $csprojectFile -s ($PRJ_DEST_DIR + "/" + $alunno + "/test.runsettings") $loggerParam  | Out-Null
                            
                            # Cerca il file html e lo rinomina cognome.nome.gli da il nome dell'alunno 
                            #$sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.html") -Recurse -ErrorAction SilentlyContinue -Force
                            #if( $sorgenteConPath -ne $NULL ) {
                            #    Rename-Item -Path $sorgenteConPath -NewName ( $alunno + "." + $NOME_CLASSE + "." + $PROGETTO + ".html")
                            #}

                            #
                            # Lancia i test generando il file .trx
                            #
                            #$loggerParam = "--logger:"+'"'+"trx;LogFileName=" + ($PRJ_DEST_DIR + "\" + $alunno + "\logFile.trx") + '"'
                            #$loggerParam = "--logger html"
                            $loggerParam = "--logger:"+'"'+"trx" + '"'
                            $commandLine = "dotnet test $csprojectFile -s $PRJ_DEST_DIR\$alunno\test.runsettings " + $loggerParam 
                            dotnet test $csprojectFile -s ($PRJ_DEST_DIR + "/" + $alunno + "/test.runsettings") $loggerParam | Out-Null
                            
                            #Set-Location -Path $attuale
                            #return
                            
                            # parse del file trx 
                            $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.trx") -Recurse -ErrorAction SilentlyContinue -Force
                            if( $sorgenteConPath -ne $NULL ) {
                                [xml]$testResults = Get-Content -Path $sorgenteConPath

                                $tr = @{
                                    Alunno       = $alunno
                                    Classe       = $CLASSE.NOME
                                    Consegna     = $strDataConsegna
                                    Scadenza     = $strDataScadenza
                                    Progetto     = $PROGETTO
                                    Materia      = $CLASSE.MATERIA
                                    Risultato    = "Tested, " + (Get-StatoCompito $testResults $compitoInRitardo $fileTestModificato)
                                    Alterato     = if($fileTestModificato) {"Test alterato"} else {"-"}
                                    Quanti       = $testResults.TestRun.ResultSummary.Counters.total
                                    Passati      = $testResults.TestRun.ResultSummary.Counters.passed
                                    Falliti      = $testResults.TestRun.ResultSummary.Counters.failed
                                    Errori       = $testResults.TestRun.ResultSummary.RunInfos.RunInfo.outcome
                                    Voto         = Get-Voto $testResults $attivo
                                    Peso         = $attivo.Peso
                                    Timeout      = $TestRun.ResultSummary.Counters.timeout
                                    Hash         = $hashSorgenteAlunno
                                }                                    
                                $risultato = New-Object PSObject -Property $tr 

                                # Se i test passati sono > 0 OK... altrimenti KO
                                if( $testResults.TestRun.ResultSummary.Counters.passed -gt 0 ){
                                    $Risultati.Add($risultato) | Out-Null
                                }
                                else {
                                    $RisultatiKO.Add($risultato) | Out-Null                                
                                }
                            }                            

                            # decommentare per aggiungere  il nuovo .csproj alla solution
                            #dotnet sln ($PROGETTO + ".sln") add $csprojectFile
                        }
                        else {
                            # Test non lanciato
                            Write-Host "Non lancio..."

                            $tr = @{
                                Alunno       = $alunno
                                Classe       = $CLASSE.NOME
                                Consegna     = $strDataConsegna
                                Scadenza     = $strDataScadenza
                                Progetto     = $PROGETTO
                                Materia      = $CLASSE.MATERIA
                                Alterato     = if($fileTestModificato) {"Test alterato"} else {"-"}
                                Risultato    = "Not tested, " + (Get-StatoCompito $testResults $compitoInRitardo $fileTestModificato)
                                Quanti       = "0"
                                Passati      = "0"
                                Falliti      = "0"
                                Errori       = "0"
                                Voto         = "{0:N1}" -f $VOTO_MINIMO
                                Peso         = $attivo.Peso
                                Timeout      = "0"
                                Hash         = $hashSorgenteAlunno
                            }
                            $risultato = New-Object PSObject -Property $tr 
                            $RisultatiKO.Add($risultato) | Out-Null
                        }
                    }
                    else{
                        # Il compito non si compila
                        Write-host ( "{0}{1}$TAB({2})$TAB({3})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime, (Get-ChildItem $SOURCE).Length) -BackgroundColor $Wrong_Color
                        $tr = @{
                            Alunno       = $alunno
                            Classe       = $CLASSE.NOME
                            Consegna     = $strDataConsegna
                            Scadenza     = $strDataScadenza
                            Progetto     = $PROGETTO
                            Materia      = $CLASSE.MATERIA
                            Risultato    = "Not compiled"
                            Alterato     = if($fileTestModificato) {"Test alterato"} else {"-"}
                            Quanti       = "0"
                            Passati      = "0"
                            Falliti      = "0"
                            Errori       = "0"
                            Timeout      = "0"
                            Hash         = $hashSorgenteAlunno
                        }
                        $risultato = New-Object PSObject -Property $tr 
                        $RisultatiKO.Add($risultato) | Out-Null
                    }
                }
                
                #Write-host ("{0}" -f $tutti_i_file_estratti) -ForegroundColor $TooLateNotAccepted_Color
                #Write-host ("{0}" -f $destinazione ) -ForegroundColor $OK_Color
            }
            else{
                # File del compito troppo grandi, non ritirato
                Write-host ( "{0}{1}$TAB({2})$TAB({3})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime, (Get-ChildItem $SOURCE).Length) -BackgroundColor $TooBig_Color
                $tr = @{
                    Alunno       = $alunno
                    Classe       = $CLASSE.NOME
                    Consegna     = $strDataConsegna
                    Scadenza     = $strDataScadenza
                    Progetto     = $PROGETTO
                    Materia      = $CLASSE.MATERIA
                    Risultato    = "Too big"
                    Alterato     = if($fileTestModificato) {"Test alterato"} else {"-"}
                    Quanti       = "0"
                    Passati      = "0"
                    Falliti      = "0"
                    Errori       = "0"
                    Timeout      = "0"  
                    Hash         = "-"
                }
                $risultato = New-Object PSObject -Property $tr 
                $RisultatiKO.Add($risultato) | Out-Null
            }

            $numeroFile++
        } 
        else {
            # Compito non trovato
            write-host ("{0}" -f $SOURCE_FILE) -foreground $Wrong_Color

            $tr = @{
                Alunno       = $alunno
                Classe       = $CLASSE.NOME
                Consegna     = $strDataConsegna
                Scadenza     = $strDataScadenza
                Progetto     = $PROGETTO
                Materia      = $CLASSE.MATERIA
                Risultato    = "Not found"
                Alterato     = if($fileTestModificato) {"Test alterato"} else {"-"}
                Quanti       = "0"
                Passati      = "0"
                Falliti      = "0"
                Errori       = "0"
                Timeout      = "0"
                Hash         = "-"
            }
            $risultato = New-Object PSObject -Property $tr 
            $RisultatiKO.Add($risultato) | Out-Null
        }
    }

    Write-Host "Destinazione .csv"
    Write-Host $CSV_DEST_DIR
    Write-Host ""

    # 
    # Esporta CSV
    #

    # Se la cartella dei CSV non esiste, tocca crearla
    # E' il caso in cui nessuno consegna...
    
    # Cartella locale
    if ((Test-Path $CSV_DEST_DIR) -ne $true) {
        New-Item -ItemType Directory -Path $CSV_DEST_DIR -Force | Out-Null
    }

    # Cartella GDrive
    if ((Test-Path $CSV_DEST_DIR2) -ne $true) {
        New-Item -ItemType Directory -Path $CSV_DEST_DIR2 -Force | Out-Null
    }
    
    # Sistema le dir...
    $CSV_DEST_DIR = $CSV_DEST_DIR + "/" + $CLASSE.NOME + "." + $PROGETTO
    $CSV_DEST_DIR2 = $CSV_DEST_DIR2 + "/" + $CLASSE.NOME + "." + $PROGETTO

    # Esporta risultati OK
    $res = $Risultati | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Alterato, Peso, Voto, Quanti, Passati, Falliti, Errori, Timeout, Hash | Sort-Object -Property Hash
    $res | Export-Csv -Path ($CSV_DEST_DIR + "OK.csv") -NoTypeInformation
    $res | Export-Csv -Path ($CSV_DEST_DIR2 + "OK.csv") -NoTypeInformation
    
    # Esporta risultati KO
    $res = $RisultatiKO | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Alterato, Peso, Voto, Quanti, Passati, Falliti, Errori, Timeout, Hash
    $res | Export-Csv -Path ($CSV_DEST_DIR + "KO.csv") -NoTypeInformation
    $res | Export-Csv -Path ($CSV_DEST_DIR2 + "KO.csv") -NoTypeInformation

    # Esporta Tutti i risultati in ordine alfabetico
    $res = ($Risultati + $RisultatiKO) | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Alterato, Peso, Voto, Quanti, Passati, Falliti, Errori, Timeout, Hash | Sort-Object -Property Alunno
    $res | Export-Csv -Path ($CSV_DEST_DIR + ".csv") -NoTypeInformation
    $res | Export-Csv -Path ($CSV_DEST_DIR2 + ".csv") -NoTypeInformation

    # Esporta Tutti i risultati in ordine di hash (identifica le copie)
    $res = ($Risultati + $RisultatiKO) | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Alterato, Peso, Voto, Quanti, Passati, Falliti, Errori, Timeout, Hash | Sort-Object -Property Hash
    $res | Export-Csv -Path ($CSV_DEST_DIR + "-hash.csv") -NoTypeInformation
    $res | Export-Csv -Path ($CSV_DEST_DIR2 + "-hash.csv") -NoTypeInformation
    
    #$Risultati | Format-Table Classe, Progetto, Alunno, Consegna, Scadenza, Risultato, Passati, Quanti
    #Write-PSObject ($Risultati | Select-Object -Property Classe, Progetto, Alunno, Scadenza, Risultato, Passati, Quanti) -MatchMethod Exact -Column Risultato -Value "Not found" -ValueForeColor Red -FlagColumns "'Alunno'" -FlagsForeColor Red;

    # Visualizza a video...    
    Write-PSObject (($Risultati + $RisultatiKO) | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Alterato, Peso, Voto, Quanti, Passati, Falliti, Errori, Timeout, Hash) `
    -MatchMethod Exact, Exact, Exact, Exact, Exact, Exact `
    -Column 'Risultato', 'Risultato', 'Risultato', 'Risultato', 'Risultato', 'Risultato' `
    -Value "Not found", "Too late", "Too big", "Not compiled", "Failed", "Completed"  `
    -ValueForeColor Red, Yellow, Red, Red, Yellow, Green `
    -FlagColumns 'Alunno', 'Alunno', 'Alunno', 'Alunno', 'Alunno', 'Alunno' `
    -FlagsForeColor Red, Yellow, Red, Red, Yellow, Green 

    Set-Location -Path $attuale
}

#
#
#
function Get-Progetto {
    
    [CmdletBinding()]
    param( [string]$NPROGETTO, [string]$NOME_CLASSE )

    #Progetti | Export-Csv ("Progetti.csv") -NoTypeInformation
    #$FILE_PROGETTI = "$ScriptDirectory/settings/$NOME_CLASSE-$MATERIA-Progetti.csv"        
    #$Progetti = Import-Csv $FILE_PROGETTI

    $Url = "https://docs.google.com/spreadsheets/d/1W0sucmYZl4gDoC-71C2BxgxVwagTaNT7pFle_nbl3i0/export?format=csv"
    Invoke-WebRequest -Uri $Url -OutFile "Log/tmpElencoProgetti.csv"
    $dati_csv = Import-CSV "Log/tmpElencoProgetti.csv"

    $Progetti = New-Object System.Collections.ArrayList
    foreach( $p in $dati_csv )
    {
        if( $p.("Nome$NOME_CLASSE") -ne "" -and $p.("Data$NOME_CLASSE") -ne "" ){
            
            $peso = 100
            try {$peso = [convert]::ToDouble($p.("Peso"))}
            catch{ Write-Host "manca il peso nel file elenco esercizi... assegno 100" -foreground $Wrong_Color }

            $progetto = @{
                Nome = $p.("Nome$NOME_CLASSE")
                Dal = (Get-Date $p.("Data$NOME_CLASSE"))
                Al = (Get-Date $p.("Data$NOME_CLASSE")).AddMinutes(15)
                Minimo = 4
                Massimo = 10
                Peso = $peso
            }                                    
            
            $risultato = New-Object PSObject -Property $progetto 
            $Progetti.Add($risultato) | Out-Null
        }
    }

    #$Progetti | Format-Table

    # Cerca il progetto richiesto
    $idx=0
    foreach( $p in ($Progetti) ){
        if( $p.Nome -eq $NPROGETTO ) {
           break;
        }
        $idx++
    }

    if ($idx -lt ($Progetti).Count ) {
        $attivo=($Progetti)[$idx]
        Write-host "Trovato progetto $NPROGETTO (indice $idx)."  -foreground $OK_Color
        return $attivo
    }
    else {
        Write-host "Progetto $NPROGETTO non trovato, aggiornare elenco progetti" -foreground $Wrong_Color
        $Progetti | Format-Table
        Exit
    }
}


#
#
#
function Get-Voto {

    [CmdletBinding()]
    param( $testResults, $attivo )

    if( $testResults.TestRun.ResultSummary.Counters.total -ne 0) {
        $VOTO = $testResults.TestRun.ResultSummary.Counters.passed / $testResults.TestRun.ResultSummary.Counters.total
        $VOTO1 = ($VOTO_MASSIMO-$VOTO_MINIMO)*$VOTO+$VOTO_MINIMO
        $VOTO1 = $VOTO1 * ($attivo.Peso / 100.0)

        # Se l'hai consegnato, anche se ci sono pochi test, ti aumento il voto
        if( $VOTO1 -eq $VOTO_MINIMO ) { 
            $VOTO1 = $VOTO1 + 0.8
        }
        
        return "{0:N1}" -f $VOTO1
    }
    return "{0:N1}" -f $VOTO_MINIMO
}

function Get-StatoCompito {

    [CmdletBinding()]
    param( $testResults, $compitoInRitardo, $fileTestModificato )

    if( $compitoInRitardo ) {
        $statoDelCompito = "Too late"
    }
    else {
        if( $testResults -ne $NULL ){
            if( $testResults.TestRun.ResultSummary.Counters.total -ne 0) {
                $dueTerzi = $testResults.TestRun.ResultSummary.Counters.passed/$testResults.TestRun.ResultSummary.Counters.total
                if( $dueTerzi -lt 0.55 ){
                    $statoDelCompito = $testResults.TestRun.ResultSummary.outcome
                }
                else{
                    $statoDelCompito = "Completed"
                }
            }
            else {
                $statoDelCompito = $testResults.TestRun.ResultSummary.outcome
            }
        }
    }

    # Ora abbiamo un campo apposta per lo stato alterato
    #if ( $fileTestModificato )
    #{
    #    $statoDelCompito = $statoDelCompito + ", test altered"
    #}

    return $statoDelCompito
}

#
#
#
function Esporta-CSV
{
    [CmdletBinding()]
    param( $NOME_CLASSE, $MATERIA )

    write-host "Per ora non esporto il riepilogo globale CSV..." -foreground $Warning_Color
    write-host ""
    return

    $attuale = Get-Location 
    
    #  uso la path delle consegne... non questa ...  
    #$DesktopPath = [Environment]::GetFolderPath("Desktop")
    #$workDir = "$DesktopPath\Consegnati\$NOME_CLASSE\$MATERIA"
    #Set-Location -Path $workDir

    # Spostandomi direttamente sulla dir delle consegne,
    # posso lavorare con path relative.
    Set-Location -Path $PRJ_DEST_DIR
    Write-Host $PRJ_DEST_DIR
    Set-Location -Path $attuale

    return

    # tipo questa
    $NOME_FILE = (".\$NOME_CLASSE-$MATERIA")
     
    if( Test-Path ("$NOME_FILE-ConErrori.csv") ){
        Remove-Item ("$NOME_FILE-ConErrori.csv")
    }

    if( Test-Path ("$NOME_FILE-SenzaErrori.csv") ){
        Remove-Item ("$NOME_FILE-SenzaErrori.csv")
    }
    
    Write-Host ""
    Write-Host "-----------> Esporta-CSV"
    Write-Host "Leggo tutti i file OK e ne faccio uno in $NOME_FILE"    
    Get-ChildItem -Filter *KO.csv -Recurse | Select-Object -ExpandProperty FullName | Import-Csv  | Export-Csv ($NOME_FILE + "-ConErrori.csv") -NoTypeInformation -Append 

    Write-Host "Leggo tutti i file KO e ne faccio uno in $NOME_FILE"    
    Get-ChildItem -Filter *OK.csv -Recurse | Select-Object -ExpandProperty FullName | Import-Csv  | Export-Csv ($NOME_FILE + "-SenzaErrori.csv") -NoTypeInformation -Append
    
    $ConErrori = Import-Csv ($NOME_FILE + "-ConErrori.csv")
    $SenzaErrori = Import-Csv ($NOME_FILE + "-SenzaErrori.csv")

    Write-Host "Produco i file di riepilogo -PerAlunno, -PerProgetto ..."
    ($ConErrori + $SenzaErrori) | Sort-Object -Property Alunno | Export-Csv ($NOME_FILE + "-PerAlunno.csv") -NoTypeInformation
    ($ConErrori + $SenzaErrori) | Sort-Object -Property Progetto, Alunno | Export-Csv ($NOME_FILE + "-PerProgetto.csv") -NoTypeInformation
    ($ConErrori + $SenzaErrori) | Sort-Object -Property Progetto, Risultato, Alunno | Export-Csv ($NOME_FILE + "-PerProgettoRisultato.csv") -NoTypeInformation

    Set-Location -Path $attuale

    Write-Host "<-----------"
    Write-Host ""
}
function Print-Footer
{    
    Write-host ""
    Write-Host "Compito:" $PROGETTO"."$ESTENSIONE
    Write-host "Previsti: "$numeroAlunni
    Write-Host "Consegnati:" $numeroFile
    Write-Host "Ritardo:" $numeroFileFuoriTempo
    Write-Host "Mancanti:" ($numeroAlunni-$numeroFile-$numeroFileFuoriTempo)
    Write-host "- - - - - - - - - - - - - - - - - -"
}

function Print-Header 
{
    Write-host ""
    Write-Host "Compito:" $PROGETTO"."$ESTENSIONE
    Write-host "Valido fino al $VALIDITA_AL"
    Write-Host "Voto dal $VOTO_MINIMO al $VOTO_MASSIMO"
    Write-host "Sorgente:" $ROOT_SORGENTE/$PROGETTO
    Write-host "Cartella della correzione: $PRJ_DEST_DIR"
    Write-host ""
    #Write-host "Legenda:"
    #Write-host "- - - - - - - - - - - - - - - - - -"
    #Write-host "Presente" -foreground $OK_Color
    #Write-host "Non Presente" -foreground $Wrong_Color
    #Write-host "Ritardo (non ritirato)" -foreground $TooLateNotAccepted_Color
    #Write-host "Ritardo (accettato ugualmente)" -foreground $TooLateAccepted_Color
    #Write-host "Troppo grande!" -Background $TooBig_Color
    #Write-host "Nomi (1) presenti" -BackgroundColor $DoubleDelivery_Color
    #Write-host "- - - - - - - - - - - - - - - - - -"
}
