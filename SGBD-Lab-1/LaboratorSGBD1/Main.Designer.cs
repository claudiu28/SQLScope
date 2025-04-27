namespace LaboratorSGBD1
{
    partial class Main
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            TitluLabel = new Label();
            NumeMedicamente = new Label();
            NumeMedicamentInput = new TextBox();
            DescriereLabel = new Label();
            PretLabel = new Label();
            StocLabel = new Label();
            PretInput = new NumericUpDown();
            StocInput = new NumericUpDown();
            DescriereInput = new TextBox();
            FarmacieId = new Label();
            InsertMedicament = new Button();
            DeleteMedicament = new Button();
            UpdateMedicament = new Button();
            FarmacieIdInput = new TextBox();
            Medicamente = new DataGridView();
            FarmDetalii = new DataGridView();
            ((System.ComponentModel.ISupportInitialize)PretInput).BeginInit();
            ((System.ComponentModel.ISupportInitialize)StocInput).BeginInit();
            ((System.ComponentModel.ISupportInitialize)Medicamente).BeginInit();
            ((System.ComponentModel.ISupportInitialize)FarmDetalii).BeginInit();
            SuspendLayout();
            // 
            // TitluLabel
            // 
            TitluLabel.AutoSize = true;
            TitluLabel.Font = new Font("Segoe UI", 18F, FontStyle.Regular, GraphicsUnit.Point, 0);
            TitluLabel.Location = new Point(766, 47);
            TitluLabel.Margin = new Padding(4, 0, 4, 0);
            TitluLabel.Name = "TitluLabel";
            TitluLabel.Size = new Size(579, 57);
            TitluLabel.TabIndex = 0;
            TitluLabel.Text = "Laborator - Farmacie - SGBD1";
            TitluLabel.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // NumeMedicamente
            // 
            NumeMedicamente.AutoSize = true;
            NumeMedicamente.Font = new Font("Segoe UI", 14.1428576F, FontStyle.Regular, GraphicsUnit.Point, 0);
            NumeMedicamente.Location = new Point(120, 169);
            NumeMedicamente.Margin = new Padding(4, 0, 4, 0);
            NumeMedicamente.Name = "NumeMedicamente";
            NumeMedicamente.Size = new Size(297, 45);
            NumeMedicamente.TabIndex = 1;
            NumeMedicamente.Text = "Nume medicament";
            NumeMedicamente.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // NumeMedicamentInput
            // 
            NumeMedicamentInput.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            NumeMedicamentInput.Location = new Point(462, 169);
            NumeMedicamentInput.Margin = new Padding(4);
            NumeMedicamentInput.Name = "NumeMedicamentInput";
            NumeMedicamentInput.PlaceholderText = "Introduceti nume medicament";
            NumeMedicamentInput.Size = new Size(698, 45);
            NumeMedicamentInput.TabIndex = 2;
            // 
            // DescriereLabel
            // 
            DescriereLabel.AutoSize = true;
            DescriereLabel.Font = new Font("Segoe UI", 14.1428576F, FontStyle.Regular, GraphicsUnit.Point, 0);
            DescriereLabel.Location = new Point(252, 257);
            DescriereLabel.Margin = new Padding(4, 0, 4, 0);
            DescriereLabel.Name = "DescriereLabel";
            DescriereLabel.Size = new Size(153, 45);
            DescriereLabel.TabIndex = 4;
            DescriereLabel.Text = "Descriere";
            DescriereLabel.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // PretLabel
            // 
            PretLabel.AutoSize = true;
            PretLabel.Font = new Font("Segoe UI", 14.1428576F, FontStyle.Regular, GraphicsUnit.Point, 0);
            PretLabel.Location = new Point(328, 356);
            PretLabel.Margin = new Padding(4, 0, 4, 0);
            PretLabel.Name = "PretLabel";
            PretLabel.Size = new Size(77, 45);
            PretLabel.TabIndex = 5;
            PretLabel.Text = "Pret";
            PretLabel.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // StocLabel
            // 
            StocLabel.AutoSize = true;
            StocLabel.Font = new Font("Segoe UI", 14.1428576F, FontStyle.Regular, GraphicsUnit.Point, 0);
            StocLabel.Location = new Point(335, 444);
            StocLabel.Margin = new Padding(4, 0, 4, 0);
            StocLabel.Name = "StocLabel";
            StocLabel.Size = new Size(82, 45);
            StocLabel.TabIndex = 7;
            StocLabel.Text = "Stoc";
            StocLabel.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // PretInput
            // 
            PretInput.DecimalPlaces = 2;
            PretInput.Location = new Point(460, 356);
            PretInput.Margin = new Padding(4);
            PretInput.Maximum = new decimal(new int[] { 1000, 0, 0, 0 });
            PretInput.Name = "PretInput";
            PretInput.Size = new Size(699, 42);
            PretInput.TabIndex = 8;
            // 
            // StocInput
            // 
            StocInput.Location = new Point(460, 449);
            StocInput.Maximum = new decimal(new int[] { 1000, 0, 0, 0 });
            StocInput.Name = "StocInput";
            StocInput.Size = new Size(705, 42);
            StocInput.TabIndex = 9;
            // 
            // DescriereInput
            // 
            DescriereInput.Location = new Point(465, 264);
            DescriereInput.Name = "DescriereInput";
            DescriereInput.PlaceholderText = "Introduceti descrierea...";
            DescriereInput.Size = new Size(695, 42);
            DescriereInput.TabIndex = 10;
            // 
            // FarmacieId
            // 
            FarmacieId.AutoSize = true;
            FarmacieId.Font = new Font("Segoe UI", 14.1428576F, FontStyle.Regular, GraphicsUnit.Point, 0);
            FarmacieId.Location = new Point(241, 533);
            FarmacieId.Name = "FarmacieId";
            FarmacieId.Size = new Size(176, 45);
            FarmacieId.TabIndex = 11;
            FarmacieId.Text = "FarmacieId";
            // 
            // InsertMedicament
            // 
            InsertMedicament.Location = new Point(1331, 207);
            InsertMedicament.Name = "InsertMedicament";
            InsertMedicament.Size = new Size(506, 73);
            InsertMedicament.TabIndex = 13;
            InsertMedicament.Text = "Insert Medicament";
            InsertMedicament.UseVisualStyleBackColor = true;
            InsertMedicament.Click += InsertMedicament_Click;
            // 
            // DeleteMedicament
            // 
            DeleteMedicament.Location = new Point(1331, 343);
            DeleteMedicament.Name = "DeleteMedicament";
            DeleteMedicament.Size = new Size(506, 77);
            DeleteMedicament.TabIndex = 14;
            DeleteMedicament.Text = "Delete Medicament";
            DeleteMedicament.UseVisualStyleBackColor = true;
            DeleteMedicament.Click += DeleteMedicament_Click;
            // 
            // UpdateMedicament
            // 
            UpdateMedicament.Location = new Point(1331, 467);
            UpdateMedicament.Name = "UpdateMedicament";
            UpdateMedicament.Size = new Size(506, 74);
            UpdateMedicament.TabIndex = 15;
            UpdateMedicament.Text = "Update Medicament";
            UpdateMedicament.UseVisualStyleBackColor = true;
            UpdateMedicament.Click += UpdateMedicament_Click;
            // 
            // FarmacieIdInput
            // 
            FarmacieIdInput.BackColor = Color.NavajoWhite;
            FarmacieIdInput.ForeColor = SystemColors.WindowText;
            FarmacieIdInput.Location = new Point(460, 533);
            FarmacieIdInput.Name = "FarmacieIdInput";
            FarmacieIdInput.PlaceholderText = "Farmcie Id -> setat in momentul selectiei";
            FarmacieIdInput.ReadOnly = true;
            FarmacieIdInput.Size = new Size(705, 42);
            FarmacieIdInput.TabIndex = 16;
            // 
            // Medicamente
            // 
            Medicamente.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            Medicamente.Location = new Point(216, 623);
            Medicamente.Name = "Medicamente";
            Medicamente.RowHeadersWidth = 72;
            Medicamente.Size = new Size(949, 581);
            Medicamente.TabIndex = 17;
            // 
            // FarmDetalii
            // 
            FarmDetalii.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            FarmDetalii.Location = new Point(1221, 623);
            FarmDetalii.Name = "FarmDetalii";
            FarmDetalii.RowHeadersWidth = 72;
            FarmDetalii.Size = new Size(732, 581);
            FarmDetalii.TabIndex = 18;
            // 
            // Main
            // 
            AutoScaleDimensions = new SizeF(14F, 36F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(2026, 1254);
            Controls.Add(FarmDetalii);
            Controls.Add(Medicamente);
            Controls.Add(FarmacieIdInput);
            Controls.Add(UpdateMedicament);
            Controls.Add(DeleteMedicament);
            Controls.Add(InsertMedicament);
            Controls.Add(FarmacieId);
            Controls.Add(DescriereInput);
            Controls.Add(StocInput);
            Controls.Add(PretInput);
            Controls.Add(StocLabel);
            Controls.Add(PretLabel);
            Controls.Add(DescriereLabel);
            Controls.Add(NumeMedicamentInput);
            Controls.Add(NumeMedicamente);
            Controls.Add(TitluLabel);
            Font = new Font("Segoe UI", 11.1428576F, FontStyle.Regular, GraphicsUnit.Point, 0);
            Margin = new Padding(4);
            Name = "Main";
            Text = "Main";
            Load += Main_Load;
            ((System.ComponentModel.ISupportInitialize)PretInput).EndInit();
            ((System.ComponentModel.ISupportInitialize)StocInput).EndInit();
            ((System.ComponentModel.ISupportInitialize)Medicamente).EndInit();
            ((System.ComponentModel.ISupportInitialize)FarmDetalii).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label TitluLabel;
        private Label NumeMedicamente;
        private TextBox NumeMedicamentInput;
        private Label DescriereLabel;
        private Label PretLabel;
        private Label StocLabel;
        private NumericUpDown PretInput;
        private NumericUpDown StocInput;
        private TextBox DescriereInput;
        private Label FarmacieId;
        private Button InsertMedicament;
        private Button DeleteMedicament;
        private Button UpdateMedicament;
        private TextBox FarmacieIdInput;
        private DataGridView Medicamente;
        private DataGridView FarmDetalii;
    }
}
