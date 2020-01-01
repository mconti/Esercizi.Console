# Esercizi.Console

Repository utilizzato nelle esercitazioni di laboratorio di C#.

Ogni cartella contiene un esercizio con tre file: 

*NomeEsercizio.cs*  l'esercizio da svolgere...

*NomeEsercizioTest.cs* che contiene le unit test da superare. Questo file non va alterato in alcun modo. 

*NomeEsercizio.csproj* che contiene le dipendenze necessarie alla compilazione come le librerie standard di .NET o ad esempio le librerie XUnit per eseguire le unit test.  

# Utilizzo

- Scaricare uno di questi zip

| Nome esercizio | Descrizione |
|----|--|
| [grani](http://bit.ly/2QCgO0r)                  | Conta i chicchi di grano su una schacchiera 8x8                                                              |
| [collatz](http://bit.ly/collatz19)              | Verifica la congettura di Collatz 3*N+1                                                                      |
| [NANP](http://bit.ly/NANP19)                    | Verifica se una stringa è conforme al NAtional Numbers Plan americano                                        |
| [acronimo](http://bit.ly/acronimo19)            | Data una frase di n parole, ritorna l'iniziale di ogni parola.                                               |
| [Alfabeto](http://bit.ly/2P3tYCO)               | Verifica che una frase contenga tutte le lettere dell'alfabeto italiano                                      |
| [pesoLettere](http://bit.ly/2L3PwOn)            | Ogni lettera ha un peso. Calcolare il peso di una parola.                                                    |
| [stream](http://bit.ly/2DCPXv2)                 | Legge una riga da un file, estrae due numeri, visualizza il secondo                                          |
| [mediaPesata](http://bit.ly/2DGaXkC)            | Legge 3 file.txt e calcola la media pesata dei numeri che contengono                                         |
| [rna](http://bit.ly/38gy9UJ)                    | Converte una sequenza di DNA in RNA                                                                          |
| [space-age](http://bit.ly/36iIKwr)              | Calcola l'età di una persona con 1.000.000.000 di secondi sulla terra e se vivesse sugli altri pianeti       |
| [sum-of-multiplies](http://bit.ly/35aLN9K)      | Calcola la somma dei multipli di una serie di numeri                                                         |
| [series](http://bit.ly/2PtSgaB)                 | Slice di N caratteri da una stringa                                                                          |
| [largest-series-product](http://bit.ly/2rX8znj) | Slice di N caratteri e moltiplicazione tra loro delle cifre. Es. "1027839564",  =  270 (9 * 5 * 6)           |
| [gocce](http://bit.ly/36mNFx3)                  | Se tra i fattori di un numero esiste 3,5,7, produce Pling, Plang, Plong                                      |
| [punteggio](http://bit.ly/35drDuY)              | Dato un array di interi, tornare i tre più grandi, il più grande, l'ultimo inserito...                       |
| [perfetto](http://bit.ly/2QcIgTq)               | Se la somma dei fattori di un numero (escluso il numero) è uguale al numero, si tratta di un numero perfetto |
| [bisestile](http://bit.ly/2ZG3WdW)              | Determinare se un anno è bisestile                                                                           |
| [armstrong](http://bit.ly/2QdsSq3)              | Determinare se un numero dato è un numero di Armstrong                                                       |
| [isogramma](http://bit.ly/37vnEf7)              | Determinare se una parola o una frase sia un isogramma (formata da lettere non ripetute)                     |


- dezippare il file sul desktop (Mac, Windows, Linux)
- rinominare la cartella usando questa convenzione **cognome.nome.classe.NomeEsercizio** dove classe di solito è formata da due caratteri (3H, 4H, 5G, ...) ad esempio **conti.maurizio.4H.acronimo**
- aprire la cartella con VS Code e puntare al file **NomeEsercizio.cs** risolvendolo
- aprire un terminale ed eseguire **dotnet test** finchè tutti i test non sono passati.
- zippare la cartella in un file **nome.cognome.classe.NomeEsercizio.zip** e consegnarla con google classroom 


