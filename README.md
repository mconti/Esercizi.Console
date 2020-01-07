# Esercizi.Console

Repository utilizzato nelle esercitazioni di laboratorio di C#.

Ogni cartella contiene un esercizio con tre file: 

*NomeEsercizio.cs*  l'esercizio da svolgere...

*NomeEsercizioTest.cs* che contiene le unit test da superare. Questo file non va alterato in alcun modo. 

*NomeEsercizio.csproj* che contiene le dipendenze necessarie alla compilazione come le librerie standard di .NET o ad esempio le librerie XUnit per eseguire le unit test.  

# Utilizzo

- Scaricare uno dei seguenti zip
- dezippare il file sul desktop (Mac, Windows, Linux)
- rinominare la cartella usando questa convenzione **cognome.nome.classe.NomeEsercizio** dove classe di solito è formata da due caratteri (3H, 4H, 5G, ...) ad esempio **conti.maurizio.4H.acronimo**
- aprire la cartella con VS Code e puntare al file **NomeEsercizio.cs** risolvendolo
- aprire un terminale ed eseguire **dotnet test** finchè tutti i test non sono passati.
- zippare la cartella in un file **nome.cognome.classe.NomeEsercizio.zip** e consegnarla con google classroom 

| Nome esercizio | Descrizione | Livello | Strumenti |
|--|--|--|--|
| [bisestile](https://github.com/mconti/Esercizi.Console/tree/master/bisestile) | Determinare se un anno è bisestile | *molto semplice* | divisore con resto % |
| [space-age](https://github.com/mconti/Esercizi.Console/tree/master/space-age) | Calcola l'età di una persona con 1.000.000.000 di secondi sulla terra (e se vivesse su altri pianeti?) | *molto semplice* | double |
|  |   |  |   |
| [grani](https://github.com/mconti/Esercizi.Console/tree/master/grani) | Conta i chicchi di grano su una scacchiera 8x8 | *semplice* | int, for semplice |
| [collatz](https://github.com/mconti/Esercizi.Console/tree/master/collatz) | Verifica la congettura di Collatz 3*N+1 | *semplice* | int, for semplice |
| [acronimo](https://github.com/mconti/Esercizi.Console/tree/master/acronimo) | Data una frase di n parole, ritorna l'iniziale di ogni parola. | *semplice* | string, for semplice, Split() |
| [Alfabeto](https://github.com/mconti/Esercizi.Console/tree/master/Alfabeto) | Verifica che una frase contenga tutte le lettere dell'alfabeto italiano | *semplice* | string, for semplice, Contains(char) |
| [pesoLettere](https://github.com/mconti/Esercizi.Console/tree/master/pesoLettere) | Ogni lettera ha un peso. Calcolare il peso di una parola. | *semplice* | Dictionary, foreach |
| [rna](https://github.com/mconti/Esercizi.Console/tree/master/rna) | Converte una sequenza di DNA in RNA | *semplice* | trasforma string, for semplice, IndexOf |
| [series](https://github.com/mconti/Esercizi.Console/tree/master/series) | Slice di N caratteri da una stringa | *semplice* | string, for semplice, Substring |
|  |   |  |   |
| [NANP](https://github.com/mconti/Esercizi.Console/tree/master/NANP) | Verifica se una stringa è conforme al NAtional Numbers Plan americano | *normale* | vettori, string, for semplice, IsDigit |
| [stream](https://github.com/mconti/Esercizi.Console/tree/master/stream) | Legge una riga da un file, estrae due numeri, visualizza il secondo | *normale* | primo esercizio che legge da file con StreamReader() |
| [mediaPesata](https://github.com/mconti/Esercizi.Console/tree/master/mediaPesata) | Legge 3 file.txt e calcola la media pesata dei numeri che contengono  | *normale* | double, StreamReader, File CSV, Split() |
| [gocce](https://github.com/mconti/Esercizi.Console/tree/master/gocce) | Se tra i fattori di un numero esiste 3,5,7, produce Pling, Plang, Plong | *normale* | divisione con resto % |
| [punteggio](https://github.com/mconti/Esercizi.Console/tree/master/punteggio) | Dato un array di interi, tornare i tre più grandi, il più grande, l'ultimo inserito... | *normale* | facile con LINQ, int, array, serve un Sort |
| [armstrong](https://github.com/mconti/Esercizi.Console/tree/master/armstrong) | Determinare se un numero dato è un numero di Armstrong | *normale* | string, char, double, for semplice, Math.Pow()  |
| [differenzaQuadrati](https://github.com/mconti/Esercizi.Console/tree/master/differenzaQuadrati) | Differenza tra Somma dei quadrati e Quadrato della somma di N numeri. | *normale* | int, for semplice |
|  |   |  |   |
| [sum-of-multiples](https://github.com/mconti/Esercizi.Console/tree/master/sum-of-multiples) | Calcola la somma dei multipli di una serie di numeri   | *medio* | int, array, for annidato, valori distinti  |
| [SerieProdotto](https://github.com/mconti/Esercizi.Console/tree/master/SerieProdotto) | Slice di N caratteri e moltiplicazione tra loro delle cifre. Es. "1027839564",  =  270 (9 * 5 * 6) | *medio* | string, for annidato, Substring(), IsNumber(), evoluzione di  Series |
| [perfetto](https://github.com/mconti/Esercizi.Console/tree/master/perfetto) | Se la somma dei fattori di un numero (escluso il numero) è uguale al numero, si tratta di un numero perfetto | *medio* | array, Enum, cerca fattori |
| [isogramma](https://github.com/mconti/Esercizi.Console/tree/master/isogramma) | Determinare se una parola o una frase sia un isogramma (formata da lettere non ripetute) | *medio* | for annidato, vettori |
|  |   |  |   |
