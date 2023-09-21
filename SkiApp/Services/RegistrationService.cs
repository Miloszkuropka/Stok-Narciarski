using Npgsql;
using SkiApp.Entities;

namespace SkiApp.Services
{
    public class RegistrationService
    {
        public RegistrationService()
        {

        }

        public async Task<IEnumerable<Customer>> Register(Customer newCustomer)
        {
            var errors = new List<string>();
            var dbContext = new DbContext();
            return await dbContext.Query<Customer>("SELECT * FROM \"Customers\"", (_) => { });
        }

    }
}
