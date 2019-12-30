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
    LOCAL = "INFO 4H 2019_2020 4H"


    # Elenco alunni
    #ALUNNI = @( "Dhamo.Aleksander", "Giorgetti.Alessio", "Goci.Erdi")
    
    ALUNNI = @( "Alessandri.Giacomo", "Alessi.Lorenzo", "Bianchi.Denise", "Busi.Alessandro", "Cavalli.Sarah", 
    "Cecchetti.Mattia", "Cesarini.Filippo", "Dhamo.Aleksander", "Giorgetti.Alessio", "Goci.Erdi",
    "Lombardi.Giacomo", "Marazzi.Kevin", "Mingrone.Lorenzo", "Mitrotti.Francesco", "Montanari.Giorgia", "Nasini.Michele", 
    "Pasquinelli.Martina", "Placucci.Gabriele", "Semproli.Mattia", "Shepilov.Nikita", "Tombini.Jacopo", "Zaghini.Mattia", "Zavatta.Lorenzo"
    )
    
}                                    
$CLASSE = New-Object PSObject -Property $classe_obj 

# Elenco progetti
function Progetti {
    [PSCustomObject]@{ Nome='Grani';Dal="19/11/2019 8:00:00";Al="19/11/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Nanp';Dal="26/11/2019 8:00:00";Al="26/11/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Acronimo';Dal="27/11/2019 8:00:00";Al="27/11/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Alfabeto';Dal="3/12/2019 8:00:00";Al="3/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Scramble';Dal="4/12/2019 8:00:00";Al="4/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='ScrambleDictionary';Dal="5/12/2019 8:00:00";Al="5/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='CambioCodice';Dal="10/12/2019 8:00:00";Al="10/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Media';Dal="10/12/2019 8:00:00";Al="10/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Somma';Dal="11/12/2019 8:00:00";Al="11/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Eta';Dal="17/12/2019 8:00:00";Al="17/12/2019 14:00:00";Minimo=4;Massimo=9}
    [PSCustomObject]@{ Nome='Serie';Dal="18/12/2019 8:00:00";Al="18/12/2019 14:00:00";Minimo=4;Massimo=9}

}




