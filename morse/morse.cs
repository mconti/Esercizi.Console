public class Morse {

    public string Alfabeto{get;set;}

    public Morse()
    {
        
    }
    public Morse(string Alfabeto)
    {
        this.Alfabeto = Alfabeto;
    }

    public string Codifica( string s )
    {
        return "...---...";
    }
    public string Decodifica( string s )
    {
        return "SOS";
    }
}