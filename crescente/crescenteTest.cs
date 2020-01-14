
using System;
using Xunit;

namespace crescente
{
    public class crescenteTest
    {
        [Fact]
        public void strettamente_crescente()
        {
            var valori = new[] { 1,2,3,4,5,6,7,8,9,10,11,12 };
            Assert.True(Crescente.Verifica( valori ));
        }

        [Fact]
        public void due_valori_consecutivi_uguali()
        {
            var valori = new[] { 1,2,3,4,5,5,6,7,8,9,10,11,12 };
            Assert.False(Crescente.Verifica( valori ));
        }

        [Fact]
        public void valori_a_caso()
        {
            var valori = new[] { 10,20,30,0,50,50,60,7,8,9,100,11,12 };
            Assert.False(Crescente.Verifica( valori ));
        }

        [Fact]
        public void vettore_vuoto_non_valido()
        {
            int[] valori = new int[]{};
            Assert.False(Crescente.Verifica( valori ));
        }

        [Fact]
        public void numeri_negativi()
        {
            var valori = new[] { -3,-2,-1,0,1 };
            Assert.True(Crescente.Verifica( valori ));
        }
    }
}
