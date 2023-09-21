using QRCoder;

namespace SkiApp.Pages;

public partial class Tickets : ContentPage
{
    private ImageSource qrImageSource;

    public Tickets()
    {
        InitializeComponent();

        QRCodeGenerator qrGenerator = new QRCodeGenerator();
        QRCodeData qrCodeData = qrGenerator.CreateQrCode("https://www.youtube.com/watch?v=dQw4w9WgXcQ", QRCodeGenerator.ECCLevel.L);

        PngByteQRCode qRCode = new PngByteQRCode(qrCodeData);
        byte[] qrCodeBytes = qRCode.GetGraphic(20);
        qrImageSource = ImageSource.FromStream(() => new MemoryStream(qrCodeBytes));
    }

    protected override void OnAppearing()
    {
        QrCodeImage.Source = qrImageSource;
    }
}
