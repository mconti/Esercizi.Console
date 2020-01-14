
$Url = "https://docs.google.com/spreadsheets/d/1W0sucmYZl4gDoC-71C2BxgxVwagTaNT7pFle_nbl3i0/export?format=csv"
Invoke-WebRequest -Uri $Url -OutFile "filename.csv"
$dati_csv = Import-CSV "filename.csv"

$Progetti = New-Object System.Collections.ArrayList
foreach( $p in $dati_csv )
{
    if( $p.Nome3H -ne "" -and $p.Data3H -ne "" ){
        $progetto = @{
            Nome = $p.Nome3H
            Dal = (Get-Date $p.Data3H)
            Al = (Get-Date $p.Data3H).AddHours(3)
            Minimo = 4
            Massimo = 9
        }                                    
        
        $risultato = New-Object PSObject -Property $progetto 
        $Progetti.Add($risultato) | Out-Null
    }
}

$Progetti | Format-Table
