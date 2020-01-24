using System;
using System.Collections.Generic;
using SQLite;
using Xunit;

// dotnet add package sqlite-net-pcl --version 1.6.292
// https://www.sqlitetutorial.net/sqlite-sample-database/

namespace SQLQuery
{
    public class SQLTest{
        
        [Fact]
        public void _tutti_gli_album()
        {
            List<Record> result = Query.tutti_gli_album();
            Assert.Equal(347,result.Count);
            Assert.Equal("Iron Maiden",result[99].Title);
        }

        [Fact]
        public void album_and_artist_in_order_of_album()
        {
            List<Record> result = Query.album_and_artist_in_order_of_album();
            Assert.Equal(347,result.Count);
            Assert.Equal("Van Halen",result[99].Name);
        }

        [Fact]
        public void album_and_artist_in_order_of_artist()
        {
            List<Record> result = Query.album_and_artist_in_order_of_artist();
            Assert.Equal(347,result.Count);
            Assert.Equal("Faith No More",result[99].Name);
        }

        [Fact]
        public void album_and_number_of_tracks()
        {
            List<Record> result = Query.album_and_number_of_tracks();
            Assert.Equal("57",result[0].NTracks);
            Assert.Equal("Greatest Hits",result[0].Title);
        }

        [Fact]
        public void artist_and_album()
        {
            List<Record> result = Query.artist_and_album();
            Assert.Equal("Iron Maiden",result[0].Name);
            Assert.Equal("The Doors",result[190].Name);

            Assert.Equal("21",result[0].NAlbums);
            Assert.Equal("1",result[190].NAlbums);
        }
    }
}
