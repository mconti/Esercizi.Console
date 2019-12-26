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

    # Include 
    . ($ScriptDirectory + "\settings\" + $CLASSE + "-" + $MATERIA + ".ps1")
    . ($ScriptDirectory + "\settings\" + "global.ps1")

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

    $attuale = Get-Location 

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

                        # Crea la directory di destinazione pulita
                        New-Item -ItemType Directory -Path $PRJ_DEST_DIR\$alunno -Force | Out-Null
                        
                        # Dezippa il file nella destinazione
                        Expand-Archive -LiteralPath $SOURCE -DestinationPath $PRJ_DEST_DIR\$alunno -Force
                    
                        # Cerca il .csproj
                        $sorgenteConPath = Get-ChildItem -Path $PRJ_DEST_DIR\$alunno -Filter ("*.csproj") -Recurse -ErrorAction SilentlyContinue -Force

                        # Se non lo trovo, segnalo in giallo
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

                            # Cerca la sln
                            $fileSln = Get-ChildItem -Path $PRJ_DEST_DIR -Filter ("*.sln") -ErrorAction SilentlyContinue -Force
                            if( $fileSln -eq $null ){
                                dotnet new sln -n $PROGETTO 
                                #Write-host ("Creo sln... ") -ForegroundColor $Test_Color
                            }

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

                            if( $? ){
                                New-Item -ItemType directory -Path ($PRJ_DEST_DIR + "\" + $alunno + "\TestResults")
                                # Lancia i test generando i file .trx
                                #$loggerParam = "--logger:"+'"'+"trx;LogFileName=" + ($PRJ_DEST_DIR + "\" + $alunno + "\logFile.trx") + '"'
                                #$loggerParam = "--logger html"
                                $loggerParam = "--logger:"+'"'+"trx" + '"'
                                dotnet test $csprojectFile -s ($PRJ_DEST_DIR + "\" + $alunno + "\test.runsettings") $loggerParam
                                
                                $loggerParam = "--logger:"+'"'+"html" + '"'
                                dotnet test $csprojectFile -s ($PRJ_DEST_DIR + "\" + $alunno + "\test.runsettings") $loggerParam

                                # Aggiunge il nuovo .csproj alla solution
                                dotnet sln ($PROGETTO + ".sln") add $csprojectFile
                                #dotnet test $sorgenteConPath
                            }
                        }
                        
                        #Write-host ("{0}" -f $tutti_i_file_estratti) -ForegroundColor $TooLateNotAccepted_Color
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

    Print-Footer

    Set-Location -Path $attuale
}
