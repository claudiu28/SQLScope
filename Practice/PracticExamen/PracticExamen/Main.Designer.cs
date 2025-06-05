namespace PracticExamen
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
            label4 = new Label();
            textBox1 = new TextBox();
            textBox2 = new TextBox();
            label2 = new Label();
            label3 = new Label();
            textBox3 = new TextBox();
            label5 = new Label();
            textBox4 = new TextBox();
            dateTimePicker1 = new DateTimePicker();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)dataGridView2).BeginInit();
            SuspendLayout();
            // 
            // dataGridView1
            // 
            dataGridView1.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new Point(28, 405);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.RowHeadersWidth = 72;
            dataGridView1.Size = new Size(605, 381);
            dataGridView1.TabIndex = 0;
            // 
            // dataGridView2
            // 
            dataGridView2.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView2.Location = new Point(711, 405);
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
            Modify.Location = new Point(526, 817);
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
            label1.Location = new Point(270, 61);
            label1.Name = "label1";
            label1.Size = new Size(70, 30);
            label1.TabIndex = 5;
            label1.Text = "Nume";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(267, 157);
            label4.Name = "label4";
            label4.Size = new Size(123, 30);
            label4.TabIndex = 8;
            label4.Text = "Facultate_Id";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(394, 61);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(530, 35);
            textBox1.TabIndex = 10;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(394, 152);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(530, 35);
            textBox2.TabIndex = 12;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(1014, 28);
            label2.Name = "label2";
            label2.Size = new Size(96, 30);
            label2.TabIndex = 13;
            label2.Text = "Angajare";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(292, 230);
            label3.Name = "label3";
            label3.Size = new Size(57, 30);
            label3.TabIndex = 14;
            label3.Text = "Grad";
            // 
            // textBox3
            // 
            textBox3.Location = new Point(393, 225);
            textBox3.Name = "textBox3";
            textBox3.Size = new Size(531, 35);
            textBox3.TabIndex = 16;
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new Point(269, 107);
            label5.Name = "label5";
            label5.Size = new Size(96, 30);
            label5.TabIndex = 17;
            label5.Text = "Prenume";
            // 
            // textBox4
            // 
            textBox4.Location = new Point(394, 102);
            textBox4.Name = "textBox4";
            textBox4.Size = new Size(530, 35);
            textBox4.TabIndex = 18;
            // 
            // dateTimePicker1
            // 
            dateTimePicker1.Location = new Point(1014, 61);
            dateTimePicker1.Name = "dateTimePicker1";
            dateTimePicker1.Size = new Size(350, 35);
            dateTimePicker1.TabIndex = 19;
            // 
            // Main
            // 
            AutoScaleDimensions = new SizeF(12F, 30F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1376, 885);
            Controls.Add(dateTimePicker1);
            Controls.Add(textBox4);
            Controls.Add(label5);
            Controls.Add(textBox3);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(textBox2);
            Controls.Add(textBox1);
            Controls.Add(label4);
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
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private DataGridView dataGridView1;
        private DataGridView dataGridView2;
        private Button Save;
        private Button Modify;
        private Button Delete;
        private Label label1;
        private Label label4;
        private TextBox textBox1;
        private TextBox textBox2;
        private Label label2;
        private Label label3;
        private TextBox textBox3;
        private Label label5;
        private TextBox textBox4;
        private DateTimePicker dateTimePicker1;
    }
}
