namespace PracticExamen
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            string connection_string = "Data Source=CLAUDIU\\SQLEXPRESS;Initial Catalog=practic;Integrated Security=True;Trust Server Certificate=True";
 
            ApplicationConfiguration.Initialize();
            Application.Run(new Main(connection_string));
        }
    }
}