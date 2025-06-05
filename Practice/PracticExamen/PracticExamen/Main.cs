using Microsoft.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace PracticExamen
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
                string query = "select * from facultate";
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
                string query = "select * from profesor where facultate_id = @id";
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

                string query = "update profesor set nume = @name, prenume = @prenume, grad = @grad where id = @id";
                SqlCommand command = new(query, connection);
                command.Parameters.AddWithValue("@name", textBox1.Text);
                command.Parameters.AddWithValue("@prenume", textBox4.Text);
                command.Parameters.AddWithValue("@grad", textBox3.Text);
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
                string query = "delete from profesor where id = @id";
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
                string query = "insert into profesor(nume,prenume,grad,facultate_id,data_angajare) values (@nume,@prenume,@grad,@facultate_id,@data_angajare)";
                SqlCommand command = new(query, connection);
                command.Parameters.AddWithValue("@nume", textBox1.Text);
                command.Parameters.AddWithValue("@prenume", textBox4.Text);
                command.Parameters.AddWithValue("@grad", textBox3.Text);
                command.Parameters.AddWithValue("@data_angajare", Convert.ToDateTime(dateTimePicker1.Value));
                command.Parameters.AddWithValue("@facultate_id", Convert.ToInt32(textBox2.Text));
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
