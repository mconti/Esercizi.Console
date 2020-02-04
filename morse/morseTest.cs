using System;
using Xunit;

namespace morse
{
    public class MoreseUnitTest
    {
        [Fact]
        public void codifico_sos()
        {
            Morse m = new Morse();
            Assert.Equal<string>( "... --- ...", m.Codifica("sos"));
        }

        [Fact]
        public void codifico_SOS()
        {
            Morse m = new Morse();
            Assert.Equal<string>( "... --- ...", m.Codifica("SOS"));
        }
        
        [Fact]
        public void codifico_ciao()
        {
            Morse m = new Morse();
            Assert.Equal<string>( "-.-. .. .- ---", m.Codifica("Ciao"));
        }

        [Fact]
        public void decodifico_sos()
        {
            Morse m = new Morse();
            Assert.Equal<string>( "sos", m.Decodifica("... --- ...") );
        }

        [Fact]
        public void decodifico_ciao()
        {
            Morse m = new Morse();
            Assert.Equal<string>( "ciao", m.Decodifica("-.-. .. .- ---") );
        }
    }
}
