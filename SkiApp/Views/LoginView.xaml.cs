using System.Windows.Input;

namespace SkiApp.Views
{

    public partial class LoginView : ContentPage
    {
        public string Login { get; set; } = "admin@wp.pl";
        public string Password { get; set; } = "default pass";

        public ICommand SignUpCommand => new Command(SignUp);
        public ICommand SignInCommand => new Command(SignIn);

        public LoginView()
        {
            InitializeComponent();

            BindingContext = this;
        }

        private async void SignIn()
        {
            await Navigation.PushAsync(new ProfileRegistrationView());
        }

        private async void SignUp()
        {
            await Navigation.PushAsync(new ProfileRegistrationView());
        }
    }
}
