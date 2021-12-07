// This file was auto-generated based on version 1.1.0 of the canonical data.

using Xunit;

public class numericharTest
{
    [Fact]
    public void primo_digit1()
    {
        Assert.Equal(1, numerichar.Verifica(1234, 0));
    }
    [Fact]
    public void ultimo_digit1()
    {
        Assert.Equal(4, numerichar.Verifica(1234, 3));
    }
    [Fact]
    public void primo_digit2()
    {
        Assert.Equal(1, numerichar.Verifica(-1234, 0));
    }
    [Fact]
    public void ultimo_digit2()
    {
        Assert.Equal(4, numerichar.Verifica(-1234, 3));
    }
    [Fact]
    public void digit_troppo_grande()
    {
        Assert.Equal(0, numerichar.Verifica(1234, 4));
    }
    [Fact]
    public void digit_negativo()
    {
        Assert.Equal(0, numerichar.Verifica(1234, -4));
    }

}