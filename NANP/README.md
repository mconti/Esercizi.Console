# North American Numbering Plan 

Pulire la stringa in ingresso perchè sia valida ai fini del NAMP Americano.

Il North American Numbering Plan (NANP) è un sistema di numerazione telefonica utilizzato da molti paesi del Nord America come gli Stati Uniti, il Canada o le Bermuda. 

Tutti i paesi NANP condividono lo stesso prefisso internazionale: 1.

I numeri NANP sono numeri di dieci cifre costituiti da 
- un codice di area a tre cifre, comunemente noto come prefisso,
- seguito da un numero locale di sette cifre. 
- Le prime tre cifre del numero locale rappresentano il codice di scambio, 
- seguito dal numero univoco di quattro cifre *(che è il numero dell'abbonato)*.

Il formato è generalmente rappresentato come

(NXX) -NXX-XXXX

dove ù
- N è qualsiasi cifra compresa tra 2 e 9
- X è qualsiasi cifra compresa tra 0 e 9

Scopo dell'esercizio è di ripulire i numeri di telefono formattati in modo diverso rimuovendo la punteggiatura e il prefisso internazionale (1) se presente.

Ad esempio, i seguenti input

- +1 (613) -995-0253
- 613-995-0253
- 1 613 995 0253
- 613.995.0253

devono produrre tutti lo stesso output **6139950253**
