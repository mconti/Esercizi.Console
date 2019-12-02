using System;
using Xunit;

public class MediaPesataTest
{
    [Fact]
    public void test1()
    {
        Assert.Equal(30, stream.Leggi("file2.txt", 1));
    }

    [Fact]
    public void test2()
    {
        Assert.Equal(1, stream.Leggi("file1.txt", 5));
    }

    [Fact]
    public void test3()
    {
        Assert.Equal(30, stream.Leggi("file3.txt", 18));
    }
}