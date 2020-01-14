using System;
using Xunit;

public class MediaPesataTest
{
    [Fact]
    public void test1()
    {
        Assert.Equal(6.326, MediaPesata.Calcola("file1.txt"));
    }

    [Fact]
    public void test2()
    {
        Assert.Equal(24.09, MediaPesata.Calcola("file2.txt"));
    }

    [Fact]
    public void test3()
    {
        Assert.Equal(19.617, MediaPesata.Calcola("file3.txt"));
    }
}