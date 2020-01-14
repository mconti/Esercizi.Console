
using System;
using Xunit;

namespace sequenza
{
    public class sequenzaTest
    {
        [Fact]
        public void N_zero()
        {
            int[] valori = new int[] {};
            Assert.Equal( valori, Sequenza.Verifica( 0 ) );
        }

        [Fact]
        public void N_uno()
        {
            int[] valori = new int[] { 1 };
            Assert.Equal( valori, Sequenza.Verifica( 1 ) );
        }

        [Fact]
        public void N_due()
        {
            int[] valori = new int[] { 1, 2, 2 };
            Assert.Equal( valori, Sequenza.Verifica( 2 ) );
        }

        [Fact]
        public void N_tre()
        {
            int[] valori = new int[] { 1, 2, 2, 3, 3, 3 };
            Assert.Equal( valori, Sequenza.Verifica( 3 ) );
        }
        [Fact]
        public void N_quattro()
        {
            int[] valori = new int[] { 1, 2, 2, 3, 3, 3, 4, 4, 4, 4  };
            Assert.Equal( valori, Sequenza.Verifica( 4 ) );
        }

        [Fact]
        public void N_cinque()
        {
            int[] valori = new int[] { 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5  };
            Assert.Equal( valori, Sequenza.Verifica( 5 ) );
        }

        [Fact]
        public void N_negativo_torna_vuoto()
        {
            int[] valori = new int[] { };
            Assert.Equal( valori, Sequenza.Verifica( -5 ) );
        }
    }
}
