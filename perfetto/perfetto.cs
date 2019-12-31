using System;

public enum Numero
{
    Perfetto,
    Abbondante,
    Scarso
}

public static class NumeroPerfetto
{
    public static Numero Verifica(int number)
    {
        return Numero.Perfetto;
    }
}
