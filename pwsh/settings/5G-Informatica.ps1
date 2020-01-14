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
    LOCAL = "5G INFORMATICA 1920"

    # Path alla cartella con tutti gli esercizi originali
    PATH_ESERCIZI = "$ROOT_ESERCIZI/5G-Informatica/Esercizi/Zip"

    # Path alla cartella con tutti i risultati
    PATH_RISULTATI = "$ROOT_ESERCIZI/5H-Informatica/Esercizi/Risultati"

    # Elenco alunni
    ALUNNI = @( "bartoletti.jacopo", "Bartolini.Federico", "benvenuti.giacomo", "biava.davide", "borriello.sasha", "buscarini.aron", "botticelli.diego", "creatore.federico", "fantini.alessandro", "farruggio.giorgia", "innocenti.giacomo", "koci.erik", "lando.alex", "Libofsha.Denis", "Mascella.Nicolo", "montanari.nicola", "para.alessandro", "righi.samuele", "semprini.gabriel", "sutera.matteo", "tagliani.lorenzo", "ugolini.francesco", "verde.valeria", "xiang.yang")
}                                    
$CLASSE = New-Object PSObject -Property $classe_obj 