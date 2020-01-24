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
    }

    /*
    class Program
    {
        void prova()
        {
            SQLiteConnection cn1 = new SQLiteConnection("chinook.db");
            //var result = cn1.Query<Album>("select * from Albums");

            var result = cn1.Query<Record>( query.tutti_gli_album );                        
            Console.WriteLine( "tutti_gli_album" );
            Console.WriteLine( result.Count );
            Console.WriteLine( result[99].Title  );
            Console.WriteLine( "" );
tutti_gli_album
347
Iron Maiden


            result = cn1.Query<Record>( query.album_and_artist_in_order_of_album );                        
            Console.WriteLine( "album_and_artist_in_order_of_album" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[99].Title}) {result[99].Name}"  );
            Console.WriteLine( "" );

album_and_artist_in_order_of_album
347
(Diver Down) Van Halen

            result = cn1.Query<Record>( query.album_and_artist_in_order_of_artist );                        
            Console.WriteLine( "album_and_artist_in_order_of_artist" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[99].Title}) {result[99].Name}"  );
            Console.WriteLine( "" );

album_and_artist_in_order_of_artist
347
(Album Of The Year) Faith No More

            result = cn1.Query<Record>( query.album_and_number_of_tracks );                        
            Console.WriteLine( "album_and_number_of_tracks" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[0].Title}) {result[0].NTracks}"  );
            Console.WriteLine( "" );
            
album_and_number_of_tracks
347
(Greatest Hits) 57

            result = cn1.Query<Record>( query.artist_and_album );                        
            Console.WriteLine( "artist_and_album" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[0].Name}) {result[0].NAlbums}"  );
            Console.WriteLine( $"({result[190].Name}) {result[190].NAlbums}"  );
            Console.WriteLine( "" );

artist_and_album
204
(Iron Maiden) 21
(The Doors) 1


        }
    }







    */
}
