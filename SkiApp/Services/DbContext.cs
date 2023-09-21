using Npgsql;

namespace SkiApp.Services
{
    public class DbContext
    {
        private readonly string connectionString = "Host=192.168.21.37;Username=admin;Password=admin;Database=ski-lift-commander";

        public async Task<IEnumerable<T>> Query<T>(string query, Action<NpgsqlCommand> setParams) where T : new()
        {
            var result = new List<T>();

            await using var dataSource = NpgsqlDataSource.Create(connectionString);
            await using (var cmd = dataSource.CreateCommand(query))
            {
                setParams(cmd);
                await using (var reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        result.Add((T)Activator.CreateInstance(typeof(T), reader));
                    }
                }
            }

            return result;
        }

        public async Task Execute(Func<NpgsqlDataSource, Task> dbAction)
        {
            await using var dataSource = NpgsqlDataSource.Create(connectionString);
            await dbAction(dataSource);
        }
    }
}
