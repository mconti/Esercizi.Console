using System;
using SQLite;
// dotnet add package sqlite-net-pcl --version 1.6.292
// https://www.sqlitetutorial.net/sqlite-sample-database/

namespace QuerySQL
{
    class Program
    {
        static void Main(string[] args)
        {
            SQLiteConnection cn1 = new SQLiteConnection("chinook.db");

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

        }
    }

    public class Record
    {
        public int AlbumId {get;set;} 
        public string Title {get;set;} 
        public int ArtistId {get;set;} 
        public string Name {get;set;} 
        public string NTracks {get;set;} 
        public string NAlbums {get;set;} 

        public override string ToString() => $"{AlbumId}, {Title}, {ArtistId}, {Name}";
    }
}
