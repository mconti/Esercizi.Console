#Write-host ("{0}{1}$TAB({2})" -f (Get-ChildItem $SOURCE).BaseName, (Get-ChildItem $SOURCE).Extension, (Get-ChildItem $SOURCE).LastWriteTime) -ForegroundColor $Test_Color
#Write-Host "--logger:" ""trx;LogFileName=.//logFile.trx""
$part0="./dire/"
$part1 = "--logger:"+'"'+"trx;"+$part0+"LogFileName=.//logFile.trx"+'"'
$part3="trx;LogFileName=.//logFile.trx"
Write-Host $part1
