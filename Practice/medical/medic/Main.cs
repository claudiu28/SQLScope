using Microsoft.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace medic
{
    public partial class Main : Form
    {
        private readonly string connectionString;
        private readonly SqlConnection connection;
        public Main(string ConnString)
        {
            connectionString = ConnString;
            connection = new SqlConnection(connectionString);
            InitializeComponent();
        }

        private void Main_Load(object sender, EventArgs e)
        {
            try
            {
                connection.Open();
                string query = "select * from pacient";
                SqlDataAdapter adapter = new(query, connection);
                DataTable dataTable = new();
                adapter.Fill(dataTable);
                dataGridView1.DataSource = dataTable;

                dataGridView1.SelectionChanged += DataGridView1_SelectionChanged!;
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                connection.Close();
            }
        }

        private void DataGridView1_SelectionChanged(object? sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                int idParent = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value);
                Load_Child(idParent);
            }
        }

        private void Load_Child(int idParent)
        {
            try
            {
                connection.Open();
                string query = "select * from programari where id_pacient = @id";
                SqlDataAdapter adapter = new(query, connection);
                adapter.SelectCommand.Parameters.AddWithValue("@id", idParent);
                DataTable dataTable = new();
                adapter.Fill(dataTable);
                dataGridView2.DataSource = dataTable;
                textBox2.Text = idParent.ToString();
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                connection.Close();
            }
        }


        private void Modify_Click(object sender, EventArgs e)
        {
            try
            {
                connection.Open();
                if (dataGridView2.SelectedRows.Count == 0)
                {
                    MessageBox.Show("Select a row to modify.");
                    return;
                }

                string query = "update programari set nume = @name where id = @id";
                SqlCommand command = new(query, connection);
                command.Parameters.AddWithValue("@name", textBox1.Text);
                command.Parameters.AddWithValue("@id", Convert.ToInt32(dataGridView2.SelectedRows[0].Cells[0].Value));
                command.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                connection.Close();
            }
            Load_Child(Convert.ToInt32(textBox2.Text));
        }


        private void Delete_Click(object sender, EventArgs e)
        {
            try
            {
                connection.Open();
                if (dataGridView2.SelectedRows.Count == 0)
                {
                    MessageBox.Show("Select a row to delete.");
                    return;
                }
                string query = "delete from programari where id = @id";
                SqlCommand command = new(query, connection);
                command.Parameters.AddWithValue("@id", Convert.ToInt32(dataGridView2.SelectedRows[0].Cells[0].Value));
                command.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                connection.Close();
            }
            Load_Child(Convert.ToInt32(textBox2.Text));
        }

        private void Save_Click(object sender, EventArgs e)
        {
            try
            {
                connection.Open();
                string query = "insert into programari (nume, id_pacient) values (@nume,@id_pacient)";
                SqlCommand command = new(query, connection);
                command.Parameters.AddWithValue("@nume", textBox1.Text);
                command.Parameters.AddWithValue("@id_pacient", Convert.ToInt32(textBox2.Text));
                command.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                connection.Close();
            }
            Load_Child(Convert.ToInt32(textBox2.Text));
        }

    }
}
