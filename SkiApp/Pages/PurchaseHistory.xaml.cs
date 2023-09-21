namespace SkiApp.Pages;

public partial class PurchaseHistory : ContentPage
{
    public PurchaseHistory()
    {
        InitializeComponent();
    }

    private void OnPurchase(object sender, EventArgs e)
    {
        (sender as Button).Text = "Cash money";
    }
}
