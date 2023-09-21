namespace SkiCommander.Models
{
    public record Customer
    {
        public Guid Id { get; set; }

        public String Email { get; set; }

        public String Username { get; set; }

        public String Name { get; set; }

        public String Surname { get; set; }

        public String PhoneNumber { get; set; }

        public String SaltedPassword { get; set; }
    }
}
