using System;
using Xunit;

namespace CStudente
{
    public class UnitTest1
    {
        [Fact]
        public void test_costruisce_docente_default()
        {
            Docente s = new Docente();
            Assert.Equal<string>( "-", s.Nome );
            Assert.Equal<string>( "-", s.Cognome );
        }

        [Fact]
        public void test_costruisce_docente_standard()
        {
            Docente s = new Docente( "Marco", "Pini" );
            Assert.Equal<string>( "Marco", s.Nome );
            Assert.Equal<string>( "Pini", s.Cognome );
            Assert.Equal<string>( "Marco - Pini", s.ToString() );
        }
        [Fact]
        public void test_costruisce_docente_standard_titolo()
        {
            Docente s = new Docente( "Marco", "Pini", "prof." );
            Assert.Equal<string>( "Marco", s.Nome );
            Assert.Equal<string>( "Pini", s.Cognome );
            Assert.Equal<string>( "prof. Marco Pini", s.ToString() );
        }
    }
}
