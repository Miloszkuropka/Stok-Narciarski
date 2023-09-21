using Npgsql;

namespace SkiApp.Entities
{
    public record Customer
    {
        public Guid Id { get; init; }
        public string PhoneNumber { get; init; }
        public string Username { get; init; }
        public string Name { get; init; }
        public string Email { get; init; }
        public string Surname { get; init; }
        public string Password { get; init; }

        public Customer() { }

        public Customer(NpgsqlDataReader reader)
        {
            Guid Id = reader.GetGuid(0);
            string PhoneNumber = reader.GetString(1);
            string Username = reader.GetString(2);
            string Name = reader.GetString(3);

            this.Id = Id;
            this.PhoneNumber = PhoneNumber;
            this.Username = Username;
            this.Name = Name;
            this.Email = "";
            this.Surname = "";
            this.Password = "";
        }
    };

}
