# Esercizi.Console

Repository utilizzato nelle esercitazioni di laboratorio di C#.

Ogni cartella contiene un esercizio con tre file: 

*NomeEsercizio.cs*  l'esercizio da svolgere...

*NomeEsercizioTest.cs* che contiene le unit test da superare. Questo file non va alterato in alcun modo. 

*NomeEsercizio.csproj* che contiene le dipendenze necessarie alla compilazione come le librerie standard di .NET o ad esempio le librerie XUnit per eseguire le unit test.  

# Utilizzo

- Scaricare uno di questi zip

| Nome esercizio                   | Descrizione                                                                                                  |
|----------------------------------|--------------------------------------------------------------------------------------------------------------|
| [grani](collatz)                 | Conta i chicchi di grano su una schacchiera 8x8                                                              |
| [collatz](NANP)                  | Verifica la congettura di Collatz 3*N+1                                                                      |
| [NANP](acronimo)                 | Verifica se una stringa è conforme al NAtional Numbers Plan americano                                        |
| [acronimo](Alfabeto)             | Data una frase di n parole, ritorna l'iniziale di ogni parola.                                               |
| [Alfabeto](pesoLettere)          | Verifica che una frase contenga tutte le lettere dell'alfabeto italiano                                      |
| [pesoLettere](stream)            | Ogni lettera ha un peso. Calcolare il peso di una parola.                                                    |
| [stream](mediaPesata)            | Legge una riga da un file, estrae due numeri, visualizza il secondo                                          |
| [mediaPesata](rna)               | Legge 3 file.txt e calcola la media pesata dei numeri che contengono                                         |
| [rna](space-age)                 | Converte una sequenza di DNA in RNA                                                                          |
| [space-age](sum-of-multiplies)   | Calcola l'età di una persona con 1.000.000.000 di secondi sulla terra e se vivesse sugli altri pianeti       |
| [sum-of-multiplies](series)      | Calcola la somma dei multipli di una serie di numeri                                                         |
| [series](largest-series-product) | Slice di N caratteri da una stringa                                                                          |
| [largest-series-product](gocce)  | Slice di N caratteri e moltiplicazione tra loro delle cifre. Es. "1027839564",  =  270 (9 * 5 * 6)           |
| [gocce](punteggio)               | Se tra i fattori di un numero esiste 3,5,7, produce Pling, Plang, Plong                                      |
| [punteggio](perfetto)            | Dato un array di interi, tornare i tre più grandi, il più grande, l'ultimo inserito...                       |
| [perfetto](bisestile)            | Se la somma dei fattori di un numero (escluso il numero) è uguale al numero, si tratta di un numero perfetto |
| [bisestile](armstrong)           | Determinare se un anno è bisestile                                                                           |
| [armstrong](isogramma)           | Determinare se un numero dato è un numero di Armstrong                                                       |
| [isogramma]()                    | Determinare se una parola o una frase sia un isogramma (formata da lettere non ripetute)                     |


- dezippare il file sul desktop (Mac, Windows, Linux)
- rinominare la cartella usando questa convenzione **cognome.nome.classe.NomeEsercizio** dove classe di solito è formata da due caratteri (3H, 4H, 5G, ...) ad esempio **conti.maurizio.4H.acronimo**
- aprire la cartella con VS Code e puntare al file **NomeEsercizio.cs** risolvendolo
- aprire un terminale ed eseguire **dotnet test** finchè tutti i test non sono passati.
- zippare la cartella in un file **nome.cognome.classe.NomeEsercizio.zip** e consegnarla con google classroom 


