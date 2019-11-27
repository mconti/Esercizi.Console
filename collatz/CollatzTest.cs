
using System;
using Xunit;

public class CollatzTest
{
    [Fact]
    public void test1()
    {
        Assert.Equal(0, Collatz.Passi(1));
    }

    [Fact]
    public void test16()
    {
        Assert.Equal(4, Collatz.Passi(16));
    }

    [Fact]
    public void test12()
    {
        Assert.Equal(9, Collatz.Passi(12));
    }

    [Fact]
    public void testGrande()
    {
        Assert.Equal(152, Collatz.Passi(1000000));
    }

    [Fact]
    public void testZero()
    {
        Assert.Throws<ArgumentException>(() => Collatz.Passi(0));
    }

    [Fact]
    public void testNegativo()
    {
        Assert.Throws<ArgumentException>(() => Collatz.Passi(-15));
    }
}