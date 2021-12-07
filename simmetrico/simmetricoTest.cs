
using System;
using Xunit;

namespace simmetrico
{
    public class simmetricoTest
    {
        [Fact]
        public void Test1()
        {
            var valori = new[] { 1,2,3,3,2,1,1,2,3,3,2,1 };
            Assert.True(Simmetrico.Verifica( valori ));
        }

        [Fact]
        public void Test2()
        {
            var valori = new[] { 1 };
            Assert.True(Simmetrico.Verifica( valori ));
        }

        [Fact]
        public void Test3()
        {
            var valori = new[] { 1,2 };
            Assert.False(Simmetrico.Verifica( valori ));
        }
        [Fact]
        public void Test4()
        {
            var valori = new[] { 2,2 };
            Assert.True(Simmetrico.Verifica( valori ));
        }
        [Fact]
        public void Test_null()
        {
            Assert.False(Simmetrico.Verifica( null ));
        }
        [Fact]
        public void Test_vuoto()
        {
            int[] valori = new int[]{};
            Assert.False(Simmetrico.Verifica( valori ));
        }
        [Fact]
        public void Test5()
        {
            var valori = new[] { 0,2,0 };
            Assert.True(Simmetrico.Verifica( valori ));
        }
    }
}
