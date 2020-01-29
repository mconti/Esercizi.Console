using System;
using Xunit;

namespace morse
{
    public class MoreseUnitTest
    {
        [Fact]
        public void costruisco_un_oggetto_Morse()
        {
            Morse m = new Morse();
            Assert.Equal<string>( "... --- ...", m.Codifica("sos"));
            Assert.Equal<string>( "... --- ...", m.Codifica("SOS"));
            Assert.Equal<string>( "-.-. .. .- ---", m.Codifica("Ciao"));

            Assert.Equal<string>( "sos", m.Decodifica("... --- ...") );
            Assert.Equal<string>( "ciao", m.Decodifica("-.-. .. .- ---") );
        }
    }
}
