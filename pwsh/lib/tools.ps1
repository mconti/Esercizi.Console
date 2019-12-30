#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#
# general purpose funcions and utility
#

#

# 
#

function Ritira-Compito {

    [CmdletBinding()]
    [OutputType("Void")]
    param( [string]$NOME_CLASSE, [string]$MATERIA, [string]$NPROGETTO )

    # Inizializza $CLASSE
    . ($ScriptDirectory + "/settings/" + $NOME_CLASSE + "-" + $MATERIA + ".ps1")        
    
    # Seleziona progetto
    $attivo = Get-Progetto $NPROGETTO
    $PROGETTO = $attivo.Nome
    $VALIDITA_DAL = (Get-Date ($attivo.Dal))
    $VALIDITA_AL = (Get-Date ($attivo.Al))
    $DATA = (Get-Date -format yy)+(Get-Date -format MM)+(Get-Date -format dd)+(Get-Date -format HH)
    $VOTO_MINIMO = $attivo.Minimo
    $VOTO_MASSIMO = $attivo.Massimo
    
    # Verifica le path necessarie
    if ((Test-Path $ROOT) -eq $true) {
        Write-Host "Trovata la cartella sorgente $ROOT" -foreground $OK_Color
        $ROOT_SORGENTE = ($ROOT + "/" + $CLASSE.LOCAL)

        if ((Test-Path $ROOT_SORGENTE) -eq $true) {
            Write-Host "Trovata la cartella della classe "$CLASSE.LOCAL -foreground $OK_Color
    
            $DesktopPath = [Environment]::GetFolderPath("Desktop")
            Write-Host "La cartella di destinazione sarà $DesktopPath" -foreground $OK_Color

            $PRJ_DEST_DIR = $DesktopPath + "/Consegnati/" + $CLASSE.NOME + "/" + $CLASSE.MATERIA + "/" + $PROGETTO + "/" + $DATA
            $CSV_DEST_DIR = $DesktopPath + "/Consegnati/" + $CLASSE.NOME + "/" + $CLASSE.MATERIA + "/" + $PROGETTO
            $PRJ_DEST_DIR_RITARDO = $DesktopPath + "/Consegnati/" + $CLASSE.NOME + "/" + $CLASSE.MATERIA + "/" + $PROGETTO + "/" + $DATA + "R"
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
    if ((Test-Path $CSV_DEST_DIR) -eq $true) {
        Remove-Item -LiteralPath $CSV_DEST_DIR -Force -Recurse
    }

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
            if( ($DataConsegna -gt $VALIDITA_DAL) -and ($DataConsegna -lt $VALIDITA_AL) ) {
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
            
                # Elimina lartelle del MAC che danno fastidio
                $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR/$alunno -Filter ("__MACOSX") -Recurse -ErrorAction SilentlyContinue -Force
                
                if( $sorgenteConPath -ne $null ){
                    Remove-Item -LiteralPath ((Split-Path $sorgenteConPath) + "/__MACOSX") -Force -Recurse
                }
                        
                # Cerca il .csproj
                $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR/$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force

                # Se non lo trovo, segnalo in rosso
                if( $sorgenteConPath -eq $null ){
                    Write-host ("Manca .csproj {0}" -f (Get-ChildItem $sorgenteConPath)) -ForegroundColor $TooLateAccepted_Color
                }
                else {
                    # Sistema quelli che hanno consegnato in directory annidate  
                    $destinazione = $PRJ_DEST_DIR + "/" + $alunno
                    if( $destinazione -ne (Split-Path $sorgenteConPath) ){
                        $tutti_i_file_estratti = (Split-Path $sorgenteConPath) + "/*.*"
                        # Porta su la vecchia directory 
                        Move-Item -Path $tutti_i_file_estratti -Destination $destinazione
        
                        # Cancella la vecchia directory 
                        Remove-Item -LiteralPath (Split-Path $sorgenteConPath)  -Force -Recurse
                    }
                
                    Set-Location -Path $PRJ_DEST_DIR

                    # Crea la solution se manca
                    #$fileSln = Get-ChildItem -Path $PRJ_DEST_DIR -Filter ("*.sln") -ErrorAction SilentlyContinue -Force
                    #if( $fileSln -eq $null ){
                    #    dotnet new sln -n $PROGETTO 
                    #    #Write-host ("Creo sln... ") -ForegroundColor $Test_Color
                    #}

                    # Ri-Cerca il .csproj nella nuova posizione e gli da il nome dell'alunno 
                    $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    Rename-Item -Path $sorgenteConPath -NewName ($alunno + ".csproj.old")

                    # Copia nella dir, il csproj per i test
                    $csprojFile = ($ScriptDirectory + "/resource/csproj/v2.csproj")
                    Copy-Item -Path $csprojFile -Destination ($PRJ_DEST_DIR + "/" + $alunno + "/" + $alunno + ".csproj")
                    
                    # Copia nella dir, il runsettings per i test
                    $runSettingFile = ($ScriptDirectory + "/resource/runsettings/test.runsettings")
                    Copy-Item -Path $runSettingFile -Destination $PRJ_DEST_DIR\$alunno

                    # Lancia il build
                    $csprojectFile = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    # Write-host ("Progetto " + $csprojectFile) -ForegroundColor $Test_Color
                    dotnet build $csprojectFile | Out-Null

                    # se &? è true, il comando è riuscito
                    if( $? ){
                        
                        # Crea la cartella dei risultati di test
                        New-Item -ItemType directory -Path ($PRJ_DEST_DIR + "/" + $alunno + "/TestResults") | Out-Null
                        
                        # Lancia i test generando i file html
                        $loggerParam = "--logger:"+'"'+"html" + '"'
                        dotnet test $csprojectFile -s ($PRJ_DEST_DIR + "/" + $alunno + "/test.runsettings") $loggerParam | Out-Null
                        
                        # Cerca il file html e lo rinomina cognome.nome.gli da il nome dell'alunno 
                        $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.html") -Recurse -ErrorAction SilentlyContinue -Force
                        if( $sorgenteConPath -ne $NULL ) {
                            Rename-Item -Path $sorgenteConPath -NewName ( $alunno + "." + $NOME_CLASSE + "." + $PROGETTO + ".html")
                        }

                        # Lancia i test generando il file .trx
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
                                Risultato    = Get-StatoCompito $testResults $compitoInRitardo
                                Quanti       = $testResults.TestRun.ResultSummary.Counters.total
                                Passati      = $testResults.TestRun.ResultSummary.Counters.passed
                                Falliti      = $testResults.TestRun.ResultSummary.Counters.failed
                                Errori       = $testResults.TestRun.ResultSummary.RunInfos.RunInfo.outcome
                                Voto         = Get-Voto $testResults
                                Timeout      = $TestRun.ResultSummary.Counters.timeout
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
                            Quanti       = "0"
                            Passati      = "0"
                            Falliti      = "0"
                            Errori       = "0"
                            Voto         = "{0:N1}" -f $VOTO_MINIMO
                            Timeout      = "0"
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
                    Quanti       = "0"
                    Passati      = "0"
                    Falliti      = "0"
                    Errori       = "0"
                    Voto         = "{0:N1}" -f $VOTO_MINIMO
                    Timeout      = "0"  
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
                Quanti       = "0"
                Passati      = "0"
                Falliti      = "0"
                Errori       = "0"
                Voto         = "{0:N1}" -f $VOTO_MINIMO
                Timeout      = "0"
            }
            $risultato = New-Object PSObject -Property $tr 
            $RisultatiKO.Add($risultato) | Out-Null
        }
    }

    # Esporta CSV
    if ((Test-Path $CSV_DEST_DIR) -ne $true) {
        # Se la cartella non esiste, tocca crearla
        # E' il caso in cui nessuno consegna...
        New-Item -ItemType Directory -Path $CSV_DEST_DIR -Force | Out-Null
    }
    
    # Esporta risultati OK
    $Risultati | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Voto, Quanti, Passati, Falliti, Errori, Timeout |  `    
    Export-Csv -Path ($CSV_DEST_DIR + "/" + $CLASSE.NOME + "." + $PROGETTO + "OK.csv") -NoTypeInformation

    # Esporta risultati KO
    $RisultatiKO | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Voto, Quanti, Passati, Falliti, Errori, Timeout |  `    
    Export-Csv -Path ($CSV_DEST_DIR + "/" + $CLASSE.NOME + "." + $PROGETTO + "KO.csv") -NoTypeInformation

    # Esporta Tutti i risultati
    ($Risultati + $RisultatiKO) | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Voto, Quanti, Passati, Falliti, Errori, Timeout | Sort-Object -Property Alunno | `    
    Export-Csv -Path ($CSV_DEST_DIR + "/" + $CLASSE.NOME + "." + $PROGETTO + ".csv") -NoTypeInformation
    
    #$Risultati | Format-Table Classe, Progetto, Alunno, Consegna, Scadenza, Risultato, Passati, Quanti
    #Write-PSObject ($Risultati | Select-Object -Property Classe, Progetto, Alunno, Scadenza, Risultato, Passati, Quanti) -MatchMethod Exact -Column Risultato -Value "Not found" -ValueForeColor Red -FlagColumns "'Alunno'" -FlagsForeColor Red;

    # Visualizza a video...    
    Write-PSObject (($Risultati + $RisultatiKO) | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Voto, Quanti, Passati, Falliti, Errori, Timeout) `
    -MatchMethod Exact, Exact, Exact, Exact, Exact, Exact `
    -Column 'Risultato', 'Risultato', 'Risultato', 'Risultato', 'Risultato', 'Risultato' `
    -Value "Not found", "Too late", "Too big", "Not compiled", "Failed", "Completed"  `
    -ValueForeColor Red, Yellow, Red, Red, Yellow, Green `
    -FlagColumns 'Alunno', 'Alunno', 'Alunno', 'Alunno', 'Alunno', 'Alunno' `
    -FlagsForeColor Red, Yellow, Red, Red, Yellow, Green 

    Set-Location -Path $attuale
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
    Write-host "Valido dal $VALIDITA_DAL al $VALIDITA_AL"
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

#
#
#
function Get-Progetto {

    [CmdletBinding()]
    param( [string]$NPROGETTO )

    $idx=0
    foreach( $p in (Progetti) ){
        if( $p.Nome -eq $NPROGETTO ) {
           break;
        }
        $idx++
    }

    if ($idx -lt (Progetti).Count ) {
        $attivo=(Progetti)[$idx]
        #Write-host "Trovato progetto $NPROGETTO (indice $idx)."  -foreground $OK_Color
        return $attivo
    }
    else {
        Write-host "Progetto $NPROGETTO non trovato, aggiornare elenco progetti."  -foreground $Wrong_Color
        Exit
    }
}

#
#
#
function Get-Voto {

    [CmdletBinding()]
    param( $testResults )

    if( $testResults.TestRun.ResultSummary.Counters.total -ne 0) {
        $VOTO = $testResults.TestRun.ResultSummary.Counters.passed / $testResults.TestRun.ResultSummary.Counters.total
        $VOTO1 = ($VOTO_MASSIMO-$VOTO_MINIMO)*$VOTO+$VOTO_MINIMO
        return "{0:N1}" -f $VOTO1
    }
    return "{0:N1}" -f $VOTO_MINIMO
}

function Get-StatoCompito {

    [CmdletBinding()]
    param( $testResults, $compitoInRitardo )

    if( $compitoInRitardo ) {
        $statoDelCompito = "Too late"
    }
    else {
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

    return $statoDelCompito
}