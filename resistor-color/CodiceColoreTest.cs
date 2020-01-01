// This file was auto-generated based on version 1.0.0 of the canonical data.

using Xunit;

public class CodiceColoriResistenze
{
    [Fact]
    public void Nero()
    {
        Assert.Equal(0, CodiceColoreResistenze.CodiceColore("Nero"));
    }

    [Fact]
    public void Bianco()
    {
        Assert.Equal(9, CodiceColoreResistenze.CodiceColore("Bianco"));
    }

    [Fact]
    public void Arancione()
    {
        Assert.Equal(3, CodiceColoreResistenze.CodiceColore("arancione"));
    }

    [Fact]
    public void TuttiIColori()
    {
        Assert.Equal(new[] { "nero", "marrone", "rosso", "arancione", "giallo", "verde", "blu", "viola", "grigio", "bianco" }, CodiceColoreResistenze.TuttiIColori());
    }

    [Fact]
    public void Resistenza1K()
    {
        Assert.Equal( 
            1000, 
            CodiceColoreResistenze.Valore( 
                new[] { "marrone", "nero", "rosso" } 
            )
        );
    }

    [Fact]
    public void Resistenza4K7()
    {
        Assert.Equal( 
            4700, 
            CodiceColoreResistenze.Valore( 
                new[] { "giallo", "viola", "rosso" } 
            )
        );
    }

    [Fact]
    public void Resistenza180K()
    {
        Assert.Equal( 
            180000, 
            CodiceColoreResistenze.Valore( 
                new[] { "marrone", "grigio", "giallo" } 
            )
        );
    }

    [Fact]
    public void Resistenza4K7_daValore()
    {
        Assert.Equal( 
            new[] { "giallo", "viola", "rosso" }, 
            CodiceColoreResistenze.CodiceColore( 4700 )
        );
    }
}