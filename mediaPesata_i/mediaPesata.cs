using System;
using System.IO;

public static class MediaPesata
{
    public static double Calcola(string nomeFile)
    {
        // Apre il file richiesto
        StreamReader  sr = new StreamReader( nomeFile );
        
        // Legge solo la prima riga
        string riga = sr.ReadLine();

        // scompone in due colonne la riga
        string[] colonne = riga.Split(';');

        // Trasforma le stringhe lette in valori double
        Double.TryParse( colonne[0], out double valore );
        Double.TryParse( colonne[1], out double peso );

        // esegue un calcolo (giusto per fare un esempio)
        double retVal = valore*peso;

        // arrotonda a 3 cifre decimali
        return Math.Round( retVal, 3 );
    }
}
