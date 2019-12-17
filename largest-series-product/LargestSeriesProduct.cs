using System;
using System.Collections.Generic;
using System.Linq;

public static class LargestSeriesProduct
{
    public static long GetLargestProduct(string digits, int span) 
    {
        if( span==0 )
            return 1;

        if( digits.Length==0 || span<0 || digits.Length<span )
            throw new ArgumentException();

        List<string> retVal = new List<string>();

        // Slice 
        int start=0;
        while( start <= digits.Length-span )
            retVal.Add( digits.Substring(start++, span) );

        // foreach sliced ...
        List<int> results=new List<int>();
        foreach( string s in retVal.ToArray())
        {
            //... perform the product (if all digits are numbers)
            int val=1;
            foreach( char c in s )
                if( Char.IsNumber(c) )
                    val *= Convert.ToInt32(c.ToString());
                else
                    throw new ArgumentException() ;

            results.Add( val );
        }

        // return the max...
        return results.Max();
    }
}