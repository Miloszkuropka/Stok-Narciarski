
using Npgsql;

namespace SkiCommander.Repositories
{
    public class BaseRepository
    {
        private string connectionString = "Host=localhost;Username=admin;Password=admin;Database=ski-lift-commander";

        private ILogger<BaseRepository> logger;

        public BaseRepository(ILogger<BaseRepository> logger)
        {
            this.logger = logger;
        }

        public async Task<List<string>> Add()
        {
            await using var dataSource = NpgsqlDataSource.Create(connectionString);
            await using (var cmd = dataSource.CreateCommand("INSERT INTO \"Customers\" (id, phone_number, username, name, email, surname, salted_password_hash) VALUES ($1, $2, $3, $4, $5, $6, $7)"))
            {
                cmd.Parameters.AddWithValue(Guid.NewGuid());
                cmd.Parameters.AddWithValue("123456789");
                cmd.Parameters.AddWithValue("xXRektorXx");
                cmd.Parameters.AddWithValue("Rektor");
                cmd.Parameters.AddWithValue("rektor@polsl.pl");
                cmd.Parameters.AddWithValue("Rektorowicz");
                cmd.Parameters.AddWithValue("Pazzword");
                await cmd.ExecuteNonQueryAsync();
            }
            return new List<string>();
        }
    }
}
