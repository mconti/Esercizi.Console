
#Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $Test_Color
#Write-Host "--logger:" ""trx;LogFileName=.//logFile.trx""
#$part0="./dire/"
#$part1 = "--logger:"+'"'+"trx;"+$part0+"LogFileName=.//logFile.trx"+'"'
#$part3="trx;LogFileName=.//logFile.trx"
#Write-Host $part1

# composizione di stringhe che contengono caratteri speciali
$part0="./dire/"
$part1 = "--logger:"+'"'+"trx;"+$part0+"LogFileName=.//logFile.trx"+'"'
$part3="trx;LogFileName=.//logFile.trx"
Write-Host $part1

 
#
# verifica della piattaforma
#if ( $PSVersionTable.Platform -eq "Unix" ) {
#    Write-Host "OK"
#}

#
#Crea file HTML
#Get-Alias | ConvertTo-Html | Out-File aliases.htm

#
#Invoca navigatore 
#Invoke-Item aliases.htm

#
#Crea file csv
#Get-Process | Export-Csv -Path .\Processes.csv -NoTypeInformation

#
#Mostra il file generato
#Get-Content -Path .\Processes.csv

$testResults = [xml](get-content ".\ok-6-su-10.trx")

$testResult = @{
    Alunno       = $alunno
    Classe       = $CLASSE
    Data         = $DATA
    Scadenza     = $VALIDITA_AL
    Progetto     = $PROGETTO
    Materia      = $MATERIA
    Risultato    = $testResults.TestRun.ResultSummary.outcome
    TestNumero   = $testResults.TestRun.ResultSummary.Counters.total
    TestPassati  = $testResults.TestRun.ResultSummary.Counters.passed
    TestFalliti  = $testResults.TestRun.ResultSummary.Counters.failed
    TestErrori   = $testResults.TestRun.ResultSummary.Counters.error
    TestTimeout  = $TestRun.ResultSummary.Counters.timeout
}


#$testResults.TestRun.ResultSummary
#($testResults.TestRun.ResultSummary.outcome + ";" + 
# $testResults.TestRun.ResultSummary.Counters.total + ";" + 
# $testResults.TestRun.ResultSummary.Counters.passed + ";" + 
# $testResults.TestRun.ResultSummary.Counters.failed + ";" + 
# $testResults.TestRun.ResultSummary.Counters.error + ";" + 
# $testResults.TestRun.ResultSummary.Counters.timeout)
 
$risultatoFinale = New-Object PSObject -Property $testResult 
$risultatoFinale


# Esempi di formattazione con Write-PSObject
# includo la funzione...
. ("..\lib\" + "WrIte-PSObject.ps1")

# Lavoro su un file csv prodotto in precedenza
$Risultati = Import-Csv -Path ..\resource\TestResults\4h.Grani.csv

#Write-PSObject ($Risultati | Select-Object -Property Classe, Alunno, Scadenza, Progetto, Risultato, TestPassati, TestNumero) `
#-MatchMethod Exact -Column Risultato -Value "Not found" -ValueForeColor Red -FlagColumns "'Alunno'" -FlagsForeColor Red;

Write-PSObject ($Risultati | Select-Object -Property Classe, Progetto, Alunno, Consegna, Scadenza, Risultato, Quanti, Passati, Falliti, Errori, Timeout) `
-MatchMethod Exact, Exact, Exact, Exact `
-Column 'Risultato', 'Risultato', 'Risultato', 'Risultato' `
-Value "Not found", "Not compiled", "Failed", "Completed"  `
-ValueForeColor Red, Red, Yellow, Green `
-FlagColumns 'Alunno', 'Alunno', 'Alunno', 'Alunno' `
-FlagsForeColor Red, Red, Yellow, Green 

# Lavoro sui dati degli esempi di Write-PSObject
#region XML Data Sample 
$xml = [XML] "<Servers><Server SN='01' Server='SPWFE01' IP='192.168.0.10' Manufacture='HP' MemoryMB='32768' FreeMemoryMB= '10240' CPUCores='8' HyperThreading='False' Virtualization='Disabled' HyperVSupport='True' /><Server SN='02' Server='SPWFE02' IP='192.168.1.3' Manufacture='Dell' MemoryMB='32768' FreeMemoryMB= '30720' CPUCores='8' HyperThreading='True' Virtualization='Disabled' HyperVSupport='True' /><Server SN='03' Server='SPWFE03' IP='192.168.0.22' Manufacture='HP' MemoryMB='32768' FreeMemoryMB= '510' CPUCores='8' HyperThreading='True' Virtualization='Disabled' HyperVSupport='False' /><Server SN='04' Server='SQLPR01' IP='192.168.1.5' Manufacture='HP' MemoryMB='65536' FreeMemoryMB= '5120' CPUCores='16' HyperThreading='True' Virtualization='Enabled' HyperVSupport='True' /><Server SN='05' Server='SQLMI01' IP='192.168.1.6' Manufacture='Dell' MemoryMB='65536' FreeMemoryMB= '6420' CPUCores='16' HyperThreading='False' Virtualization='Enabled' HyperVSupport='True' /></Servers>"; 
$servers = [PSObject[]] $xml.Servers.Server  | Select SN, Server, IP, Manufacture, MemoryMB, FreeMemoryMB, CPUCores, HyperThreading, Virtualization, HyperVSupport; 
#endregion XML Data Sample
Write-PSObject $servers -MatchMethod Query, Query -Column "FreeMemoryMB", "FreeMemoryMB"  -Value "(('MemoryMB' - 'FreeMemoryMB') / 'MemoryMB') * 100 -LT 95 -And (('MemoryMB' - 'FreeMemoryMB') / 'MemoryMB') * 100 -GT 90", "(('MemoryMB' - 'FreeMemoryMB') / 'MemoryMB') * 100 -gt 95" -ValueForeColor Yellow, Red -FlagColumns "'SN', 'Server', 'MemoryMB'", "'SN', 'Server', 'MemoryMB'" -FlagsForeColor Yellow, Red -ColoredColumns Virtualization, HyperVSupport -ColumnForeColor Green, Magenta;

$DataMia=Get-Date

$STR_DATA_COMPITO=Get-Date $DataMia -format "dd/MM hh:mm"
$STR_DATA_COMPITO


$GIORNI_VALIDITA_PRECEDENTI = 38
$ORE_VALIDITA_PRECEDENTI = 1

$STR_DATA_COMPITO=(Get-Date).DateTime

# Data del compito in formato directory di Archiviazione per CercoPiteko
#$DATA=(Get-Date $STR_DATA_COMPITO -format dd)+(Get-Date $STR_DATA_COMPITO -format MM)+(Get-Date $STR_DATA_COMPITO -format yy)+(Get-Date $STR_DATA_COMPITO -format HH)
$DATA=(Get-Date $STR_DATA_COMPITO -format yy)+(Get-Date $STR_DATA_COMPITO -format MM)+(Get-Date $STR_DATA_COMPITO -format dd)+(Get-Date $STR_DATA_COMPITO -format HH)

# $VALIDITA_DAL=(Get-Date "10/5/2016 8:00:00")
# $VALIDITA_AL=(Get-Date "10/05/2016 12:00:00")
$VALIDITA_DAL=(Get-Date $STR_DATA_COMPITO).AddDays(-$GIORNI_VALIDITA_PRECEDENTI).AddHours(-$ORE_VALIDITA_PRECEDENTI)
$VALIDITA_AL=(Get-Date $STR_DATA_COMPITO).AddDays(1)

$VALIDITA_DAL
$VALIDITA_AL

$DataConsegna = (Get-Date "26/11/2019")
if( ($DataConsegna -gt $VALIDITA_DAL) -and ($DataConsegna -lt $VALIDITA_AL) ) {
    $compitoInRitardo = $false
}
else {
    $compitoInRitardo = $true
    $numeroFileFuoriTempo++
}

$compitoInRitardo