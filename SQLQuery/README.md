# SQLQuery

Per risolvere l'esercizio è necessario scrivere delle query in linguaggio SQL e inserirle nei vari metodi del file SQLQuery.cs .

Tali metodi vengono chiamati in automatico lanciando il comando 

dotnet test

Per vedere cosa ci si aspetta come risultato,  vedere (ma non alterare) il file "SQLQueryTest.cs".

Come esempio, fare riferimento al metodo che ritorna tutti i record della tabella albums

```
public static List<Record> tutti_gli_album() 
{
    SQLiteConnection cn1 = new SQLiteConnection("chinook.db");
    List<Record> retVal = cn1.Query<Record>( "select * from albums" ); 

    return retVal;                        
}
```

Lato test, ci si aspettano 347 record e ci si aspetta che il 99esimo abbia come Title "Iron Maiden"

```
[Fact]
public void _tutti_gli_album()
{
    List<Record> result = Query.tutti_gli_album();
    Assert.Equal(347,result.Count);
    Assert.Equal("Iron Maiden",result[99].Title);
}
```
