using System;
using System.IO;

public static class stream
{
    public static double Leggi(string nomeFile, int nRighe)
    {
        // Apre il file richiesto
        StreamReader  sr = new StreamReader( nomeFile );
        
        // Legge solo la prima riga
        string riga = sr.ReadLine();
        
        sr.Close();

        // scompone in due colonne la riga
        string[] colonne = riga.Split(',');

        // Trasforma le stringhe lette in valori double
        Double.TryParse( colonne[0], out double valore1 );
        Double.TryParse( colonne[1], out double valore2 );

        // esegue un calcolo (giusto per fare un esempio)
        double retVal = valore1/valore2;

        // arrotonda a 3 cifre decimali
        return  Math.Round( valore2, 3 );
    }
}
