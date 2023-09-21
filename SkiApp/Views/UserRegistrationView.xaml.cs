using System.Windows.Input;
using SkiApp.Entities;
using SkiApp.Services;

namespace SkiApp.Views
{
    public partial class UserRegistrationView : ContentPage
    {
        public string Password { get; set; } = "a";
        public string RepeatPassword { get; set; } = "a";
        public string Username { get; set; } = "a";

        public ICommand SignUpCommand => new Command(SignUp);

        private ProfileInfo profileInfo;

        public UserRegistrationView(ProfileInfo profileInfo)
        {
            this.profileInfo = profileInfo;

            InitializeComponent();

            BindingContext = this;
        }

        public async void SignUp()
        {
            var registrationService = new RegistrationService();
            var customer = new Customer
            {
                Id = Guid.NewGuid(),
                PhoneNumber = profileInfo.PhoneNumber,
                Username = Username,
                Name = profileInfo.FirstName,
                Email = profileInfo.Email,
                Surname = profileInfo.Surname,
                Password = Password
            };
            var customers = (await registrationService.Register(customer));

            foreach (var cust in customers)
            {
                await DisplayAlert("Customer alert", $"Meet: {cust.PhoneNumber}", "Acknowledged");
            }
        }
    }
}
