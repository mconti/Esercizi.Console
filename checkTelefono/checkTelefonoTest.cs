// This file was auto-generated based on version 1.1.0 of the canonical data.

using Xunit;

public class telefonoTest
{
    [Fact]
    public void numerCasa()
    {
        Assert.Equal("3349989823", Telefono.Check(new string[]{"05418888", "3349989823"}));
    }

    [Fact]
    public void numerCellConPrefissoZeroZero()
    {
        Assert.Equal("00393349989823", Telefono.Check(new string[]{"05418888", "00393349989823", "+39123456774"}));
    }

    [Fact]
    public void numerCellConPrefissoZeroZero1()
    {
        Assert.Equal("", Telefono.Check(new string[]{"05418888", "+00393349989823", "0019123456774"}));
    }

    [Fact]
    public void numerCellConPrefissoSbagliato()
    {
        Assert.Equal("", Telefono.Check(new string[]{"05418888", "+00393349989823"}));
    }

    [Fact]
    public void numerCellConPrefissoPiu()
    {
        Assert.Equal("+393349989823", Telefono.Check(new string[]{"05418888", "+393349989823"}));
    }

    [Fact]
    public void Piredda1()
    {
        Assert.Equal("00393349989823", Telefono.Check(new string[]{"05418888", "33393123456789", "00393349989823" }));
    }

    [Fact]
    public void Piredda2()
    {
        Assert.Equal("3931234567", Telefono.Check(new string[]{"05418888", "3931234567", "00393349989823" }));
    }


    [Fact]
    public void Piredda3()
    {
        Assert.Equal("3931234567", Telefono.Check(new string[]{"05418888", "3931234567", "00393349989823" }));
    }

    [Fact]
    public void Piredda4()
    {
        Assert.Equal("00393349989823", Telefono.Check(new string[]{"05418888", "39312 3456", "00393349989823" }));
    }

    [Fact]
    public void Piredda5()
    {
        Assert.Equal("3931234567", Telefono.Check(new string[]{"", "3931234567", "00393349989823" }));
    }
}