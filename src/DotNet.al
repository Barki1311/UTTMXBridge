dotnet
{
    assembly(System.Data)
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type(System.Data.SqlClient.SqlCommand; SQLCommand) { }
        type(System.Data.SqlClient.SqlConnection; SQLConnection) { }
    }

    assembly(mscorlib)
    {
        type("System.IO.MemoryStream"; System_IO_MemoryStream) { }
    }

    assembly(System.Drawing)
    {
        type("System.Drawing.Bitmap"; System_Drawing_Bitmap) { }
        type("System.Drawing.Imaging.ImageFormat"; System_Drawing_Imaging_ImageFormat) { }
        type("System.Drawing.RotateFlipType"; System_Drawing_RotateFlipType) { }
    }

    assembly(zxing)
    {
        type("ZXing.BarcodeWriter"; ZXing_BarcodeWriter) { }
        type("ZXing.BarcodeFormat"; ZXing_BarcodeFormat) { }
        type("ZXing.Common.EncodingOptions"; ZXing_Common_EncodingOptions) { }
        type("ZXing.Common.BitMatrix"; ZXing_Common_BitMatrix) { }
    }
}