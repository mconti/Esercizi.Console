#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#
# general purpose funcions and utility
#

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
}

#
# 
#
function Ritira-Compito {
    param( [string]$CLASSE, [string]$MATERIA, [string]$PROGETTO )

    # Impone che stia girando PWSH
    #Requires -PSEdition Core

    if ( $PSVersionTable.Platform -eq "Unix" )
    {
        # path macbook
        Write-Host "Sono su mac"
        $ROOT="/Volumes/GoogleDrive/Il mio Drive/Classroom"
        $ROOT_DESTINAZIONE="/Users/maurizio/Desktop/"
    }
    else 
    {
        Write-Host "Sono su windows"
        # path windows10 casa mia
        $ROOT="D:\Il mio Drive\Classroom"
        $ROOT_DESTINAZIONE="C:\Users\posta\Desktop\"
    }

    # Include 
    . ($ScriptDirectory + "\settings\" + $CLASSE + "-" + $MATERIA + ".ps1")
    . ($ScriptDirectory + "\settings\" + "global.ps1")
    . ($ScriptDirectory + "\lib\" + "Write-PSObject.ps1")

    #
    # main
    #
    $numeroAlunni=0
    $numeroFile=0
    $numeroFileFuoriTempo=0

    Print-Header 

    # Cancella la vecchia directory 
    if ((Test-Path $PRJ_DEST_DIR) -eq $true) {
        Remove-Item -LiteralPath $PRJ_DEST_DIR -Force -Recurse
    }

    # Memorizza la posizone della PATH attuale (alla fine la recupera)
    $attuale = Get-Location 
    
    # Risultati
    $Risultati = New-Object System.Collections.ArrayList

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
                # Crea la directory di destinazione pulita
                New-Item -ItemType Directory -Path $PRJ_DEST_DIR\$alunno -Force | Out-Null
                
                # Dezippa il file nella destinazione
                Expand-Archive -LiteralPath $SOURCE -DestinationPath $PRJ_DEST_DIR\$alunno -Force
            
                # Cerca il .csproj
                $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force

                # Se non lo trovo, segnalo in rosso
                if( $sorgenteConPath -eq $null ){
                    Write-host ("Manca .csproj {0}" -f (Get-ChildItem $sorgenteConPath)) -ForegroundColor $TooLateAccepted_Color
                }
                else {
                    # Copia i file nella giusta posizione
                    # per sistemare quelli che hanno consegnato in directory annidate  
                    $tutti_i_file_estratti = (Split-Path $sorgenteConPath) + "\*.*"
                    $destinazione = $PRJ_DEST_DIR + "\" + $alunno

                    Move-Item -Path $tutti_i_file_estratti -Destination $destinazione
                
                    # Cancella la vecchia directory 
                    Remove-Item -LiteralPath (Split-Path $sorgenteConPath)  -Force -Recurse

                    Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $OK_Color

                    Set-Location -Path $PRJ_DEST_DIR

                    # Crea la solution se manca
                    #$fileSln = Get-ChildItem -Path $PRJ_DEST_DIR -Filter ("*.sln") -ErrorAction SilentlyContinue -Force
                    #if( $fileSln -eq $null ){
                    #    dotnet new sln -n $PROGETTO 
                    #    #Write-host ("Creo sln... ") -ForegroundColor $Test_Color
                    #}

                    # Cerca il .csproj nella nuova posizione 
                    # e gli da il nome dell'alunno 
                    $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    Rename-Item -Path $sorgenteConPath -NewName ($alunno + ".csproj.old")

                    # Copia nella dir, il csproj per i test
                    $csprojFile = ($ScriptDirectory + "\resource\csproj\v1.csproj")
                    Copy-Item -Path $csprojFile -Destination ($PRJ_DEST_DIR + "\" + $alunno + "\" + $alunno + ".csproj")
                    
                    # Copia nella dir, il runsettings per i test
                    $runSettingFile = ($ScriptDirectory + "\resource\runsettings\test.runsettings")
                    Copy-Item -Path $runSettingFile -Destination $PRJ_DEST_DIR\$alunno

                    # Lancia il build
                    $csprojectFile = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force
                    Write-host ("Progetto " + $csprojectFile) -ForegroundColor $Test_Color
                    dotnet build $csprojectFile

                    # se &? è true, il comando è riuscito
                    if( $? ){
                        
                        # Crea la cartella dei risultati di test
                        New-Item -ItemType directory -Path ($PRJ_DEST_DIR + "\" + $alunno + "\TestResults")
                        
                        # Lancia i test generando i file html
                        $loggerParam = "--logger:"+'"'+"html" + '"'
                        dotnet test $csprojectFile -s ($PRJ_DEST_DIR + "\" + $alunno + "\test.runsettings") $loggerParam
                        
                        # Cerca il file html e lo rinomina cognome.nome.gli da il nome dell'alunno 
                        $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.html") -Recurse -ErrorAction SilentlyContinue -Force
                        if( $sorgenteConPath -ne $NULL ) {
                            Rename-Item -Path $sorgenteConPath -NewName ( $alunno + "." + $CLASSE + "." + $PROGETTO + ".html")
                        }

                        # Lancia i test generando il file .trx
                        #$loggerParam = "--logger:"+'"'+"trx;LogFileName=" + ($PRJ_DEST_DIR + "\" + $alunno + "\logFile.trx") + '"'
                        #$loggerParam = "--logger html"
                        $loggerParam = "--logger:"+'"'+"trx" + '"'
                        dotnet test $csprojectFile -s ($PRJ_DEST_DIR + "\" + $alunno + "\test.runsettings") $loggerParam

                        # parse del file trx 
                        $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.trx") -Recurse -ErrorAction SilentlyContinue -Force
                        if( $sorgenteConPath -ne $NULL ) {
                            [xml]$testResults = Get-Content -Path $sorgenteConPath

                            if( $compitoInRitardo ) {
                                $statoDelCompito = "Too late"
                            }
                            else {
                                $statoDelCompito = $testResults.TestRun.ResultSummary.outcome
                            }

                            $tr = @{
                                Alunno       = $alunno
                                Classe       = $CLASSE
                                Consegna     = $strDataConsegna
                                Scadenza     = $strDataScadenza
                                Progetto     = $PROGETTO
                                Materia      = $MATERIA
                                Risultato    = $statoDelCompito
                                Quanti       = $testResults.TestRun.ResultSummary.Counters.total
                                Passati      = $testResults.TestRun.ResultSummary.Counters.passed
                                Falliti      = $testResults.TestRun.ResultSummary.Counters.failed
                                Errori       = $testResults.TestRun.ResultSummary.RunInfos.RunInfo.outcome
                                Timeout      = $TestRun.ResultSummary.Counters.timeout
                            }                                    
                            $risultato = New-Object PSObject -Property $tr 
                            $Risultati.Add($risultato) | Out-Null
                            #$Risultati

                            #  Set-Location -Path $attuale
                            #  return
                        }
                        
                        # decommentare per aggiungere  il nuovo .csproj alla solution
                        #dotnet sln ($PROGETTO + ".sln") add $csprojectFile
                    }
                    else{
                        # Il compito non si compila
                        Write-host ( "{0}{1}$TAB({2})$TAB({3})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime, (Get-ChildItem $SOURCE).Length) -BackgroundColor $Wrong_Color
                        $tr = @{
                            Alunno       = $alunno
                            Classe       = $CLASSE
                            Consegna     = $strDataConsegna
                            Scadenza     = $strDataScadenza
                            Progetto     = $PROGETTO
                            Materia      = $MATERIA
                            Risultato    = "Not compiled"
                            Quanti       = "0"
                            Passati      = "0"
                            Falliti      = "0"
                            Errori       = "0"
                            Timeout      = "0"
                        }
                        $risultato = New-Object PSObject -Property $tr 
                        $Risultati.Add($risultato) | Out-Null
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
                    Classe       = $CLASSE
                    Consegna     = $strDataConsegna
                    Scadenza     = $strDataScadenza
                    Progetto     = $PROGETTO
                    Materia      = $MATERIA
                    Risultato    = "Too big"
                    Quanti       = "0"
                    Passati      = "0"
                    Falliti      = "0"
                    Errori       = "0"
                    Timeout      = "0"  
                }
                $risultato = New-Object PSObject -Property $tr 
                $Risultati.Add($risultato) | Out-Null
            }

            $numeroFile++
        } 
        else {
            # Compito non trovato
            write-host ("{0}" -f $SOURCE_FILE) -foreground $Wrong_Color

            $tr = @{
                Alunno       = $alunno
                Classe       = $CLASSE
                Consegna     = $strDataConsegna
                Scadenza     = $strDataScadenza
                Progetto     = $PROGETTO
                Materia      = $MATERIA
                Risultato    = "Not found"
                Quanti       = "0"
                Passati      = "0"
                Falliti      = "0"
                Errori       = "0"
                Timeout      = "0"
            }
            $risultato = New-Object PSObject -Property $tr 
            $Risultati.Add($risultato) | Out-Null
        }
    }

    # Esporta CSV
    $Risultati | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Quanti, Passati, Falliti, Errori, Timeout |  `
    Export-Csv -Path ($PRJ_DEST_DIR + "\" + $CLASSE + "." + $PROGETTO + ".csv") -NoTypeInformation
    
    #$Risultati | Format-Table Classe, Progetto, Alunno, Consegna, Scadenza, Risultato, Passati, Quanti
    #Write-PSObject ($Risultati | Select-Object -Property Classe, Progetto, Alunno, Scadenza, Risultato, Passati, Quanti) -MatchMethod Exact -Column Risultato -Value "Not found" -ValueForeColor Red -FlagColumns "'Alunno'" -FlagsForeColor Red;

    # Visualizza a video...    
    Write-PSObject ($Risultati | Select-Object -Property Classe, Progetto, Consegna, Scadenza, Alunno, Risultato, Quanti, Passati, Falliti, Errori, Timeout) `
    -MatchMethod Exact, Exact, Exact, Exact, Exact, Exact `
    -Column 'Risultato', 'Risultato', 'Risultato', 'Risultato', 'Risultato', 'Risultato' `
    -Value "Not found", "Too late", "Too big", "Not compiled", "Failed", "Completed"  `
    -ValueForeColor Red, Yellow, Red, Red, Yellow, Green `
    -FlagColumns 'Alunno', 'Alunno', 'Alunno', 'Alunno', 'Alunno', 'Alunno' `
    -FlagsForeColor Red, Yellow, Red, Red, Yellow, Green 

    Set-Location -Path $attuale
}
