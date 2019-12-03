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
    public void Missing_the_letter_x()
    {
        Assert.False(Alfabeto.Verifica("a quick movement of the enemy will jeopardize five gunboats"));
    }

    [Fact]
    public void Missing_the_letter_h()
    {
        Assert.False(Alfabeto.Verifica("five boxing wizards jump quickly at it"));
    }

    [Fact]
    public void With_underscores()
    {
        Assert.True(Alfabeto.Verifica("the_quick_brown_fox_jumps_over_the_lazy_dog"));
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
        Assert.False(Alfabeto.Verifica("the quick brown fox jumps over with lazy FX"));
    }
}