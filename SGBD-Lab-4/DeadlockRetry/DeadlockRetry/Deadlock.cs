using Microsoft.Data.SqlClient;
namespace DeadlockRetry
{
    class Deadlock
    {
        static readonly string connectionString = "Data Source=Claudiu\\SQLEXPRESS;Initial Catalog=DeadlockTest;Integrated Security=True;Trust Server Certificate=True";
        static readonly int maxRetryCount = 3;
        static async Task Main()
        {
            Console.WriteLine("Starting deadlock simulation...");
            Console.WriteLine("Number of retries: " + maxRetryCount);

            Task thread1 = Task.Run(() => SimulateDeadlock("Thread 1", ExecuteTransaction1));
            await Task.Delay(1000);
            Task thread2 = Task.Run(() => SimulateDeadlock("Thread 2", ExecuteTransaction2));

            await Task.WhenAll(thread1, thread2);

            Console.WriteLine("Deadlock simulation completed.");
        }

        static async Task SimulateDeadlock(string threadName, Action<string> transactionAction)
        {
            int retryCount = 0;
            bool success = false;
            while (success == false && retryCount < maxRetryCount)
            {
                try
                {
                    Console.WriteLine($"{threadName}: Attempt {retryCount + 1}");
                    transactionAction(threadName);
                    success = true;
                    Console.WriteLine($"{threadName}: Transaction completed successfully.");
                }
                catch (SqlException ex) when (ex.Number == 1205) 
                {
                    Console.WriteLine($"{threadName}: Deadlock detected. Retrying...");
                    retryCount++;
                    if (retryCount == maxRetryCount)
                    {
                        await Task.Delay(2000);
                        Console.WriteLine($"{threadName}: Max retries reached. Exiting.");
                    }
                }
            }
        }


        static void  ExecuteTransaction1(string th)
        {
            using SqlConnection conn = new(connectionString);
            conn.Open();
            using SqlTransaction transaction = conn.BeginTransaction();
            try { 
                Console.WriteLine("Thread 1: Starting transaction 1");

                using SqlCommand command1 = new("UPDATE MEDICAMENTE SET Stoc = 600 WHERE MedicamentId = 1", conn, transaction);
                command1.ExecuteNonQuery();
                Console.WriteLine("Thread 1: Updated Stoc for MedicamentId 1");

                Console.WriteLine($"{th}: Wait 2 secunde...");
                Thread.Sleep(2000);

                using SqlCommand command2 = new("UPDATE CATEGORIE SET NumeCategorie = 'NumeCategorie' WHERE CategorieId = 1", conn, transaction);
                command2.ExecuteNonQuery();
                Console.WriteLine("Thread 1: Updated NumeCategorie for CategorieId 1");

                transaction.Commit();
            }
            catch
            {
                Console.WriteLine("Thread 1: Transaction failed, rolling back...");
                transaction.Rollback();
                throw;
            }
        }

        static void ExecuteTransaction2(string th)
        {
            using SqlConnection conn = new(connectionString);
            conn.Open();
            using SqlTransaction transaction = conn.BeginTransaction();
            try
            {
                Console.WriteLine("Thread 2: Starting transaction 2");

                using SqlCommand command2 = new("UPDATE CATEGORIE SET NumeCategorie = 'PrenumeCategorie' WHERE CategorieId = 1", conn, transaction);
                command2.ExecuteNonQuery();
                Console.WriteLine("Thread 2: Updated NumeCategorie for CategorieId 1");

                Console.WriteLine($"{th}: Wait 2 secunde...");
                Thread.Sleep(2000);

                using SqlCommand command1 = new("UPDATE MEDICAMENTE SET Stoc = 700 WHERE MedicamentId = 1", conn, transaction);
                command1.ExecuteNonQuery();
                Console.WriteLine("Thread 2: Updated Stoc for MedicamentId 1");

                transaction.Commit();
            }
            catch
            {
                Console.WriteLine("Thread 2: Transaction failed, rolling back...");
                transaction.Rollback();
                throw;
            }
        }
    }
}
