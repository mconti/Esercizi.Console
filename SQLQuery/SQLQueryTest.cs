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
            List<Record> result = Query.query();
            //Assert.Equal(2,2);
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

            result = cn1.Query<Record>( query.album_and_artist_in_order_of_album );                        
            Console.WriteLine( "album_and_artist_in_order_of_album" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[99].Title}) {result[99].Name}"  );
            Console.WriteLine( "" );

            result = cn1.Query<Record>( query.album_and_artist_in_order_of_artist );                        
            Console.WriteLine( "album_and_artist_in_order_of_artist" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[99].Title}) {result[99].Name}"  );
            Console.WriteLine( "" );

            result = cn1.Query<Record>( query.album_and_number_of_tracks );                        
            Console.WriteLine( "album_and_number_of_tracks" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[0].Title}) {result[0].NTracks}"  );
            Console.WriteLine( "" );
            
            result = cn1.Query<Record>( query.artist_and_album );                        
            Console.WriteLine( "artist_and_album" );
            Console.WriteLine( result.Count );
            Console.WriteLine( $"({result[0].Name}) {result[0].NAlbums}"  );
            Console.WriteLine( $"({result[190].Name}) {result[190].NAlbums}"  );
            Console.WriteLine( "" );
        }
    }
    */
}
