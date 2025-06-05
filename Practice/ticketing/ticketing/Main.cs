using Microsoft.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace ticketing
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
                string query = "select * from clienti";
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
                string query = "select * from ticket where client_id = @id";
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

                string query = "update ticket set nume_ticket = @name, pret_ticket = @pret, eveniment = @eveniment, locuri = @locuri where id = @id";
                SqlCommand command = new(query, connection);
                command.Parameters.AddWithValue("@name", textBox1.Text);
                command.Parameters.AddWithValue("@eveniment", textBox3.Text);
                command.Parameters.AddWithValue("@pret", Convert.ToDecimal(numericUpDown1.Value));
                command.Parameters.AddWithValue("@locuri", Convert.ToInt32(numericUpDown2.Value));
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
                string query = "delete from ticket where id = @id";
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
                string query = "insert into ticket(nume_ticket,pret_ticket,eveniment,locuri, client_id) values (@nume_ticket,@pret_ticket,@eveniment,@locuri, @client_id)";
                SqlCommand command = new(query, connection);
                command.Parameters.AddWithValue("@nume_ticket", textBox1.Text);
                command.Parameters.AddWithValue("@eveniment", textBox3.Text);
                command.Parameters.AddWithValue("@pret_ticket", Convert.ToDecimal(numericUpDown1.Value));
                command.Parameters.AddWithValue("@locuri", Convert.ToInt32(numericUpDown2.Value));
                command.Parameters.AddWithValue("@client_id", Convert.ToInt32(textBox2.Text));
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
