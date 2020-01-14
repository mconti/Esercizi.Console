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
    LOCAL = "FANS-Lab"

    # Path alla cartella con tutti gli esercizi originali
    PATH_ESERCIZI = "$ROOT_ESERCIZI/Fab-Informatica/Esercizi/Zip"

    # Path alla cartella con tutti i risultati
    PATH_RISULTATI = "$ROOT_ESERCIZI/Fab-Informatica/Esercizi/Risultati"

    # Elenco alunni
    ALUNNI = @( "tarozzi.ivan", "montanari.roberto", "sarr.alle", "conti.maurizio", "savini.edoardo"
    )
}                                    
$CLASSE = New-Object PSObject -Property $classe_obj 