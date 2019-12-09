// This file was auto-generated based on version 1.3.0 of the canonical data.

using Xunit;

public class Rna
{
    [Fact]
    public void Empty_rna_sequence()
    {
        Assert.Equal("", TrascrizioneRNA.ToRna(""));
    }

    [Fact]
    public void Rna_complement_of_cytosine_is_guanine()
    {
        Assert.Equal("G", TrascrizioneRNA.ToRna("C"));
    }

    [Fact]
    public void Rna_complement_of_guanine_is_cytosine()
    {
        Assert.Equal("C", TrascrizioneRNA.ToRna("G"));
    }

    [Fact]
    public void Rna_complement_of_thymine_is_adenine()
    {
        Assert.Equal("A", TrascrizioneRNA.ToRna("T"));
    }

    [Fact]
    public void Rna_complement_of_adenine_is_uracil()
    {
        Assert.Equal("U", TrascrizioneRNA.ToRna("A"));
    }

    [Fact]
    public void Rna_complement()
    {
        Assert.Equal("UGCACCAGAAUU", TrascrizioneRNA.ToRna("ACGTGGTCTTAA"));
    }
}