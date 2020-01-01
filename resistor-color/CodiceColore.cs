using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;

public static class CodiceColoreResistenze
{
    enum Colori  { nero, marrone, rosso, arancione, giallo, verde, blu, viola, grigio, bianco };
    public static int CodiceColore(string colore)
    {
        Colori retVal;
        if( Enum.TryParse( colore.ToLower(), out retVal ) )
            return (int)retVal;

        return -1;
    }

    public static int Valore(string[] colori)
    {
        Enum.TryParse( colori[0], out Colori decine );
        Enum.TryParse( colori[1], out Colori unita );
        Enum.TryParse( colori[2], out Colori zeri );

        return (((int)decine)*10 + ((int)unita)) * (int)Math.Pow(10,(int)zeri);
    }

    public static string[] CodiceColore( int val )
    {
        string s = val.ToString();
        int len = s.Length;

        int v = val/100;
        List<string> retVal = new List<string>();

        foreach(char c in v.ToString())
        {

        }
        
        return new string[]{ "marrone", "nero", "rosso" };
    }

    public static string[] TuttiIColori()
    {
        return Enum.GetNames( typeof(Colori) );
    }
}