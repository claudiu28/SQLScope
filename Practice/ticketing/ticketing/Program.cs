using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Drawing;

namespace ticketing
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            string con =
            "Data Source = CLAUDIU\\SQLEXPRESS; Initial Catalog = ticketing; Integrated Security = True; Trust Server Certificate = True";
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            Application.Run(new Main(con));
        }
    }
}