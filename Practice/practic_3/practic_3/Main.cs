using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace practic_3
{
    public partial class Main : Form
    {
        private readonly string ConnectionString;
        private readonly SqlConnection Connection;
        public Main(string connectionString)
        {
            InitializeComponent();
            ConnectionString = connectionString;
            Connection = new SqlConnection(ConnectionString);

        }

        private void Main_Load(object sender, EventArgs e)
        {
            try
            {
                Connection.Open();
                SqlDataAdapter adapter = new("select * from producator", Connection);
                DataTable biscuitiTable = new();
                adapter.Fill(biscuitiTable);
                dataGridView1.DataSource = biscuitiTable;
                dataGridView1.SelectionChanged += DataGridView1_SelectionChanged;
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message);
            }
            finally
            {
                Connection.Close();
            }
        }

        private void DataGridView1_SelectionChanged(object? sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                LoadChild(Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value));
            }
        }

        private void LoadChild(int childId)
        {
            try
            {
                Connection.Open();
                string query = "select * from biscuiti where producator_id = @ProducatorId";
                SqlDataAdapter adapter = new(query, Connection);
                adapter.SelectCommand.Parameters.AddWithValue("@ProducatorId", childId);
                DataTable biscuitiTable = new();
                adapter.Fill(biscuitiTable);
                dataGridView2.DataSource = biscuitiTable;
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message);
            }
            finally
            {
                Connection.Close();
            }
        }

        private void Save_Click(object sender, EventArgs e)
        {
            try
            {
                Connection.Open();
                string query = "insert into biscuiti (nume, numar_biscuiti, producator_id) values (@Nume, @Numar, @ProducatorId)";
                SqlCommand command = new(query, Connection);
                command.Parameters.AddWithValue("@Nume", textBox1.Text);
                command.Parameters.AddWithValue("@Numar", Convert.ToInt32(numericUpDown1.Value));
                command.Parameters.AddWithValue("@ProducatorId", Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value));
                command.ExecuteNonQuery();
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message);
            }
            finally
            {
                Connection.Close();
            }
            LoadChild(Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value));
        }

        private void Modify_Click(object sender, EventArgs e)
        {
            try
            {
                Connection.Open();
                string query = "update biscuiti set nume = @Nume, numar_biscuiti = @Numar where id = @Id";
                SqlCommand command = new(query, Connection);
                command.Parameters.AddWithValue("@Nume", textBox1.Text);
                command.Parameters.AddWithValue("@Numar", Convert.ToInt32(numericUpDown1.Value));
                command.Parameters.AddWithValue("@Id", Convert.ToInt32(dataGridView2.SelectedRows[0].Cells[0].Value));
                command.ExecuteNonQuery();
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message);
            }
            finally
            {
                Connection.Close();
            }
            LoadChild(Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value));
        }

        private void Delete_Click(object sender, EventArgs e)
        {
            try
            {
                Connection.Open();
                string query = "delete from biscuiti where id = @Id";
                SqlCommand command = new(query, Connection);
                command.Parameters.AddWithValue("@Id", Convert.ToInt32(dataGridView2.SelectedRows[0].Cells[0].Value));
                command.ExecuteNonQuery();
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message);
            }
            finally
            {
                Connection.Close();
            }
            LoadChild(Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value));
        }
    }
}
