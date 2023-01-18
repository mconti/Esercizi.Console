
using System;
using Xunit;

namespace bubble
{
    public class bubbleTest
    {
        [Fact]
        public void Test1()
        {
            var valori = new[] { 3,2,1 };
            var valoriOrdinati = new[] { 1,2,3 };
            Assert.Equal(valoriOrdinati, Bubble.Sort(valori));
        }

        [Fact]
        public void Test2()
        {
            var valori = new[] { 3, 2, 1, -5, 10, 4, 1, 3, 4 };
            var valoriOrdinati = new[] { -5, 1, 1, 2, 3, 3, 4, 4, 10 };
            Assert.Equal(valoriOrdinati, Bubble.Sort(valori));
        }

        [Fact]
        public void Test3()
        {
            var valori = new[] { 3, 2, 1, -5, 10, 4, 1, 3, 4, 10, 100, 1000, -10000, 34, 1, 123 };
            var valoriOrdinati = new[] { -10000, -5, 1, 1, 1, 2, 3, 3, 4, 4, 10, 10, 34, 100, 123, 1000 };
            Assert.Equal(valoriOrdinati, Bubble.Sort(valori));
        }

        [Fact]
        public void Test4()
        {
            var valori = new[] { 3, 2, 1, -5, 10, 4, 1, 3, 4, 10, 100, 1000, -10000, 34, 1, 123, 100000 };
            var valoriOrdinati = new[] { -10000, -5, 1, 1, 1, 2, 3, 3, 4, 4, 10, 10, 34, 100, 123, 1000, 100000 };
            Assert.Equal(valoriOrdinati, Bubble.Sort(valori));
        }

        [Fact]
        public void Test5()
        {
            var valori = new[] { 1, 4, 53, 2, 1, -5, 10, 4, 1, 3, 4, 10, 100, 1000, -10000, 34, 1, 123 };
            var valoriOrdinati = new int[] { -10000, -5, 1, 1, 1, 1, 2, 3, 4, 4, 4, 10, 10, 34, 53, 100, 123, 1000  };
            Assert.Equal(valoriOrdinati, Bubble.Sort(valori));
        }
        
        [Fact]
        public void Test6()
        {
            var valori = new[] { -78, 65, 1001, 1, 4, 53, 2, 1, -5, 10, 4, 1, 3, 4, 10, 100, 1000, -10000, 34, 1, 123 };
            var valoriOrdinati = new int[] { -10000, -78, -5, 1, 1, 1, 1, 2, 3, 4, 4, 4, 10, 10, 34, 53, 65, 100, 123, 1000, 1001 };
            Assert.Equal(valoriOrdinati, Bubble.Sort(valori));
        }

        [Fact]
        public void Test7()
        {
            var valori = new int[] {};
            var valoriOrdinati = new int[]{};
            Assert.Equal(valoriOrdinati, Bubble.Sort(valori));
        }
    }
}
