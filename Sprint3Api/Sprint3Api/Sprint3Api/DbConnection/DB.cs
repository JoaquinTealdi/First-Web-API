using Npgsql;
using System.Data;

namespace Sprint3Api.DbConnection
{
    public class DB
    {
        public static IDbConnection db = new NpgsqlConnection("Host=localhost;Port=5432;Username=postgres;Password=12345;Database=Sprint2DB");
    }
}
