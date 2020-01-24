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

        public static List<Record> album_and_artist_in_order_of_album() 
        {
            return null;                        
        }
        public static List<Record> album_and_artist_in_order_of_artist() 
        {
            return null;                        
        }
        public static List<Record> album_and_number_of_tracks() 
        {
            return null;                        
        }
        public static List<Record> artist_and_album() 
        {
            return null;                        
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
    }
}