$dati = Import-Csv "./4H.CambioCodiceOK.csv"
$dati | Get-Unique | Format-Table
$output = $dati | Group-Object -Property Hash | Where-Object {$_.Count -gt 1}
$output = $output | Select-Object -Property Group
$output = $output[0] | ForEach-Object


$output | Format-List

#$dati = Import-Csv "./3H.MediaStream-hash.csv"
#$dati | Get-Unique | Format-Table

#$risultati = New-Object System.Collections.ArrayList
#$risultati = $dati | Select-Object –Unique
#Compare-object –referenceobject $risultati –differenceobject $dati
#$dati | Group-Object | Where-Object { $_.Count -gt 1 } | Select -ExpandProperty Hash
 
#$risultati | Format-Table

#$Names = @{}
#foreach($row in $dati) {
#    $Names[$_.Hash] += 1
#}
#Write-Output ($Names.GetEnumerator() | Where-Object{ $_.Value -gt 1 })

#$a = $dati
#$b = @()
#$c = @()
#$a | ForEach-Object {
#    if ($c -notcontains $_.DisplayName) {
#        $b += $_;
#        $c += $_.DisplayName
#    }
#}

#$b | Format-Table
#$c | Format-Table