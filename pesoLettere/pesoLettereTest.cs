// This file was auto-generated based on version 1.1.0 of the canonical data.

using Xunit;

public class PesoLettereTest
{
    [Fact]
    public void Lowercase_dellaLettera()
    {
        Assert.Equal(1, PesoLettere.Pesa("a"));
    }

    [Fact]
    public void Uppercase_dellaLettera()
    {
        Assert.Equal(1, PesoLettere.Pesa("A"));
    }

    [Fact]
    public void Valuable_dellaLettera()
    {
        Assert.Equal(4, PesoLettere.Pesa("f"));
    }

    [Fact]
    public void Short_dellaParola()
    {
        Assert.Equal(2, PesoLettere.Pesa("at"));
    }

    [Fact]
    public void Short_valuable_dellaParola()
    {
        Assert.Equal(12, PesoLettere.Pesa("zoo"));
    }

    [Fact]
    public void Medium_dellaParola()
    {
        Assert.Equal(6, PesoLettere.Pesa("street"));
    }

    [Fact]
    public void Medium_valuable_dellaParola()
    {
        Assert.Equal(22, PesoLettere.Pesa("quirky"));
    }

    [Fact]
    public void Long_mixed_case_dellaParola()
    {
        Assert.Equal(41, PesoLettere.Pesa("OxyphenButazone"));
    }

    [Fact]
    public void English_like_dellaParola()
    {
        Assert.Equal(8, PesoLettere.Pesa("pinata"));
    }

    [Fact]
    public void Empty_input()
    {
        Assert.Equal(0, PesoLettere.Pesa(""));
    }

    [Fact]
    public void Entire_alphabet_available()
    {
        Assert.Equal(87, PesoLettere.Pesa("abcdefghijklmnopqrstuvwxyz"));
    }
    [Fact]
    public void Ciao_Mondo()
    {
        Assert.Equal(14, PesoLettere.Pesa("CiaoMondo"));
    }
}