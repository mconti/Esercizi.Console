
using Xunit;

public class AcronimoTest
{
    [Fact]
    public void TestBase()
    {
        Assert.Equal("PNG", Acronimo.Abbrevia("Portable Network Graphics"));
    }

    [Fact]
    public void TestMinuscole()
    {
        Assert.Equal("ROR", Acronimo.Abbrevia("Ruby on Rails"));
    }

    [Fact]
    public void TestVirgole()
    {
        Assert.Equal("FIFO", Acronimo.Abbrevia("First In, First Out"));
    }

    [Fact]
    public void TestMaiuscole()
    {
        Assert.Equal("GIMP", Acronimo.Abbrevia("GNU Image Manipulation Program"));
    }

    [Fact]
    public void TestWhiteSpace()
    {
        Assert.Equal("CMOS", Acronimo.Abbrevia("Complementary metal-oxide semiconductor"));
    }

    [Fact]
    public void TestLungo()
    {
        Assert.Equal("ROTFLSHTMDCOALM", Acronimo.Abbrevia("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"));
    }

    [Fact]
    public void TestDelimitatori()
    {
        Assert.Equal("SIMUFTA", Acronimo.Abbrevia("Something - I made up from thin air"));
    }

    [Fact]
    public void TestApostrofi()
    {
        Assert.Equal("HC", Acronimo.Abbrevia("Halley's Comet"));
    }

    [Fact]
    public void TestUnderscore()
    {
        Assert.Equal("TRNT", Acronimo.Abbrevia("The Road _Not_ Taken"));
    }
}