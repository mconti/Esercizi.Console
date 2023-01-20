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
        
        [Fact]
        public void test_togli_elemento()
        {
            Vettore v = new Vettore();
            Assert.False( v.EliminaUltimo() );

            Assert.True( v.Aggiungi(521) );
            Assert.Equal<int>( 521, v.Ultimo() );
            Assert.True( v.EliminaUltimo() );

            v = new Vettore( 1000 );
            Assert.False( v.EliminaUltimo() );

            for(int idx=0; idx < 1000 ; idx++ )
            {
                v.Aggiungi( idx );
            }

            Assert.Equal<int>( 999, v.Ultimo() );
            Assert.Equal<int>( 499500, v.Somma() );

            Assert.True( v.EliminaUltimo() );
        }

    }
}
