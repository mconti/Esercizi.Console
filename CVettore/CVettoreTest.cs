using System;
using Xunit;

namespace CVettore
{
    public class UnitTest1
    {
        [Fact]
        public void test_costruisce_vettore_default()
        {
            Vettore v = new Vettore();
            Assert.Equal<int>( 0, v.Somma() );
            Assert.True( v.Aggiungi(5) );
            Assert.Equal<int>( 5, v.Somma() );
            Assert.False( v.Aggiungi(5) );
            Assert.Equal<int>( 5, v.Somma() );
        }
        
        [Fact]
        public void test_costruisce_vettore_dimensionato()
        {
            Vettore v = new Vettore( 5 );
            Assert.Equal<int>( 0, v.Somma() );
            Assert.True( v.Aggiungi(51) );
            Assert.Equal<int>( 51, v.Somma() );
            Assert.True( v.Aggiungi(5) );
            Assert.Equal<int>( 56, v.Somma() );
        }

        [Fact]
        public void test_costruisce_vettore_dimensionato_negativo()
        {
            Vettore v = new Vettore( -5 );
            Assert.Equal<int>( 0, v.Somma() );
            Assert.False( v.Aggiungi(51) );
            Assert.Equal<int>( 0, v.Somma() );
        }

        [Fact]
        public void test_ultimo_valore()
        {
            Vettore v = new Vettore( 3 );
            Assert.Equal<int>( 0, v.Ultimo() );
            Assert.True( v.Aggiungi(51) );
            Assert.Equal<int>( 51, v.Ultimo() );
            Assert.True( v.Aggiungi(15) );
            Assert.Equal<int>( 15, v.Ultimo() );
            Assert.Equal<int>( 66, v.Somma() );

        }
        [Fact]
        public void test_dimensione_zero()
        {
            Vettore v = new Vettore( 0 );
            Assert.Equal<int>( 0, v.Ultimo() );
            Assert.False( v.Aggiungi(51) );
            Assert.Equal<int>( 0, v.Somma() );
        }
    }
}
