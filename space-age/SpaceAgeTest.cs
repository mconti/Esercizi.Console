// This file was auto-generated based on version 1.2.0 of the canonical data.

using Xunit;

public class EtaSpazialeTest
{
    [Fact]
    public void Age_on_earth()
    {
        Assert.Equal(31.69, EtaSpaziale.OnEarth(1000000000), precision: 2);
    }

    [Fact]
    public void Age_on_mercury()
    {
        Assert.Equal(280.88, EtaSpaziale.OnMercury(2134835688), precision: 2);
    }

    [Fact]
    public void Age_on_venus()
    {
        Assert.Equal(9.78, EtaSpaziale.OnVenus(189839836), precision: 2);
    }

    [Fact]
    public void Age_on_mars()
    {
        Assert.Equal(35.88, EtaSpaziale.OnMars(2129871239), precision: 2);
    }

    [Fact]
    public void Age_on_jupiter()
    {
        Assert.Equal(2.41, EtaSpaziale.OnJupiter(901876382), precision: 2);
    }

    [Fact]
    public void Age_on_saturn()
    {
        Assert.Equal(2.15, EtaSpaziale.OnSaturn(2000000000), precision: 2);
    }

    [Fact]
    public void Age_on_uranus()
    {
        Assert.Equal(0.46, EtaSpaziale.OnUranus(1210123456), precision: 2);
    }

    [Fact]
    public void Age_on_neptune()
    {
        Assert.Equal(0.35, EtaSpaziale.OnNeptune(1821023456), precision: 2);
    }
}