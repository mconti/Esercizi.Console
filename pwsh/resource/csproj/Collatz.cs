using System;

public  class Collatz
{
    public  int Passi(int n)
    {
      if( n <=0 )
        throw new ArgumentException();

      int count=0;
      while(n!=1)
      {
        if( n%2 !=0 )
              n = n * 3 + 1;           
        else 
              n = n / 2;
        count++;
      }
      return count;
    }
}