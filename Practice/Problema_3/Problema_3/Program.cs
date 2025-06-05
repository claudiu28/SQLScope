namespace Problema_3
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            string con = "Data Source=CLAUDIU\\SQLEXPRESS;Initial Catalog=Problema3;Integrated Security=True;Trust Server Certificate=True";
            ApplicationConfiguration.Initialize();
            Application.Run(new Main(con));
        }
    }
}