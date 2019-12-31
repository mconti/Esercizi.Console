// This file was auto-generated based on version 1.1.0 of the canonical data.

using Xunit;

public class ArmstrongTest
{
    [Fact]
    public void Zero_is_an_armstrong_number()
    {
        Assert.True(Armstrong.Verifica(0));
    }

    [Fact]
    public void Single_digit_numbers_are_armstrong_numbers()
    {
        Assert.True(Armstrong.Verifica(5));
    }

    [Fact]
    public void There_are_no_2_digit_armstrong_numbers()
    {
        Assert.False(Armstrong.Verifica(10));
    }

    [Fact]
    public void Three_digit_number_that_is_an_armstrong_number()
    {
        Assert.True(Armstrong.Verifica(153));
    }

    [Fact]
    public void Three_digit_number_that_is_not_an_armstrong_number()
    {
        Assert.False(Armstrong.Verifica(100));
    }

    [Fact]
    public void Four_digit_number_that_is_an_armstrong_number()
    {
        Assert.True(Armstrong.Verifica(9474));
    }

    [Fact]
    public void Four_digit_number_that_is_not_an_armstrong_number()
    {
        Assert.False(Armstrong.Verifica(9475));
    }

    [Fact]
    public void Seven_digit_number_that_is_an_armstrong_number()
    {
        Assert.True(Armstrong.Verifica(9926315));
    }

    [Fact]
    public void Seven_digit_number_that_is_not_an_armstrong_number()
    {
        Assert.False(Armstrong.Verifica(9926314));
    }
}