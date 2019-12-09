// This file was auto-generated based on version 1.2.0 of the canonical data.

using Xunit;

public class FibonacciTest
{
    [Fact]
    public void Test1()
    {
        Assert.Equal(144, Fibonacci.Calcola(12));
    }
    [Fact]
    public void Test2()
    {
        Assert.Equal(13, Fibonacci.Calcola(5));
    }

    [Fact]
    public void Test3()
    {
        Assert.Equal(1.615, Fibonacci.Calcola(7));
    }

}