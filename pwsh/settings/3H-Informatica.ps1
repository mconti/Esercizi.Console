#
# Power Shell Core script for exercises management
# posta@maurizioconti.com - december 2019
#
# class definition
#
$classe_obj = @{

    NOME = $NOME_CLASSE
    MATERIA = $MATERIA

    # Path alla cartella della classe classroom
    LOCAL = "3H-201920"

    # Elenco alunni
    #ALUNNI = @( "Bertozzi.Mattia", "Bianchi.Monica" )

    ALUNNI = @( 
        "Agyiri.Godfred", "Amadori.Alan", "Amantini.Davide", "Amantini.Federico", "Bahri.Yassine", "Bartolini.Liam", "Battafarano.Giovanni",
        "Bertozzi.Mattia", "Bianchi.Monica", "Bronzetti.Christian", "Caralli.Fabio", "Carnevali.Nicola", 
        "Casadei.Samuele", "Curzi.Lorenzo", "Farneti.Michele", "Lu.William", "Mancini.Nicola", "Mari.Diego", "Mazzoni.Alex", 
        "Menghi.Massimo", "Paz.Eyal", "Qordja.Francesco.Petrit", 
        "Santarsieri.Andrea", "Santi.Federico", "Spaccamiglio.Luca"
    )
}                                    
$CLASSE = New-Object PSObject -Property $classe_obj 

# Elenco progetti
function Progetti {
    [PSCustomObject]@{ Nome='Collatz';Dal="27/11/2019 8:00:00";Al="27/11/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Fibonacci';Dal="4/12/2019 8:00:00";Al="4/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='MediaStream';Dal="4/12/2019 8:00:00";Al="4/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='NumeroStream';Dal="3/12/2019 8:00:00";Al="3/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Spazio';Dal="11/12/2019 8:00:00";Al="11/12/2019 14:00:00";Minimo=4;Massimo=9}
}




