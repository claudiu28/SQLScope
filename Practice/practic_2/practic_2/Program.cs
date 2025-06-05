namespace practic_2
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            string conn_string = "Data Source=CLAUDIU\\SQLEXPRESS;Initial Catalog=Problema2;Integrated Security=True;Trust Server Certificate=True";
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            Application.Run(new Main(conn_string));
        }
    }
}