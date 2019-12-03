// This file was auto-generated based on version 2.0.0 of the canonical data.

using Xunit;

public class AlfabetoTest
{
    [Fact]
    public void Empty_sentence()
    {
        Assert.False(Alfabeto.Verifica(""));
    }

    [Fact]
    public void Perfect_lower_case()
    {
        Assert.True(Alfabeto.Verifica("abcdefghijklmnopqrstuvwxyz"));
    }

    [Fact]
    public void Only_lower_case()
    {
        Assert.True(Alfabeto.Verifica("the quick brown fox jumps over the lazy dog"));
    }

    [Fact]
    public void Missing_the_letter_t()
    {
        Assert.False(Alfabeto.Verifica("Ma che bel gufo spenzola da quei ravi"));
    }

    [Fact]
    public void With_underscores()
    {
        Assert.True(Alfabeto.Verifica("Qualche vago ione tipo zolfo, bromo, sodio"));
    }

    [Fact]
    public void With_numbers()
    {
        Assert.True(Alfabeto.Verifica("the 1 quick brown fox jumps over the 2 lazy dogs"));
    }

    [Fact]
    public void Missing_letters_replaced_by_numbers()
    {
        Assert.False(Alfabeto.Verifica("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"));
    }

    [Fact]
    public void Mixed_case_and_punctuation()
    {
        Assert.True(Alfabeto.Verifica("\"Five quacking Zephyrs jolt my wax bed.\""));
    }

    [Fact]
    public void Case_insensitive()
    {
        Assert.True(Alfabeto.Verifica("Che Tempi brevi zio, quando solfeggi "));
    }
}