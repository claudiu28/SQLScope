namespace practic_4
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
            label1 = new Label();
            label2 = new Label();
            label4 = new Label();
            textBox1 = new TextBox();
            numericUpDown1 = new NumericUpDown();
            textBox2 = new TextBox();
            label3 = new Label();
            label5 = new Label();
            textBox3 = new TextBox();
            textBox4 = new TextBox();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)dataGridView2).BeginInit();
            ((System.ComponentModel.ISupportInitialize)numericUpDown1).BeginInit();
            SuspendLayout();
            // 
            // dataGridView1
            // 
            dataGridView1.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new Point(28, 419);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.RowHeadersWidth = 72;
            dataGridView1.Size = new Size(605, 381);
            dataGridView1.TabIndex = 0;
            // 
            // dataGridView2
            // 
            dataGridView2.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView2.Location = new Point(711, 419);
            dataGridView2.Name = "dataGridView2";
            dataGridView2.RowHeadersWidth = 72;
            dataGridView2.Size = new Size(620, 381);
            dataGridView2.TabIndex = 1;
            // 
            // Save
            // 
            Save.Location = new Point(28, 817);
            Save.Name = "Save";
            Save.Size = new Size(337, 56);
            Save.TabIndex = 2;
            Save.Text = "Save";
            Save.UseVisualStyleBackColor = true;
            Save.Click += Save_Click;
            // 
            // Modify
            // 
            Modify.Location = new Point(512, 817);
            Modify.Name = "Modify";
            Modify.Size = new Size(337, 56);
            Modify.TabIndex = 3;
            Modify.Text = "Modify";
            Modify.UseVisualStyleBackColor = true;
            Modify.Click += Modify_Click;
            // 
            // Delete
            // 
            Delete.Location = new Point(941, 817);
            Delete.Name = "Delete";
            Delete.Size = new Size(390, 56);
            Delete.TabIndex = 4;
            Delete.Text = "Delete";
            Delete.UseVisualStyleBackColor = true;
            Delete.Click += Delete_Click;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(62, 46);
            label1.Name = "label1";
            label1.Size = new Size(53, 30);
            label1.TabIndex = 5;
            label1.Text = "Titlu";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(62, 109);
            label2.Name = "label2";
            label2.Size = new Size(116, 30);
            label2.TabIndex = 6;
            label2.Text = "An Lansare";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(62, 192);
            label4.Name = "label4";
            label4.Size = new Size(108, 30);
            label4.TabIndex = 8;
            label4.Text = "Cod Autor";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(184, 46);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(530, 35);
            textBox1.TabIndex = 10;
            // 
            // numericUpDown1
            // 
            numericUpDown1.Location = new Point(184, 109);
            numericUpDown1.Maximum = new decimal(new int[] { 2025, 0, 0, 0 });
            numericUpDown1.Name = "numericUpDown1";
            numericUpDown1.Size = new Size(530, 35);
            numericUpDown1.TabIndex = 11;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(184, 187);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(530, 35);
            textBox2.TabIndex = 12;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(57, 256);
            label3.Name = "label3";
            label3.Size = new Size(121, 30);
            label3.TabIndex = 13;
            label3.Text = "Cod Editura";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new Point(70, 313);
            label5.Name = "label5";
            label5.Size = new Size(145, 30);
            label5.TabIndex = 14;
            label5.Text = "Cod Categorie";
            // 
            // textBox3
            // 
            textBox3.Location = new Point(184, 256);
            textBox3.Name = "textBox3";
            textBox3.Size = new Size(530, 35);
            textBox3.TabIndex = 15;
            // 
            // textBox4
            // 
            textBox4.Location = new Point(221, 313);
            textBox4.Name = "textBox4";
            textBox4.Size = new Size(531, 35);
            textBox4.TabIndex = 16;
            // 
            // Main
            // 
            AutoScaleDimensions = new SizeF(12F, 30F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1376, 885);
            Controls.Add(textBox4);
            Controls.Add(textBox3);
            Controls.Add(label5);
            Controls.Add(label3);
            Controls.Add(textBox2);
            Controls.Add(numericUpDown1);
            Controls.Add(textBox1);
            Controls.Add(label4);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(Delete);
            Controls.Add(Modify);
            Controls.Add(Save);
            Controls.Add(dataGridView2);
            Controls.Add(dataGridView1);
            Name = "Main";
            Text = "Form1";
            Load += Main_Load;
            ((System.ComponentModel.ISupportInitialize)dataGridView1).EndInit();
            ((System.ComponentModel.ISupportInitialize)dataGridView2).EndInit();
            ((System.ComponentModel.ISupportInitialize)numericUpDown1).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }


        private DataGridView dataGridView1;
        private DataGridView dataGridView2;
        private Button Save;
        private Button Modify;
        private Button Delete;
        private Label label1;
        private Label label2;
        private Label label4;
        private TextBox textBox1;
        private NumericUpDown numericUpDown1;
        private TextBox textBox2;
        private Label label3;
        private Label label5;
        private TextBox textBox3;
        private TextBox textBox4;
    }

        #endregion
}
