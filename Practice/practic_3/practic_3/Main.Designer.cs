namespace practic_3
{
    partial class Main
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            dataGridView1 = new DataGridView();
            dataGridView2 = new DataGridView();
            Save = new Button();
            Modify = new Button();
            Delete = new Button();
            NumeBiscuiti = new Label();
            NumarBiscuiti = new Label();
            ProducatorId = new Label();
            textBox1 = new TextBox();
            textBox2 = new TextBox();
            numericUpDown1 = new NumericUpDown();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)dataGridView2).BeginInit();
            ((System.ComponentModel.ISupportInitialize)numericUpDown1).BeginInit();
            SuspendLayout();
            // 
            // dataGridView1
            // 
            dataGridView1.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new Point(31, 477);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.RowHeadersWidth = 72;
            dataGridView1.Size = new Size(591, 317);
            dataGridView1.TabIndex = 0;
            // 
            // dataGridView2
            // 
            dataGridView2.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView2.Location = new Point(724, 477);
            dataGridView2.Name = "dataGridView2";
            dataGridView2.RowHeadersWidth = 72;
            dataGridView2.Size = new Size(591, 317);
            dataGridView2.TabIndex = 1;
            // 
            // Save
            // 
            Save.Location = new Point(31, 811);
            Save.Name = "Save";
            Save.Size = new Size(342, 50);
            Save.TabIndex = 2;
            Save.Text = "Save";
            Save.UseVisualStyleBackColor = true;
            Save.Click += Save_Click;
            // 
            // Modify
            // 
            Modify.Location = new Point(517, 811);
            Modify.Name = "Modify";
            Modify.Size = new Size(342, 50);
            Modify.TabIndex = 3;
            Modify.Text = "Modify";
            Modify.UseVisualStyleBackColor = true;
            Modify.Click += Modify_Click;
            // 
            // Delete
            // 
            Delete.Location = new Point(973, 811);
            Delete.Name = "Delete";
            Delete.Size = new Size(342, 50);
            Delete.TabIndex = 4;
            Delete.Text = "Delete";
            Delete.UseVisualStyleBackColor = true;
            Delete.Click += Delete_Click;
            // 
            // NumeBiscuiti
            // 
            NumeBiscuiti.AutoSize = true;
            NumeBiscuiti.Location = new Point(69, 73);
            NumeBiscuiti.Name = "NumeBiscuiti";
            NumeBiscuiti.Size = new Size(141, 30);
            NumeBiscuiti.TabIndex = 5;
            NumeBiscuiti.Text = "Nume Biscuiti";
            // 
            // NumarBiscuiti
            // 
            NumarBiscuiti.AutoSize = true;
            NumarBiscuiti.Location = new Point(87, 159);
            NumarBiscuiti.Name = "NumarBiscuiti";
            NumarBiscuiti.Size = new Size(148, 30);
            NumarBiscuiti.TabIndex = 6;
            NumarBiscuiti.Text = "Numar Biscuiti";
            // 
            // ProducatorId
            // 
            ProducatorId.AutoSize = true;
            ProducatorId.Location = new Point(69, 238);
            ProducatorId.Name = "ProducatorId";
            ProducatorId.Size = new Size(139, 30);
            ProducatorId.TabIndex = 7;
            ProducatorId.Text = "Producator Id";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(216, 73);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(548, 35);
            textBox1.TabIndex = 8;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(216, 238);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(548, 35);
            textBox2.TabIndex = 9;
            // 
            // numericUpDown1
            // 
            numericUpDown1.Location = new Point(241, 159);
            numericUpDown1.Name = "numericUpDown1";
            numericUpDown1.Size = new Size(548, 35);
            numericUpDown1.TabIndex = 10;
            // 
            // Main
            // 
            AutoScaleDimensions = new SizeF(12F, 30F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1361, 873);
            Controls.Add(numericUpDown1);
            Controls.Add(textBox2);
            Controls.Add(textBox1);
            Controls.Add(ProducatorId);
            Controls.Add(NumarBiscuiti);
            Controls.Add(NumeBiscuiti);
            Controls.Add(Delete);
            Controls.Add(Modify);
            Controls.Add(Save);
            Controls.Add(dataGridView2);
            Controls.Add(dataGridView1);
            Name = "Main";
            Text = "Main";
            Load += Main_Load;
            ((System.ComponentModel.ISupportInitialize)dataGridView1).EndInit();
            ((System.ComponentModel.ISupportInitialize)dataGridView2).EndInit();
            ((System.ComponentModel.ISupportInitialize)numericUpDown1).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private DataGridView dataGridView1;
        private DataGridView dataGridView2;
        private Button Save;
        private Button Modify;
        private Button Delete;
        private Label NumeBiscuiti;
        private Label NumarBiscuiti;
        private Label ProducatorId;
        private TextBox textBox1;
        private TextBox textBox2;
        private NumericUpDown numericUpDown1;
    }
}