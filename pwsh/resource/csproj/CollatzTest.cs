
using System;
using Xunit;

public class CollatzTest
{
    [Fact(Timeout=1)]
    public void test1()
    {
        Collatz c = new Collatz();
        Assert.Equal(0, c.Passi(1));
    }

    [Fact(Timeout=1)]
    public void test16()
    {
        Collatz c = new Collatz();
        Assert.Equal(4, c.Passi(16));
    }

    [Fact(Timeout=1)]
    public void test12()
    {
        Collatz c = new Collatz();
        Assert.Equal(9, c.Passi(12));
    }

    [Fact(Timeout=1)]
    public void testGrande()
    {
        Collatz c = new Collatz();
        Assert.Equal(152, c.Passi(1000000));
    }

    [Fact]
    public void testZero()
    {
        Collatz c = new Collatz();
        Assert.Throws<ArgumentException>(() => c.Passi(0));
    }

    [Fact(Timeout=1)]
    public void testNegativo()
    {
        Collatz c = new Collatz();
        Assert.Throws<ArgumentException>(() => c.Passi(-15));
    }
}