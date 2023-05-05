using System;
using Xunit;

namespace Piramide
{
    public class UnitTest1
    {
        [Fact]
        public void test_0()
        {
            int mattoni = 0;
            Assert.Equal<int>( 0, Piramide.Piani( mattoni ) );
            //Assert.Equal<int>( 0, Piramide.Rimanenti( mattoni ) );
        }

        [Fact]
        public void test_1()
        {
            int mattoni = 1;
            Assert.Equal<int>( 1, Piramide.Piani( mattoni ) );
            Assert.Equal<int>( 0, Piramide.Rimanenti( mattoni ) );
        }

        [Fact]
        public void test_2()
        {
            int mattoni = 2;
            Assert.Equal<int>( 1, Piramide.Piani( mattoni ) );
            Assert.Equal<int>( 1, Piramide.Rimanenti( mattoni ) );
        }

        [Fact]
        public void test_10()
        {
            int mattoni = 10;
            Assert.Equal<int>( 2, Piramide.Piani( mattoni ) );
            //Assert.Equal<int>( 0, Piramide.Rimanenti( mattoni ) );
        }

        [Fact]
        public void test_meno_10()
        {
            int mattoni = -10;
            Assert.Equal<int>( 0, Piramide.Piani( mattoni ) );
            //Assert.Equal<int>( 0, Piramide.Rimanenti( mattoni ) );
        }
        
        [Fact]
        public void test_10000()
        {
            int mattoni = 10000;
            Assert.Equal<int>( 19, Piramide.Piani( mattoni ) );
            Assert.Equal<int>( 861, Piramide.Rimanenti( mattoni ) );
        }

        [Fact]
        public void test_4()
        {
            int mattoni = 1+9+25+1;
            Assert.Equal<int>( 3, Piramide.Piani( mattoni ) );
            Assert.Equal<int>( 1, Piramide.Rimanenti( mattoni ) );

            mattoni = 1+9+25+49;
            Assert.Equal<int>( 4, Piramide.Piani( mattoni ) );
            Assert.Equal<int>( 0, Piramide.Rimanenti( mattoni ) );

            mattoni = 9;
            Assert.Equal<int>( 1, Piramide.Piani( mattoni ) );
            Assert.Equal<int>( 8, Piramide.Rimanenti( mattoni ) );
        }
    }
}
