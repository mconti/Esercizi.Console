// This file was auto-generated based on version 1.1.0 of the canonical data.

using Xunit;

public class GocceTest
{
    [Fact]
    public void The_sound_for_1_is_1()
    {
        Assert.Equal("1", Gocce.Convert(1));
    }

    [Fact]
    public void The_sound_for_3_is_tic()
    {
        Assert.Equal("tic", Gocce.Convert(3));
    }

    [Fact]
    public void The_sound_for_5_is_tac()
    {
        Assert.Equal("tac", Gocce.Convert(5));
    }

    [Fact]
    public void The_sound_for_7_is_toc()
    {
        Assert.Equal("toc", Gocce.Convert(7));
    }

    [Fact]
    public void The_sound_for_6_is_tic_as_it_has_a_factor_3()
    {
        Assert.Equal("tic", Gocce.Convert(6));
    }

    [Fact]
    public void Number_2_to_the_power_3_does_not_make_a_raindrop_sound_as_3_is_the_exponent_not_the_base()
    {
        Assert.Equal("8", Gocce.Convert(8));
    }

    [Fact]
    public void The_sound_for_9_is_tic_as_it_has_a_factor_3()
    {
        Assert.Equal("tic", Gocce.Convert(9));
    }

    [Fact]
    public void The_sound_for_10_is_tac_as_it_has_a_factor_5()
    {
        Assert.Equal("tac", Gocce.Convert(10));
    }

    [Fact]
    public void The_sound_for_14_is_toc_as_it_has_a_factor_of_7()
    {
        Assert.Equal("toc", Gocce.Convert(14));
    }

    [Fact]
    public void The_sound_for_15_is_tictac_as_it_has_factors_3_and_5()
    {
        Assert.Equal("tictac", Gocce.Convert(15));
    }

    [Fact]
    public void The_sound_for_21_is_tictoc_as_it_has_factors_3_and_7()
    {
        Assert.Equal("tictoc", Gocce.Convert(21));
    }

    [Fact]
    public void The_sound_for_25_is_tac_as_it_has_a_factor_5()
    {
        Assert.Equal("tac", Gocce.Convert(25));
    }

    [Fact]
    public void The_sound_for_27_is_tic_as_it_has_a_factor_3()
    {
        Assert.Equal("tic", Gocce.Convert(27));
    }

    [Fact]
    public void The_sound_for_35_is_tactoc_as_it_has_factors_5_and_7()
    {
        Assert.Equal("tactoc", Gocce.Convert(35));
    }

    [Fact]
    public void The_sound_for_49_is_toc_as_it_has_a_factor_7()
    {
        Assert.Equal("toc", Gocce.Convert(49));
    }

    [Fact]
    public void The_sound_for_52_is_52()
    {
        Assert.Equal("52", Gocce.Convert(52));
    }

    [Fact]
    public void The_sound_for_105_is_tictactoc_as_it_has_factors_3_5_and_7()
    {
        Assert.Equal("tictactoc", Gocce.Convert(105));
    }

    [Fact]
    public void The_sound_for_3125_is_tac_as_it_has_a_factor_5()
    {
        Assert.Equal("tac", Gocce.Convert(3125));
    }
}