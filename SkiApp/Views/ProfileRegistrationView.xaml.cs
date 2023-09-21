using System.Windows.Input;
using Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific;

namespace SkiApp.Views
{
    public record ProfileInfo(string FirstName, string Surname, string Email, string PhoneNumber);

    public partial class ProfileRegistrationView : ContentPage
    {
        public string FirstName { get; set; } = "a";
        public string Surname { get; set; } = "a";
        public string Email { get; set; } = "a";
        public string PhoneNumber { get; set; } = "1";

        public ICommand NextCommand => new Command(execute: Next, canExecute: CanProceed);

        bool isTransitioning;

        public ProfileRegistrationView()
        {
            InitializeComponent();

            BindingContext = this;

            App.Current.On<Microsoft.Maui.Controls.PlatformConfiguration.Android>().UseWindowSoftInputModeAdjust(WindowSoftInputModeAdjust.Resize);
        }

        private async void Next()
        {
            var errors = new List<String>();


            if (errors.Any())
            {
                await DisplayAlert("Invalid Profile Data", string.Join("\n", errors), "Ok");
            }
            else
            {
                isTransitioning = true;
                await Navigation.PushAsync(new UserRegistrationView(new ProfileInfo(FirstName, Surname, Email, PhoneNumber)));
                isTransitioning = false;
            }
        }

        private bool CanProceed()
        {
            return !string.IsNullOrEmpty(FirstName) && !string.IsNullOrEmpty(Surname) && !string.IsNullOrEmpty(Email) && !string.IsNullOrEmpty(PhoneNumber);
        }

    }
}
