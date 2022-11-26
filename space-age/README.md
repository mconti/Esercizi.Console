# Space Age

Il periodo orbitale (quanto ci mette un pianeta a fare un giro intorno al sole) cambia a seconda del pianeta 

| Pianeta | Tempo per completare un giro intorno al sole |
|--|--|
| Terra | 365,25 giorni terrestri o 31.557.600 secondi detto anche anno terrestre |
| Mercurio | 0,2408467 anni terrestri |
| Venere | 0,61519726 anni terrestri |
| Marte | 1,8808158 anni terrestri |
| Giove | 11,862615 anni terrestri |
| Saturno | 29,447498 anni terrestri |
| Urano | 84,016846 anni terrestri |
| Nettuno | 164,79132 anni terrestri |

Quindi, se ti viene detto che sulla terra qualcuno ha 1.000.000.000 di secondi, dovresti essere in grado di dire che ha compiuto 31,69 anni terrestri.


Esercizio

Realizzare un programma per calcolare l’età 
- Terreste 
- Mercuriana 
- Veneriana 
- Marziana 
- etc..

di una persona che ha 1.000.000.000 di secondi.

## Note

- I valori double in C# si esprimono con un .
Ad esempio 10 in formato double si scrive 10.0

- Attenzione alle regole del tipo double.
Se dobbiamo ad esempio trovare i minuti partendo dai secondi, meglio scrivere:

```javascript
double minuti = secondi / 60.0;
```

- .NET ha una classe Math con un metodo Round() che serve per arrotondare.
In questo esercizio si arrotonda a 2 cifre decimali quindi usare una formula tipo questa:

```javascript
double retVal = Math.Round( valoreDaArrotondare, 2 );
return retVal;
```
https://concepto.de/wp-content/uploads/2018/02/Sistema-solar-e1518703607625.jpg
