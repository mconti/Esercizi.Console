using System;
using System.Collections.Generic;
using SQLite;

namespace SQLQuery
{

    public static class Query {
        
        public static List<Record> tutti_gli_album() 
        {
            SQLiteConnection cn1 = new SQLiteConnection("chinook.db");
            List<Record> retVal = cn1.Query<Record>( "select * from albums" ); 

            return retVal;                        
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