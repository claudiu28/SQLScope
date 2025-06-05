namespace practic_4
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            string conn = "Data Source=CLAUDIU\\SQLEXPRESS;Initial Catalog=Problema_4;Integrated Security=True;Trust Server Certificate=True";
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            Application.Run(new Main(conn));
        }
    }
}