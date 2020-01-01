# Esercizi.Console

Repository utilizzato nelle esercitazioni di laboratorio di C#.

Ogni cartella contiene un esercizio con tre file: 

*NomeEsercizio.cs*  l'esercizio da svolgere...

*NomeEsercizioTest.cs* che contiene le unit test da superare. Questo file non va alterato in alcun modo. 

*NomeEsercizio.csproj* che contiene le dipendenze necessarie alla compilazione come le librerie standard di .NET o ad esempio le librerie XUnit per eseguire le unit test.  

# Utilizzo

- Scaricare uno di questi zip

| Nome esercizio | Descrizione | Difficoltà |
|--|--|--|
| [bisestile](http://bit.ly/2ZG3WdW) | Determinare se un anno è bisestile | *molto semplice*, divisore con resto % |
| [space-age](http://bit.ly/36iIKwr) | Calcola l'età di una persona con 1.000.000.000 di secondi sulla terra (e se vivesse su altri pianeti?) | *molto semplice*, double |
|   |   |   |
| [grani](http://bit.ly/2QCgO0r) | Conta i chicchi di grano su una scacchiera 8x8 | *semplice*, int, for semplice |
| [collatz](http://bit.ly/collatz19) | Verifica la congettura di Collatz 3*N+1 | semplice, int, for semplice |
| [acronimo](http://bit.ly/acronimo19) | Data una frase di n parole, ritorna l'iniziale di ogni parola. | semplice, string, for semplice, Split() |
| [Alfabeto](http://bit.ly/2P3tYCO) | Verifica che una frase contenga tutte le lettere dell'alfabeto italiano | semplice, string, for semplice, Contains(char) |
| [pesoLettere](http://bit.ly/2L3PwOn) | Ogni lettera ha un peso. Calcolare il peso di una parola. | semplice, Dictionary, foreach |
| [rna](http://bit.ly/38gy9UJ) | Converte una sequenza di DNA in RNA | semplice, trasforma string, for semplice, IndexOf |
| [series](http://bit.ly/2PtSgaB) | Slice di N caratteri da una stringa | semplice, string, for semplice, Substring |
|   |   |   |
| [NANP](http://bit.ly/NANP19) | Verifica se una stringa è conforme al NAtional Numbers Plan americano | normale, array, string, for semplice, IsDigit |
| [stream](http://bit.ly/2DCPXv2) | Legge una riga da un file, estrae due numeri, visualizza il secondo | normale, primo esercizio che legge da file con StreamReader() |
| [mediaPesata](http://bit.ly/2DGaXkC) | Legge 3 file.txt e calcola la media pesata dei numeri che contengono  | normale, double, StreamReader, File CSV, Split() |
| [gocce](http://bit.ly/36mNFx3) | Se tra i fattori di un numero esiste 3,5,7, produce Pling, Plang, Plong | normale, medio se usi for. divisione con resto % |
| [punteggio](http://bit.ly/35drDuY) | Dato un array di interi, tornare i tre più grandi, il più grande, l'ultimo inserito... | normale, facile con LINQ, int, array, serve un Sort |
| [armstrong](http://bit.ly/2QdsSq3) | Determinare se un numero dato è un numero di Armstrong | normale, string, char, double, for semplice, Math.Pow()  |
|   |   |   |
| [sum-of-multiplies](http://bit.ly/35aLN9K) | Calcola la somma dei multipli di una serie di numeri   | medio, int, array, for annidato, valori distinti  |
| [largest-series-product](http://bit.ly/2rX8znj) | Slice di N caratteri e moltiplicazione tra loro delle cifre. Es. "1027839564",  =  270 (9 * 5 * 6) | medio, string, for annidato, Substring(), IsNumber(), evoluzione di  Series |
| [perfetto](http://bit.ly/2QcIgTq) | Se la somma dei fattori di un numero (escluso il numero) è uguale al numero, si tratta di un numero perfetto | medio, array, Enum, cerca fattori |
| [isogramma](http://bit.ly/37vnEf7) | Determinare se una parola o una frase sia un isogramma (formata da lettere non ripetute) | medio, for annidato, array |
|  | Somma dei quadrati, Quadrato della somma, Differenza | medio, int, for semplice |
|   |   |   |


- dezippare il file sul desktop (Mac, Windows, Linux)
- rinominare la cartella usando questa convenzione **cognome.nome.classe.NomeEsercizio** dove classe di solito è formata da due caratteri (3H, 4H, 5G, ...) ad esempio **conti.maurizio.4H.acronimo**
- aprire la cartella con VS Code e puntare al file **NomeEsercizio.cs** risolvendolo
- aprire un terminale ed eseguire **dotnet test** finchè tutti i test non sono passati.
- zippare la cartella in un file **nome.cognome.classe.NomeEsercizio.zip** e consegnarla con google classroom 


