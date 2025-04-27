using Microsoft.Data.SqlClient;
using System.Data;

namespace LaboratorSGBD1
{
    public partial class Main : Form
    {

        private readonly string _connectionString;
        private readonly SqlConnection _connection;
        private readonly BindingSource _bindingSourceFd;
        private readonly BindingSource _bindingSourceMed;

        public Main(string connectionString)
        {
            InitializeComponent();
            _connectionString = connectionString;
            _connection = new SqlConnection(_connectionString);
            _bindingSourceFd = [];
            _bindingSourceMed = [];
        }

        private void Main_Load(object sender, EventArgs e)
        {
            try
            {
                _connection.Open();

                string query = "SELECT * FROM FARMACIE_DETALII";
                var adapter = new SqlDataAdapter(query, _connection);
                var dataSet = new DataSet();

                adapter.Fill(dataSet, "FARMACIE_DETALII");

                _bindingSourceFd.DataSource = dataSet.Tables["FARMACIE_DETALII"];
                FarmDetalii.DataSource = _bindingSourceFd;

                // selectare medicamente
                FarmDetalii.SelectionChanged += (s, e) =>
                {
                    if (FarmDetalii.SelectedRows.Count > 0)
                    {
                        try
                        {
                            var farmacieId = (int)FarmDetalii.SelectedRows[0].Cells["FarmacieId"].Value;
                            FarmacieIdInput.Text = farmacieId.ToString();
                            LoadMedicamente(farmacieId);
                        }
                        catch (Exception error)
                        {
                            MessageBox.Show("Nu a fost selectată nicio farmacie! " + error.Message);

                        }
                    }
                    else
                    {
                        MessageBox.Show("Nu a fost selectată nicio farmacie!");
                    }

                };

            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la încărcarea farmaciilor și pregatirea selectieti: " + error.Message);
            }
            finally
            {
                _connection.Close();
            }
        }

        private void LoadMedicamente(int farmacieId)
        {
            try
            {
                _connection.Open();
                string query = "SELECT * FROM MEDICAMENTE WHERE FarmacieId = @farmacieId";
                var adapter = new SqlDataAdapter(query, _connection);
                adapter.SelectCommand.Parameters.AddWithValue("@farmacieId", farmacieId);

                var dataTable = new DataTable();
                adapter.Fill(dataTable);


                _bindingSourceMed.DataSource = dataTable;
                Medicamente.DataSource = _bindingSourceMed;

            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la încărcarea medicamentelor" + error.Message);
            }
            finally
            {
                _connection.Close();
            }
        }

        private void DeleteMedicament_Click(object sender, EventArgs e)
        {
            try
            {
                _connection.Open();
                if (Medicamente.SelectedRows.Count > 0)
                {
                    var medicamentId = (int)Medicamente.SelectedRows[0].Cells["MedicamentId"].Value;
                    var confirmResult = MessageBox.Show("Sunteți sigur că doriți să ștergeți medicamentul?", "Confirmare ștergere", MessageBoxButtons.YesNo);
                    if (confirmResult == DialogResult.Yes)
                    {
                        var adapter = new SqlDataAdapter("SELECT * FROM MEDICAMENTE", _connection);
                        var dataSet = new DataSet();
                        adapter.Fill(dataSet, "MEDICAMENTE");

                        adapter.DeleteCommand = new SqlCommand("DELETE FROM MEDICAMENTE WHERE MedicamentId = @medicamentId", _connection);
                        adapter.DeleteCommand.Parameters.Add("@medicamentId", SqlDbType.Int).Value = medicamentId;
                        DataRow[] rows = dataSet.Tables["MEDICAMENTE"].Select($"MedicamentId = {medicamentId}");
                        if (rows.Length > 0)
                        {
                            rows[0].Delete();
                            adapter.Update(dataSet, "MEDICAMENTE");
                            MessageBox.Show("Medicament șters cu succes!");
                        }
                        else
                        {
                            MessageBox.Show("Medicamentul nu a fost găsit!");
                        }
                    }
                }
            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la ștergerea medicamentului" + error.Message);
            }
            finally
            {
                _connection.Close();

            }
            try
            {
                LoadMedicamente((int)FarmDetalii.SelectedRows[0].Cells["FarmacieId"].Value);
            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la încărcarea medicamentelor" + error.Message);
            }
        }
        private void UpdateMedicament_Click(object sender, EventArgs e)
        {
            try
            {
                _connection.Open();
                if (Medicamente.SelectedRows.Count > 0)
                {
                    var medicamentId = (int)Medicamente.SelectedRows[0].Cells["MedicamentId"].Value;
                    var farmacieId = (int)Medicamente.SelectedRows[0].Cells["FarmacieId"].Value;

                    string numeMed = NumeMedicamentInput.Text;
                    string descriere = DescriereInput.Text;
                    float pret = float.Parse(PretInput.Text);
                    int stoc = int.Parse(StocInput.Text);

                    var ResultMessage = MessageBox.Show("Sunteți sigur că doriți să actualizați medicamentul?", "Confirmare actualizare", MessageBoxButtons.YesNo);

                    if (ResultMessage == DialogResult.Yes)
                    {
                        var adapter = new SqlDataAdapter("SELECT * FROM MEDICAMENTE", _connection);
                        var dataSet = new DataSet();
                        adapter.Fill(dataSet, "MEDICAMENTE");
                        adapter.UpdateCommand = new SqlCommand("UPDATE MEDICAMENTE SET Nume = @numeMed, Descriere = @descriere, Pret = @pret, Stoc = @stoc WHERE MedicamentId = @medicamentId", _connection);
                        adapter.UpdateCommand.Parameters.Add("@numeMed", SqlDbType.NVarChar, 50, "Nume");
                        adapter.UpdateCommand.Parameters.Add("@descriere", SqlDbType.NVarChar, 500, "Descriere");
                        adapter.UpdateCommand.Parameters.Add("@pret", SqlDbType.Float, 50, "Pret");
                        adapter.UpdateCommand.Parameters.Add("@stoc", SqlDbType.Int, 50, "Stoc");
                        adapter.UpdateCommand.Parameters.Add("@medicamentId", SqlDbType.Int, 50, "MedicamentId");
                        DataRow[] rows = dataSet.Tables["MEDICAMENTE"].Select($"MedicamentId = {medicamentId}");
                        if (rows.Length > 0)
                        {
                            rows[0]["Nume"] = numeMed;
                            rows[0]["Descriere"] = descriere;
                            rows[0]["Pret"] = pret;
                            rows[0]["Stoc"] = stoc;
                            adapter.Update(dataSet, "MEDICAMENTE");
                            MessageBox.Show("Medicament actualizat cu succes!");
                        }
                        else
                        {
                            MessageBox.Show("Medicamentul nu a fost găsit!");
                        }
                    }
                }

            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la actualizarea medicamentului" + error.Message);
            }
            finally
            {
                _connection.Close();
            }
            try
            {
                LoadMedicamente((int)FarmDetalii.SelectedRows[0].Cells["FarmacieId"].Value);
            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la încărcarea medicamentelor" + error.Message);
            }
            ;
        }

        private void InsertMedicament_Click(object sender, EventArgs e)
        {
            try
            {
                _connection.Open();
                string numeMed = NumeMedicamentInput.Text;
                string descriere = DescriereInput.Text;
                float pret = float.Parse(PretInput.Text);
                int stoc = int.Parse(StocInput.Text);
                int farmacieId = int.Parse(FarmacieIdInput.Text);

                var ResultMessage = MessageBox.Show("Sunteți sigur că doriți să inserați medicamentul?", "Confirmare inserare", MessageBoxButtons.YesNo);
                if (ResultMessage == DialogResult.Yes)
                {
                    var adapter = new SqlDataAdapter("SELECT * FROM MEDICAMENTE", _connection);
                    var dataSet = new DataSet();
                    adapter.Fill(dataSet, "MEDICAMENTE");

                    adapter.InsertCommand = new SqlCommand("INSERT INTO MEDICAMENTE (Nume, Descriere, Pret, Stoc, FarmacieId) VALUES (@numeMed, @descriere, @pret, @stoc, @farmacieId)", _connection);
                    adapter.InsertCommand.Parameters.Add("@numeMed", SqlDbType.NVarChar, 50, "Nume");
                    adapter.InsertCommand.Parameters.Add("@descriere", SqlDbType.NVarChar, 50, "Descriere");
                    adapter.InsertCommand.Parameters.Add("@pret", SqlDbType.Float, 50, "Pret");
                    adapter.InsertCommand.Parameters.Add("@stoc", SqlDbType.Int, 50, "Stoc");
                    adapter.InsertCommand.Parameters.Add("@farmacieId", SqlDbType.Int, 50, "FarmacieId");

                    DataRow newRow = dataSet.Tables["MEDICAMENTE"].NewRow();
                    newRow["Nume"] = numeMed;
                    newRow["Descriere"] = descriere;
                    newRow["Pret"] = pret;
                    newRow["Stoc"] = stoc;
                    newRow["FarmacieId"] = farmacieId;

                    dataSet.Tables["MEDICAMENTE"].Rows.Add(newRow);
                    adapter.Update(dataSet, "MEDICAMENTE");

                    MessageBox.Show("Medicament inserat cu succes!");
                }
                else
                {
                    MessageBox.Show("Medicamentul nu a fost inserat!");
                }

            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la inserarea medicamentului" + error.Message);
            }
            finally
            {
                _connection.Close();
            }
            try
            {
                LoadMedicamente((int)FarmDetalii.SelectedRows[0].Cells["FarmacieId"].Value);
            }
            catch (Exception error)
            {
                MessageBox.Show("Eroare la încărcarea medicamentelor" + error.Message);
            }
        }
    }
}
