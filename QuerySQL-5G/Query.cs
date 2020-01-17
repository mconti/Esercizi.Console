using System;

    // In classe
    //
    // - Esporre e descrivere il diagramma ER di ChinoOk
    // - Evidenziare 10 interrogazioni in linguaggio naturale
    //
    // - Per ogni interrogazione, decidere l'elenco dei campi e il relativo nome (univoco)
    // -- Se ad esempio si incontrano due "Name" decidere nomi tipo ArtistName, TrackName 
    // 
    // - Esprimere le interrogazioni in linguaggio SQL tenendo presente le seguenti regole
    // -- Le colonne del dataset di ritorno dovranno avere il nome scelto (univoco, Title, Name, ...)
    // -- Le colonne che tornano interi, dovranno iniziare per N (NAlbums, NTracks, ...)
    // 
    // - Testare le query sul db ChinoOk 
    // -- Identificare i valori del primo record e di un ennesimo record a scelta
    // -- appuntarsi tali risultati su un GDocs condiviso tra tutti
    // 
    // - Creare una classe "Record" con tutte le property necessarie a contenere i dati estratti, dove 
    // -- i nomi delle property corrispondono ai nomi delle colonne dei dataset estratti con SQL
    // -- se la colonna è un int, il tipo dovrà essere int altrimenti string 
// 
//
// 
namespace QuerySQL
{
    public static class query {
        
// Elencare tutti gli album
// 347 record
// Il 100° è Iron Maiden
// OK
public static string tutti_gli_album =  @" 
    select * from albums
";

// Elencare Titolo Album e Nome Artista in ordine di Titolo Album
// 347 record
// il 100° Album (Diver Down) l'ha inciso "Van Halen"
// OK
public static string album_and_artist_in_order_of_album =  @" 
    select Title, Name from albums alb
    inner join artists art
    on alb.ArtistId == art.ArtistId
    order by Title
";

        
    }
}