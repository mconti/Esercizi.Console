// This file was auto-generated based on version 1.2.0 of the canonical data.

using System;
using Xunit;

public class GraniTest
{
    [Fact]
    public void Number_1()
    {
        Assert.Equal(1UL, Grani.Quadrato(1));
    }

    [Fact]
    public void Number_2()
    {
        Assert.Equal(2UL, Grani.Quadrato(2));
    }

    [Fact]
    public void Number_3()
    {
        Assert.Equal(4UL, Grani.Quadrato(3));
    }

    [Fact]
    public void Number_4()
    {
        Assert.Equal(8UL, Grani.Quadrato(4));
    }

    [Fact]
    public void Number_16()
    {
        Assert.Equal(32768UL, Grani.Quadrato(16));
    }

    [Fact]
    public void Number_32()
    {
        Assert.Equal(2147483648UL, Grani.Quadrato(32));
    }

    [Fact]
    public void Number_64()
    {
        Assert.Equal(9223372036854775808UL, Grani.Quadrato(64));
    }

    [Fact]
    public void Square_0_raises_an_exception()
    {
        Assert.Throws<ArgumentOutOfRangeException>(() => Grani.Quadrato(0));
    }

    [Fact]
    public void Negative_square_raises_an_exception()
    {
        Assert.Throws<ArgumentOutOfRangeException>(() => Grani.Quadrato(-1));
    }

    [Fact]
    public void Square_greater_than_64_raises_an_exception()
    {
        Assert.Throws<ArgumentOutOfRangeException>(() => Grani.Quadrato(65));
    }

    [Fact]
    public void Returns_the_total_number_of_grains_on_the_board()
    {
        Assert.Equal(18446744073709551615UL, Grani.Total());
    }
}