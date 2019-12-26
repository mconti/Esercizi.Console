#Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $Test_Color
#Write-Host "--logger:" ""trx;LogFileName=.//logFile.trx""
$part0="./dire/"
$part1 = "--logger:"+'"'+"trx;"+$part0+"LogFileName=.//logFile.trx"+'"'
$part3="trx;LogFileName=.//logFile.trx"
Write-Host $part1

 

if ( $PSVersionTable.Platform -eq "Unix" )
{
    Write-Host "OK"
}

#Crea file HTML
Get-Alias | ConvertTo-Html | Out-File aliases.htm
#Invoca navigatore 
Invoke-Item aliases.htm

#Crea file csv
Get-Process | Export-Csv -Path .\Processes.csv -NoTypeInformation
#Mostra il file generato
Get-Content -Path .\Processes.csv