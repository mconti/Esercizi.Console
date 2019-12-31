using System;
using System.Linq;

public static class Isogramma
{
    public static bool Verifica(string word)
    {
        if( word.Count() == 0 )
            return true;
        
        var onlyLetter = word.ToLower().Where( c => check(c) );
        var groups = onlyLetter.GroupBy( c => c );
        
        foreach( var item in groups )
            if( item.Count() > 1 )
                return false;
        
        return true;
    }

    private static bool check( char c )
    {
        // IsLetter is good but in this case I use may alphabet
        return "qwertyuiopasdfghjklzxcvbnm".Contains(c);
    }
}
