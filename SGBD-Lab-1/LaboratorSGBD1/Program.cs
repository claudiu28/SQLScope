using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Drawing;

namespace LaboratorSGBD1
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {

            string ConnectionString = "Data Source=localhost\\SQLEXPRESS;Initial Catalog=SGBD_LAB_1;Integrated Security=True;Encrypt=True;Trust Server Certificate=True";

            ApplicationConfiguration.Initialize();
            Application.Run(new Main(ConnectionString));
        }
    }
}