
#$csTestAlunno = Get-ChildItem -Path "./" -Filter ("*.*")  -ErrorAction SilentlyContinue -Force
$file = Get-ChildItem -Path "/Users/maurizio/Desktop/Consegnati/3H/Informatica/MediaStream/20010614/Bertozzi.Mattia"

foreach( $file in $file )
{
    $h = (Get-FileHash $file -Algorithm MD5).Hash
    $nomeFile = [System.IO.Path]::GetFileName($file)

    Write-Host "$nomeFile - $h"
}

Write-Host "---"
$file = Get-ChildItem -Path "./Prove/mediaPesataTest1.cs"
$h = (Get-FileHash $file -Algorithm MD5).Hash
$nomeFile = [System.IO.Path]::GetFileName($file)
Write-Host $nomeFile + "-" $h -foreground "Yellow"
