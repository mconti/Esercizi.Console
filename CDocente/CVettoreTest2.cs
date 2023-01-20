using System;
using Xunit;

namespace CVettore
{
    public class UnitTest2
    {
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
