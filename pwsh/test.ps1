#Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $Test_Color
#Write-Host "--logger:" ""trx;LogFileName=.//logFile.trx""
#$part0="./dire/"
#$part1 = "--logger:"+'"'+"trx;"+$part0+"LogFileName=.//logFile.trx"+'"'
#$part3="trx;LogFileName=.//logFile.trx"
#Write-Host $part1

Remove-Item 'C:\Users\posta\Desktop\CONSEGNATI\4H\Informatica\Serie\19122412\Alessi.Lorenzo\2\3\Microsoft\Windows\Start Menu' -Recurse -Force -ErrorAction Continue

#Get-ChildItem -Path 'C:\Users\posta\Desktop\CONSEGNATI\4H\Informatica\Serie\19122412\Alessi.Lorenzo\2\3\Microsoft\Windows\Start Menu' -Recurse -Force |
#orEach-Object -Process {
#$ACL = Get-Acl -Path $PSItem.FullName
#Set-Acl -Path $PSItem.FullName -AclObject $ACL
 
#Set-NTFSOwner -Account 'posta' -Path $PSItem.FullName
 
#Clear-NTFSAccess -Path $PSItem.FullName
 
#Enable-NTFSAccessInheritance -Path $PSItem.FullName
#}
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
