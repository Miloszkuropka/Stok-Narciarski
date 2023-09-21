using Stok_Narciarski.Model;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace Stok_Narciarski
{

    public partial class AdminWindow : Window
    {
        DatabaseConnection connection = new();
        DataValidation validation = new();
        Guid loggedUserId;

        DateTime startDateNewOffer = new();
        DateTime endDateNewOffer = new();
        DateTime startNewOffer = new();
        DateTime endNewOffer = new();
        PdfGenerator generator = new();
        string newOfferType = "periodic";
        public AdminWindow(Guid id)
        {
            InitializeComponent();
            base.WindowStartupLocation = System.Windows.WindowStartupLocation.CenterScreen;
            loggedUserId = id;
            RefreshTableData();
            RefreshCatnetData();
            DisplayDataSettingsAdmin();
            EnableOrDisableButtonAdd();
            periodic_radioButton.IsChecked = true;
            PriceList.IsReadOnly = true;
            EmployeesList.IsReadOnly = true;
            Customer_List.IsReadOnly = true;
            Remove_offer.IsEnabled = false;
        }

        private async void RefreshCatnetData()
        {
            PriceList.Items.Clear();
            List<TicketOffer> listOffers = new();
            listOffers = await connection.GetListOfTicketOffers();
            foreach (TicketOffer offer in listOffers)
            {
                if (offer.ticketType != "unactive")
                    PriceList.Items.Add(offer);
            }
        }

        private void Return(object sender, RoutedEventArgs e)
        {
            MainWindow m = new();
            m.Show();
            this.Close();
        }

        private async void MakeAssistant(object sender, RoutedEventArgs e)
        {
            if (Customer_List.SelectedItem != null)
            {
                try
                {
                    string guid = "";
                    bool checkIfAnonimExists = await connection.CheckIfUsernameIsUnique("anonimClient");
                    if (checkIfAnonimExists == false)
                    {
                        guid = await connection.GetClientGuidByUsername("anonimClient");

                    }
                    else
                    {
                        Customer anonim = new(Guid.NewGuid(), "456654456", "anonimClient", "anonimClient", "anonim@a.pl", "anonimClient", "anonimClient");
                        Task addCustomer = connection.CreateNewCustomer(anonim);
                        await addCustomer;
                        guid = await connection.GetClientGuidByUsername("anonimClient");
                    }


                    var customer = (Customer)Customer_List.SelectedItem;
                    Guid id = customer.id;
                    string phone = customer.phoneNumber;
                    string email = customer.email;
                    string name = customer.name;
                    string username = customer.username;
                    string password = customer.password;
                    string surname = customer.surname;
                    string role = "assistant";
                    Employee employee = new(id, phone, username, name, email, surname, password, role);

                    connection.UpdateCarnetClientId(id, Guid.Parse(guid));

                    connection.RemoveCustomerByID(id);
                    Task addEmployee = connection.CreateNewEmployee(employee);
                    await addEmployee;

                    RefreshTableData();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Błąd łączenia z bazą danych!");
                }
            }
            else MessageBox.Show("Nie wybrano klienta");
        }
        private async void RemoveAssistant(object sender, RoutedEventArgs e)
        {
            if (EmployeesList.SelectedItem != null)
            {
                try
                {
                    string guid = "";
                    bool checkIfAnonimExists = await connection.CheckIfSellerUsernameIsUnique("anonimSeller");
                    if (checkIfAnonimExists == false)
                    {
                        guid = await connection.GetSellerGuidByUsername("anonimSeller");

                    }
                    else
                    {
                        Employee anonim = new(Guid.NewGuid(), "456654456", "anonimSeller", "anonimSeller", "anonim@a.pl", "anonimSeller", "anonimSeller", "assistant");
                        Task add = connection.CreateNewEmployee(anonim);
                        await add;
                        guid = await connection.GetSellerGuidByUsername("anonimSeller");
                    }

                    var employee = (Employee)EmployeesList.SelectedItem;
                    Guid id = employee.id;
                    string phone = employee.phoneNumber;
                    string email = employee.email;
                    string username = employee.username;
                    string name = employee.name;
                    string password = employee.password;
                    string surname = employee.surname;
                    Customer customer = new(id, phone, username, name, email, surname, password);

                    connection.UpdateCarnetSellerId(id, Guid.Parse(guid));

                    connection.RemoveEmployeeByID(id);
                    Task addCustomer = connection.CreateNewCustomer(customer);
                    await addCustomer;

                    RefreshTableData();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Błąd łączenia z bazą danych!");
                }
            }
            else MessageBox.Show("Nie wybrano pracownika");
        }

        private void MakeAdmin(object sender, RoutedEventArgs e)
        {
            if (EmployeesList.SelectedItem != null)
            {
                var employee = (Employee)EmployeesList.SelectedItem;
                Guid id = employee.id;
                string role = "admin";
                if (employee.role.CompareTo("admin") == 0)
                {
                    MessageBox.Show("Wybrany pracownik jest administratorem");
                }
                else
                {
                    connection.UpdateRole(role, id);
                    RefreshEmployees();
                }
            }
            else MessageBox.Show("Nie wybrano pracownika");
        }
        private void RemoveAdmin(object sender, RoutedEventArgs e)
        {
            if (EmployeesList.SelectedItem != null)
            {
                var employee = (Employee)EmployeesList.SelectedItem;
                Guid id = employee.id;
                string role = "assistant";
                if (employee.role.CompareTo("assistant") == 0)
                {
                    MessageBox.Show("Wybrany pracownik ma role sprzedawcy");
                }
                else
                {
                    connection.UpdateRole(role, id);
                    RefreshEmployees();
                }

            }
            else MessageBox.Show("Nie wybrano pracownika");
        }


        private void Customer_List_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void PriceList_Copy_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void RefreshTableData()
        {
            RefreshTableCustomers();
            RefreshEmployees();
        }
        private async void RefreshTableCustomers()
        {
            Customer_List.Items.Clear();
            List<Customer> listOfCustomers = new();
            listOfCustomers = await connection.GetListOfCustomers();
            foreach (Customer customer in listOfCustomers)
            {
                Customer_List.Items.Add(customer);
            }

        }
        private async void RefreshEmployees()
        {
            EmployeesList.Items.Clear();
            List<Employee> listOfEmployees = new();
            listOfEmployees = await connection.GetListOfEmployees();
            foreach (Employee employee in listOfEmployees)
            {
                EmployeesList.Items.Add(employee);
            }
        }

        private void UpdateWeatherConditions(object sender, RoutedEventArgs e)
        {
            connection.AddWeatherConditions(temperature.Text, snow.Text);
        }

        private async void Change_Password_Admin(object sender, RoutedEventArgs e)
        {
            bool isValid = await connection.CheckOldPasswordAdmin(OldPassword.Password, loggedUserId);

            if (!isValid)
            {
                if (NewPassword.Password.Length < 3)
                {
                    MessageBox.Show("Hasło musi mieć przynajmiej 4 znaki!");
                }
                else if (NewPassword.Password.Equals(NewPasswordConfirm.Password))
                {
                    connection.ChangePasswordAdmin(NewPassword.Password, loggedUserId);
                    MessageBox.Show("Zmieniono haslo!");
                }
                else
                {
                    MessageBox.Show("Powtórzone hasło nie jest takie samo!");
                }
            }
            else
            {
                MessageBox.Show("Niepoprawne stare hasło!");
            }
        }

        private void ConfirmOldPassword(object sender, RoutedEventArgs e)
        {

        }
        private void ChangeNewPassword(object sender, RoutedEventArgs e)
        {

        }

        private void CofirmNewPassword(object sender, RoutedEventArgs e)
        {

        }

        private void username_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void imie_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void nazwisko_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void email_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void nr_tel_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void Update(object sender, RoutedEventArgs e)
        {
            if (username.Text.Length > 0)
            {
                connection.UpdateUsernameAdmin(username.Text, loggedUserId);
            }
            if (name.Text.Length > 0)
            {
                connection.UpdateNameAdmin(name.Text, loggedUserId);
            }
            if (surname.Text.Length > 0)
            {
                connection.UpdateSurnameAdmin(surname.Text, loggedUserId);
            }
            if (phone_number.Text.Length > 0)
            {
                connection.UpdatePhoneNumberAdmin(phone_number.Text, loggedUserId);
            }
            if (email.Text.Length > 0)
            {
                connection.UpdateEmailAdmin(email.Text, loggedUserId);
            }
            if (username.Text.Length > 0 || name.Text.Length > 0 || surname.Text.Length > 0 || phone_number.Text.Length > 0 || email.Text.Length > 0)
            {
                MessageBox.Show("Zaktualizowano!");
            }
        }


        async void DisplayDataSettingsAdmin()
        {
            Employee e = new Employee();
            e = await connection.GetCurrentlyLoggedEmployee(loggedUserId);
            username.Text = e.username;
            name.Text = e.name;
            surname.Text = e.surname;
            email.Text = e.email;
            phone_number.Text = e.phoneNumber;
        }



        private void RadioButton_Checked(object sender, RoutedEventArgs e)
        {

        }
        private void StartDatePickerChanged(object sender, SelectionChangedEventArgs e)
        {
            startDateNewOffer = (DateTime)StartDatePicker.SelectedDate;
            CalendarDateRange newCalendarDateRange = new(new DateTime(1, 1, 1), startDateNewOffer);
            EndDatePicker.BlackoutDates.Add(newCalendarDateRange);
            EnableOrDisableButtonAdd();
        }
        private void EndDatePickerChanged(object sender, SelectionChangedEventArgs e)
        {
            endDateNewOffer = (DateTime)EndDatePicker.SelectedDate;
            CalendarDateRange newCalendarDateRange = new(endDateNewOffer.AddDays(1), new DateTime(3000, 1, 1));
            StartDatePicker.BlackoutDates.Add(newCalendarDateRange);
            EnableOrDisableButtonAdd();
        }

        void Periodic_Type_Checked(object sender, RoutedEventArgs e)
        {
            newOfferType = "periodic";
            points.IsEnabled = false;
            days.IsEnabled = true;
            hours.IsEnabled = true;
            EnableOrDisableButtonAdd();
        }
        void Points_Type_Checked(object sender, RoutedEventArgs e)
        {
            newOfferType = "points";
            days.IsEnabled = false;
            hours.IsEnabled = false;
            points.IsEnabled = true;
            EnableOrDisableButtonAdd();
        }

        private void normal_price_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (normal_price.Text != "" && !Regex.IsMatch(normal_price.Text, @"^\d+(?:[.,]\d{0,3})?$"))
            {
                normal_price.Text = Regex.Replace(normal_price.Text, @"[^\d.,]", "");
                MessageBox.Show("Dostępne są tylko cyfry oraz {,.}");
            }
            if (normal_price.Text != "" && !Regex.IsMatch(normal_price.Text, @"^\d+(?:[.,]\d{0,2})?$"))
            {
                normal_price.Text = normal_price.Text.Substring(0, normal_price.Text.Length - 1);
                MessageBox.Show("Podaj maksymalnie dwie liczby po przecinku");
            }
            EnableOrDisableButtonAdd();
        }

        private void reduced_price_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (reduced_price.Text != "" && !Regex.IsMatch(reduced_price.Text, @"^\d+(?:[.,]\d{0,3})?$"))
            {
                reduced_price.Text = Regex.Replace(reduced_price.Text, @"[^\d.,]", "");
                MessageBox.Show("Dostępne są tylko cyfry oraz {,.}.");
            }
            if (reduced_price.Text != "" && !Regex.IsMatch(reduced_price.Text, @"^\d+(?:[.,]\d{0,2})?$"))
            {
                reduced_price.Text = reduced_price.Text.Substring(0, reduced_price.Text.Length - 1);
                MessageBox.Show("Podaj maksymalnie dwie liczby po przecinku");
            }
            EnableOrDisableButtonAdd();
        }

        private void days_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (days.Text != "" && !Regex.IsMatch(days.Text, @"^\d+$"))
            {
                days.Text = Regex.Replace(days.Text, @"[^\d]", "");
                MessageBox.Show("Dostępne są tylko cyfry.");
            }
            EnableOrDisableButtonAdd();
        }

        private void hours_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (hours.Text != "" && !Regex.IsMatch(hours.Text, @"^\d+$"))
            {
                hours.Text = Regex.Replace(hours.Text, @"[^\d]", "");
                MessageBox.Show("Dostępne są tylko cyfry.");
            }
            EnableOrDisableButtonAdd();
        }

        private void points_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (points.Text != "" && !Regex.IsMatch(points.Text, @"^\d+$"))
            {
                points.Text = Regex.Replace(points.Text, @"[^\d]", "");
                MessageBox.Show("Dostępne są tylko cyfry.");
            }
            EnableOrDisableButtonAdd();
        }

        private void Add_offer_Click(object sender, RoutedEventArgs e)
        {
            TicketOffer offer = new TicketOffer();
            offer.ticketType = newOfferType;
            offer.fullPrice = decimal.Parse(normal_price.Text);
            offer.reducedPrice = decimal.Parse(reduced_price.Text);
            offer.offerStarts = startDateNewOffer;
            offer.offerEnds = endDateNewOffer;
            if (newOfferType == "periodic")
            {
                if (hours.Text == "") hours.Text = "0";
                if (days.Text == "") days.Text = "0";
                offer.hours = Int32.Parse(hours.Text);
                offer.days = Int32.Parse(days.Text);
                offer.points = 0;
            }
            else
            {
                if (points.Text == "") points.Text = "0";
                offer.points = Int32.Parse(points.Text);
                offer.hours = 0;
                offer.days = 0;
            }
            string typeInPolish;
            if (offer.ticketType == "periodic") typeInPolish = "okresowy";
            else typeInPolish = "na punkty";
            var result = MessageBox.Show("Czy na pewno chcesz dodać ofertę\n na karnet " + typeInPolish + "\nw datach:" + startDateNewOffer.ToShortDateString()
                + " - " + endDateNewOffer.ToShortDateString() + "\nw cenach: " + offer.fullPrice + "PLN i " + offer.reducedPrice + "PLN"
                + "\n na dni: " + offer.days
                + "\n na godzin: " + offer.hours
                + "\n punktów: " + offer.points, "Potwierdzenie", MessageBoxButton.OKCancel); ;

            if (result == MessageBoxResult.OK)
            {
                connection.SaveOfferToDB(offer);
                RefreshCatnetData();
            }
        }

        private void Remove_offer_Click(object sender, RoutedEventArgs e)
        {
            var offer = (TicketOffer)PriceList.SelectedItem;
            string id = offer.id.ToString();
            var result = MessageBox.Show("Czy na pewno chcesz usunąć ofertę o ID: " + id + " ?", "Potwierdzenie", MessageBoxButton.OKCancel);

            if (result == MessageBoxResult.OK)
            {
                connection.RemoveOfferByID(offer.id);
                RefreshCatnetData();
            }
        }
        private void EnableOrDisableButtonAdd()
        {
            if (StartDatePicker.SelectedDate == null) Add_offer.IsEnabled = false;
            else if (EndDatePicker.SelectedDate == null) Add_offer.IsEnabled = false;
            else if (normal_price.Text == "") Add_offer.IsEnabled = false;
            else if (reduced_price.Text == "") Add_offer.IsEnabled = false;
            else if (newOfferType == "periodic" && (days.Text == "" || hours.Text == "")) Add_offer.IsEnabled = false;
            else if (newOfferType == "points" && points.Text == "") Add_offer.IsEnabled = false;
            else Add_offer.IsEnabled = true;
        }

        private void PriceList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Remove_offer.IsEnabled = true;
        }

        private void DowloadReport(object sender, RoutedEventArgs e)
        {
            if (StartPicker.SelectedDate == null || EndPicker.SelectedDate == null)
            {
                generator.ReportPdf(loggedUserId);
                MessageBox.Show("Raport ogolny został zapisany w folderze Raporty na pulpicie");
            }
            else
            {

                generator.DateReportPdf(loggedUserId, startNewOffer, endNewOffer);
                MessageBox.Show("Raport szczegolowy został zapisany w folderze Raporty na pulpicie");
            }

        }

        private void StartPickerChanged(object sender, SelectionChangedEventArgs e)
        {
            startNewOffer = (DateTime)StartPicker.SelectedDate;
            CalendarDateRange newCalendarDateRange = new(new DateTime(1, 1, 1), startNewOffer);
            EndPicker.BlackoutDates.Add(newCalendarDateRange);
        }
        private void EndPickerChanged(object sender, SelectionChangedEventArgs e)
        {
            endNewOffer = (DateTime)EndPicker.SelectedDate;
        }

        private void Window_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.F1)
            {
                e.Handled = true;
                if (Conditions.IsSelected)
                    MessageBox.Show("1. Aby zaktualizować warunki na stoku:\n" +
                        "- Wpisz w odpowiednie pola wartości temperatury i centymetrów śniegu\n" +
                        "- Naciśnij przycisk Aktualizuj");
                else if (price_list.IsSelected)
                    MessageBox.Show("1. Aby ofertę karnetu z cennika:\n" +
                        "- Wybierz odpowiedni karnet z listy\n" +
                        "- Naciśnij przycisk Usuń\n" +
                        "2. Aby dodać ofertę:\n" +
                        "- Wybierz datę rozpoczęcia oraz zakończenia oferty\n" +
                        "- Wybierz typ karnetu zaznaczając odpowiednią opcję\n" +
                        "- Wpisz cenę regularną oraz normalną\n" +
                        "- Jeśli wybrałeś typ karnetu jako okresowy wpisz ilość dni oraz godzin trwania karnetu\n" +
                        "Jeśli wybrałeś karnetu na punkty wpisz ilość punktów przypisaną do oferty\n" +
                        "- Naciśnij przycisk Dodaj");
                else if (permitions.IsSelected)
                    MessageBox.Show("1. Aby nadać lub odebrać uprawnienia sprzedawcy:\n" +
                        "- Wybierz z listy Klienci osobę której status chcesz zmienić\n" +
                        "- Naciśnij odpowiedni przycisk znajdujący się pod listą klientów\n" +
                        "2. Aby nadać lub odebrać uprawnienia administratora:\n" +
                        "- Wybierz z listy Pracownicy osobę której status chcesz zmienić\n" +
                        "- Naciśnij odpowiedni przycisk znajdujący się pod listą pracowników");
                else MessageBox.Show("1. Aby zaktualizować swoje dane:\n" +
                    "- Wypełnij pola nowymi danymi jeśli chcesz je zmienić i obecnymi jeśli mają pozostać niezmienne\n" +
                    "- Naciśnij przycisk aktualizuj\n" +
                    "2. Aby zmienić hasło:\n" +
                    "- Wpisz obecne hasło\n" +
                    "- Wpisz nowe hasło oraz potwierdź je\n" +
                    "- Naciśnij przycisk aktualizuj\n" +
                    "3. Naciśnij przycisk Wyloguj, aby wrócić do okna logowania");
            }
        }

    }
}
