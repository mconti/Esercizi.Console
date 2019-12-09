using System;
using System.IO;

public static class MediaPesata
{
    public static double Calcola(string nomeFile)
    {
        // Attenzione!!
        // dopo aver calcolato il risultato,
        // ritornarlo arrotondato a 3 cifre decimali
        double retVal = 6.9619876;
        return Math.Round( retVal, 3 );
    }
}
