using Microsoft.Data.SqlClient;
using Microsoft.VisualBasic;
using SGBD_Lab_2.Models;
using System.Data;
using System.Drawing.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace SGBD_Lab_2
{
    public partial class App : Form
    {
        private readonly string jsonText;
        private readonly Config? config;
        private readonly JsonSerializerOptions jsonSerializerOptions;
        private readonly string ConnectionString;
        private readonly DataSet DataSetCache;
        private readonly SqlConnection Connection;
        private SqlDataAdapter AdapterChild;
        private SqlDataAdapter AdapterParent;
        private readonly BindingSource BindingChild;
        private readonly BindingSource BindingParent;

        public App()
        {
            jsonSerializerOptions = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
            try
            {
                jsonText = File.ReadAllText("Scenariu1.json");
                config = JsonSerializer.Deserialize<Config>(jsonText, jsonSerializerOptions);
                if (config == null)
                {
                    throw new Exception("Config is null!");
                }
                ConnectionString = config.ConnectionString;
                if (ConnectionString == null)
                {
                    throw new Exception("ConnectionString null");
                }

                Connection = new SqlConnection(ConnectionString);
                DataSetCache = new DataSet();
                BindingChild = [];
                BindingParent = [];

                InitializeComponent();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void App_Load(object sender, EventArgs e)
        {
            try
            {
                if (config == null)
                {
                    throw new Exception("Config is null!");
                }
                this.Text = config.Title;
                Connection.Open();

                var parent = new DataTable(config.Parent.Table);
                AdapterParent = new SqlDataAdapter(config.Parent.SelectCommand, Connection);
                AdapterParent.Fill(parent);
                DataSetCache.Tables.Add(parent);
                BindingParent.DataSource = DataSetCache.Tables[config.Parent.Table];
                ParentTable.DataSource = BindingParent;

                ParentTable.SelectionChanged += (sender, e) =>
                {
                    if (ParentTable.SelectedRows.Count > 0)
                    {
                        int id = Convert.ToInt32(ParentTable.SelectedRows[0].Cells[0].Value);
                        LoadChild(id);
                    }
                };
            }catch(Exception err)
            {
                MessageBox.Show(err.Message);
            }
        }

        private void LoadChild(int id)
        {
            try
            {
                if (config == null)
                {
                    throw new Exception("Config is null!");
                }

                if (DataSetCache.Tables.Contains(config.Child.Table))
                {
                    DataSetCache.Tables.Remove(config.Child.Table);
                }

                using var command = new SqlCommand(config.Child.SelectCommand, Connection);
                command.Parameters.AddWithValue("@id", id);
                AdapterChild = new SqlDataAdapter(command);
                var child = new DataTable(config.Child.Table);
                AdapterChild.Fill(child);
                DataSetCache.Tables.Add(child);

                BindingChild.DataSource = DataSetCache.Tables[config.Child.Table];
                ChildTable.DataSource = BindingChild;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void GenerateLabelAndInputs(Panel panel, string operation)
        {
            try
            {
                if (config == null)
                {
                    throw new Exception("Config is null");
                }
                if (operation == "Insert")
                {
                    MessageBox.Show("Insert in child table!");
                }else if (operation == "Update")
                {
                    MessageBox.Show("Update in child table!");
                }
                    int oy = 10;
                panel.Controls.Clear();
                var columns = config.Child.Columns.ToList();
                for (var i = 1; i < columns.Count - 1; i++)
                {
                    var label = new Label
                    {
                        Text = columns[i].Name,
                        Location = new Point(10, oy),
                        AutoSize = true,
                    };
                    panel.Controls.Add(label);

                    if (columns[i].Type == "varchar")
                    {
                        var text = new TextBox()
                        {
                            Name = "Input_" + columns[i].Name,
                            Location = new Point(120, oy - 3),
                            Width = 200,
                        };
                        panel.Controls.Add(text);
                    }
                    else if (columns[i].Type == "int")
                    {
                        var text = new NumericUpDown()
                        {
                            Name = "Input_" + columns[i].Name,
                            Location = new Point(120, oy - 3),
                            Width = 200,
                            Maximum = 1000,
                            Minimum = 1

                        };
                        panel.Controls.Add(text);
                    }
                    else if (columns[i].Type == "float" || columns[i].Type == "double")
                    {
                        var text = new NumericUpDown()
                        {
                            Name = "Input_" + columns[i].Name,
                            Location = new Point(120, oy - 3),
                            Width = 200,
                            Maximum = 1000,
                            Minimum = 1,
                            DecimalPlaces = 2,
                            Increment = 1
                        };
                        panel.Controls.Add(text);
                    }
                    else if (columns[i].Type == "date")
                    {
                        var dateTimePicker = new DateTimePicker()
                        {
                            Name = "Input_" + columns[i].Name,
                            Location = new Point(120, oy - 3),
                            Width = 200,
                            Format = DateTimePickerFormat.Short,
                            Value = DateTime.Today
                        };
                        panel.Controls.Add(dateTimePicker);
                    }
                    oy += 30;
                }
                var button = new Button()
                {
                    Text = "Execute",
                    Name = "Execute",
                    Tag = operation,
                    Location = new Point(120, oy + 40),
                    Height = 200,
                    Width = 400,
                };
                button.Click += new EventHandler(SwitchTags);
                panel.Controls.Add(button);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void SwitchTags(object? sender, EventArgs e)
        {
            if (sender is not Button execute)
            {
                throw new Exception("Button de executare nu poate fii accesat!");
            }

            var tags = execute.Tag ?? throw new Exception("Tag is null");

            if (tags.ToString() == "Insert")
            {
                InsertOperation();
            }
            else if (tags.ToString() == "Update")
            {
                UpdateOperation();
            }
        }

        private async void UpdateButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ParentTable.SelectedRows.Count) == 0)
                {
                    throw new Exception("Row was not selected!");
                }

                if (config == null)
                {
                    throw new Exception("Config is null");
                }
                await Task.Delay(500);
                GenerateLabelAndInputs(PanelContainer, "Update");
            }catch (Exception err)
            {
                MessageBox.Show(err.Message);
            }
        }
        private void InsertOperation()
        {
            try
            {
                if (config == null)
                {
                    throw new Exception("Config is null");
                }

                if (ParentTable.SelectedRows.Count == 0)
                {
                    throw new Exception("Parent row not selected");
                }

                int parentId = Convert.ToInt32(ParentTable.SelectedRows[0].Cells[0].Value);

                var sqlCommand = new SqlCommand(config.Child.InsertCommand, Connection);
                sqlCommand.Parameters.AddWithValue($"@{config.Child.Columns[^1].Name.ToLower()}", parentId);

                foreach (var column in config.Child.Columns.Skip(1))
                {
                    if (column.Name == config.Child.Columns[^1].Name)
                    {
                        continue;
                    }

                    string controlName = "Input_" + column.Name;
                    var control = PanelContainer.Controls.Find(controlName, true).FirstOrDefault();
                    if (control != null)
                    {
                        object? val = null;
                        if (control is TextBox text)
                        {
                            val = text.Text;
                        }
                        else if (control is NumericUpDown num)
                        {
                            val = num.Value;
                        }else if(control is DateTimePicker dateTimePicker)
                        {
                            val = dateTimePicker.Value;
                        }
                        sqlCommand.Parameters.AddWithValue($"@{column.Name.ToLower()}", val);
                    }
                }

                AdapterChild.InsertCommand = sqlCommand;

                DataTable child = DataSetCache.Tables[config.Child.Table] ?? throw new Exception("Table child is null in data set");
                DataRow newRow = child.NewRow();

                newRow[config.Child.Columns[^1].Name] = parentId;
                foreach (var column in config.Child.Columns.Skip(1))
                {
                    if (column.Name == config.Child.Columns[^1].Name)
                    {
                        continue;
                    }
                    string controlName = "Input_" + column.Name;
                    var control = PanelContainer.Controls.Find(controlName, true).FirstOrDefault();
                    if (control != null)
                    {
                        object? val = null;
                        if (control is TextBox text)
                        {
                            val = text.Text;
                        }
                        else if (control is NumericUpDown num)
                        {
                            val = num.Value;
                        }
                        else if (control is DateTimePicker dateTimePicker)
                        {
                            val = dateTimePicker.Value;
                        }
                        newRow[column.Name] = val;
                    }
                }

                child.Rows.Add(newRow);

                AdapterChild.Update(DataSetCache, config.Child.Table);
                LoadChild(parentId);
                ClearInputs();
                MessageBox.Show("Data inserted successfully!", "Success", MessageBoxButtons.OK);
            }

            catch (Exception ex)
            {
                MessageBox.Show("Insert failed:" + ex.Message);
            }
        }


        private void ClearInputs()
        {
            if (config == null)
            {
                throw new Exception("Config is null!");
            }
            foreach (var column in config.Child.Columns.Skip(1))
            {
                if (column.Name == config.Parent.Columns[^1].Name)
                {
                    continue;
                }
                string controlName = "Input_" + column.Name;
                var control = PanelContainer.Controls.Find(controlName, true).FirstOrDefault();
                if (control != null)
                {
                    if (control is TextBox text)
                    {
                        text.Text = string.Empty;
                    }
                    else if (control is NumericUpDown num)
                    {
                        num.Value = num.Minimum;
                    }
                    else if (control is DateTimePicker dateTimePicker)
                    {
                        dateTimePicker.Value = DateTime.Today;
                    }
                }
            }
        }

        private void UpdateOperation()
        {
            try
            {
                if (config == null)
                {
                    throw new Exception("Config is null");
                }

                if (ParentTable.SelectedRows.Count == 0)
                {
                    throw new Exception("Parent row not selected");
                }

                int id = Convert.ToInt32(ChildTable.SelectedRows[0].Cells[0].Value);

                var sqlCommand = new SqlCommand(config.Child.UpdateCommand, Connection);
                sqlCommand.Parameters.AddWithValue($"@id", id);

                foreach (var column in config.Child.Columns.Skip(1))
                {
                    if (column.Name == config.Child.Columns[^1].Name)
                    {
                        continue;
                    }

                    string controlName = "Input_" + column.Name;
                    var control = PanelContainer.Controls.Find(controlName, true).FirstOrDefault();
                    if (control != null)
                    {
                        object? val = null;
                        if (control is TextBox text)
                        {
                            val = text.Text;
                        }
                        else if (control is NumericUpDown num)
                        {
                            val = num.Value;
                        }
                        else if(control is DateTimePicker dateTimePicker)
                        {
                            val  = dateTimePicker.Value;
                        }
                        sqlCommand.Parameters.AddWithValue($"@{column.Name.ToLower()}", val);
                    }
                }

                AdapterChild.UpdateCommand = sqlCommand;

                DataTable child = DataSetCache.Tables[config.Child.Table] ?? throw new Exception("Table child is null in data set");
                DataRow[] rows = child.Select($"{config.Child.Columns[0].Name} = {id}");

                if (rows.Length > 0)
                {
                    DataRow toUpdate = rows[0];

                    foreach (var column in config.Child.Columns.Skip(1))
                    {
                        if (column.Name == config.Child.Columns[^1].Name)
                        {
                            continue;
                        }

                        string controlName = "Input_" + column.Name;
                        var control = PanelContainer.Controls.Find(controlName, true).FirstOrDefault();
                        if (control != null)
                        {
                            object? val = null;
                            if (control is TextBox text)
                            {
                                val = text.Text;
                            }
                            else if (control is NumericUpDown num)
                            {
                                val = num.Value;
                            }else if(control is DateTimePicker dateTimePicker)
                            {
                                val = dateTimePicker.Value;
                            }
                            toUpdate[column.Name] = val;
                        }
                    }
                    AdapterChild.Update(DataSetCache, config.Child.Table);
                    var parentId = Convert.ToInt32(ParentTable.SelectedRows[0].Cells[0].Value);
                    LoadChild(parentId);
                    MessageBox.Show("Data updated successfully!", "Success", MessageBoxButtons.OK);
                    ClearInputs();
                }
            }

            catch (Exception ex)
            {
                MessageBox.Show("Update failed:" + ex.Message);
            }
        }

        private async void InsertButton_Click(object sender, EventArgs e)
        { 

            if (config == null)
            {
                throw new Exception("Config is null");
            }

            await Task.Delay(500);
            GenerateLabelAndInputs(PanelContainer, "Insert");
        }

        private void DeleteButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (config == null)
                    throw new Exception("Config is null");

                if (ParentTable.SelectedRows.Count == 0)
                    throw new Exception("Row was not selected!");

                if (ChildTable.SelectedRows.Count == 0)
                    throw new Exception("Row in child must be selected for deleting!");

                int id = Convert.ToInt32(ChildTable.SelectedRows[0].Cells[0].Value);

                var sqlCommand = new SqlCommand(config.Child.DeleteCommand, Connection);
                sqlCommand.Parameters.AddWithValue("@id", id);

                AdapterChild.DeleteCommand = sqlCommand;

                var table = DataSetCache.Tables[config.Child.Table] ?? throw new Exception("Table not found!");

                DataRow[] rows = table.Select($"{config.Child.Columns[0].Name} = {id}");

                if (rows.Length > 0)
                {
                    rows[0].Delete();
                    AdapterChild.Update(DataSetCache, config.Child.Table);
                    MessageBox.Show("Delete made with success");
                }
                else
                {
                    MessageBox.Show("Row not found in dataset.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Something went wrong: " + ex.Message);
            }

            LoadChild(Convert.ToInt32(ParentTable.SelectedRows[0].Cells[0].Value));
        }

    }
}
