// This file was auto-generated based on version 1.1.0 of the canonical data.

using System;
using Xunit;

public class PerfectNumbersTest
{
    [Fact]
    public void Smallest_perfect_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Perfetto, NumeroPerfetto.Verifica(6));
    }

    [Fact]
    public void Medium_perfect_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Perfetto, NumeroPerfetto.Verifica(28));
    }

    [Fact]
    public void Large_perfect_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Perfetto, NumeroPerfetto.Verifica(33550336));
    }

    [Fact]
    public void Smallest_abundant_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Abbondante, NumeroPerfetto.Verifica(12));
    }

    [Fact]
    public void Medium_abundant_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Abbondante, NumeroPerfetto.Verifica(30));
    }

    [Fact]
    public void Large_abundant_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Abbondante, NumeroPerfetto.Verifica(33550335));
    }

    [Fact]
    public void Smallest_prime_deficient_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Scarso, NumeroPerfetto.Verifica(2));
    }

    [Fact]
    public void Smallest_non_prime_deficient_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Scarso, NumeroPerfetto.Verifica(4));
    }

    [Fact]
    public void Medium_deficient_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Scarso, NumeroPerfetto.Verifica(32));
    }

    [Fact]
    public void Large_deficient_number_is_classified_correctly()
    {
        Assert.Equal(Numero.Scarso, NumeroPerfetto.Verifica(33550337));
                                                       //   33550337
    }

    [Fact]
    public void Edge_case_no_factors_other_than_itself_is_classified_correctly()
    {
        Assert.Equal(Numero.Scarso, NumeroPerfetto.Verifica(1));
    }

    [Fact]
    public void Zero_is_rejected_not_a_natural_number_()
    {
        Assert.Throws<ArgumentOutOfRangeException>(() => NumeroPerfetto.Verifica(0));
    }

    [Fact]
    public void Negative_integer_is_rejected_not_a_natural_number_()
    {
        Assert.Throws<ArgumentOutOfRangeException>(() => NumeroPerfetto.Verifica(-1));
    }
}