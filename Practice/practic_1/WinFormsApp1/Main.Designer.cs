namespace Practic1Briosa
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
            dataGridView1 = new DataGridView();
            dataGridView2 = new DataGridView();
            Save = new Button();
            Modify = new Button();
            Delete = new Button();
            nume_briosa = new Label();
            label2 = new Label();
            label3 = new Label();
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
            dataGridView1.Location = new Point(29, 406);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.RowHeadersWidth = 72;
            dataGridView1.Size = new Size(592, 440);
            dataGridView1.TabIndex = 0;
            // 
            // dataGridView2
            // 
            dataGridView2.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView2.Location = new Point(768, 406);
            dataGridView2.Name = "dataGridView2";
            dataGridView2.RowHeadersWidth = 72;
            dataGridView2.Size = new Size(597, 440);
            dataGridView2.TabIndex = 1;
            // 
            // Save
            // 
            Save.Location = new Point(29, 896);
            Save.Name = "Save";
            Save.Size = new Size(359, 53);
            Save.TabIndex = 2;
            Save.Text = "Save";
            Save.UseVisualStyleBackColor = true;
            Save.Click += Save_Click;
            // 
            // Modify
            // 
            Modify.Location = new Point(532, 896);
            Modify.Name = "Modify";
            Modify.Size = new Size(353, 51);
            Modify.TabIndex = 3;
            Modify.Text = "Modify";
            Modify.UseVisualStyleBackColor = true;
            Modify.Click += Modify_Click_1;
            // 
            // Delete
            // 
            Delete.Location = new Point(962, 898);
            Delete.Name = "Delete";
            Delete.Size = new Size(353, 51);
            Delete.TabIndex = 4;
            Delete.Text = "Delete";
            Delete.UseVisualStyleBackColor = true;
            Delete.Click += Delete_Click_1;
            // 
            // nume_briosa
            // 
            nume_briosa.AutoSize = true;
            nume_briosa.Location = new Point(84, 54);
            nume_briosa.Name = "nume_briosa";
            nume_briosa.Size = new Size(132, 30);
            nume_briosa.TabIndex = 5;
            nume_briosa.Text = "Nume Briosa";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(117, 114);
            label2.Name = "label2";
            label2.Size = new Size(50, 30);
            label2.TabIndex = 6;
            label2.Text = "Pret";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(99, 173);
            label3.Name = "label3";
            label3.Size = new Size(121, 30);
            label3.TabIndex = 7;
            label3.Text = "Cofetarie Id";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(222, 54);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(626, 35);
            textBox1.TabIndex = 8;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(226, 173);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(626, 35);
            textBox2.TabIndex = 9;
            // 
            // numericUpDown1
            // 
            numericUpDown1.Location = new Point(222, 112);
            numericUpDown1.Name = "numericUpDown1";
            numericUpDown1.Size = new Size(633, 35);
            numericUpDown1.TabIndex = 10;
            // 
            // Main
            // 
            AutoScaleDimensions = new SizeF(12F, 30F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1414, 982);
            Controls.Add(numericUpDown1);
            Controls.Add(textBox2);
            Controls.Add(textBox1);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(nume_briosa);
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
        private Label nume_briosa;
        private Label label2;
        private Label label3;
        private TextBox textBox1;
        private TextBox textBox2;
        private NumericUpDown numericUpDown1;
    }
}
