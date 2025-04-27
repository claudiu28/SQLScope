namespace SGBD_Lab_2
{
    partial class App
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
            ParentTable = new DataGridView();
            ChildTable = new DataGridView();
            DeleteButton = new Button();
            UpdateButton = new Button();
            InsertButton = new Button();
            label1 = new Label();
            label2 = new Label();
            label3 = new Label();
            PanelContainer = new Panel();
            ((System.ComponentModel.ISupportInitialize)ParentTable).BeginInit();
            ((System.ComponentModel.ISupportInitialize)ChildTable).BeginInit();
            SuspendLayout();
            // 
            // ParentTable
            // 
            ParentTable.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            ParentTable.Location = new Point(29, 932);
            ParentTable.Name = "ParentTable";
            ParentTable.RowHeadersWidth = 72;
            ParentTable.Size = new Size(749, 453);
            ParentTable.TabIndex = 0;
            // 
            // ChildTable
            // 
            ChildTable.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            ChildTable.Location = new Point(29, 407);
            ChildTable.Name = "ChildTable";
            ChildTable.RowHeadersWidth = 72;
            ChildTable.Size = new Size(749, 453);
            ChildTable.TabIndex = 1;
            // 
            // DeleteButton
            // 
            DeleteButton.Location = new Point(29, 154);
            DeleteButton.Name = "DeleteButton";
            DeleteButton.Size = new Size(749, 64);
            DeleteButton.TabIndex = 2;
            DeleteButton.Text = "Delete";
            DeleteButton.UseVisualStyleBackColor = true;
            DeleteButton.Click += DeleteButton_Click;
            // 
            // UpdateButton
            // 
            UpdateButton.Location = new Point(29, 267);
            UpdateButton.Name = "UpdateButton";
            UpdateButton.Size = new Size(749, 59);
            UpdateButton.TabIndex = 3;
            UpdateButton.Text = "Update";
            UpdateButton.UseVisualStyleBackColor = true;
            UpdateButton.Click += UpdateButton_Click;
            // 
            // InsertButton
            // 
            InsertButton.Location = new Point(29, 49);
            InsertButton.Name = "InsertButton";
            InsertButton.Size = new Size(749, 64);
            InsertButton.TabIndex = 4;
            InsertButton.Text = "Insert";
            InsertButton.UseVisualStyleBackColor = true;
            InsertButton.Click += InsertButton_Click;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label1.Location = new Point(29, 891);
            label1.Name = "label1";
            label1.Size = new Size(110, 38);
            label1.TabIndex = 7;
            label1.Text = "Parent: ";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label2.Location = new Point(29, 366);
            label2.Name = "label2";
            label2.Size = new Size(86, 38);
            label2.TabIndex = 8;
            label2.Text = "Child:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Font = new Font("Segoe UI", 14.1428576F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label3.Location = new Point(1113, 68);
            label3.Name = "label3";
            label3.Size = new Size(266, 45);
            label3.TabIndex = 9;
            label3.Text = "Labels and Fields";
            // 
            // PanelContainer
            // 
            PanelContainer.Location = new Point(878, 140);
            PanelContainer.Name = "PanelContainer";
            PanelContainer.Size = new Size(729, 1245);
            PanelContainer.TabIndex = 10;
            // 
            // App
            // 
            AutoScaleDimensions = new SizeF(12F, 30F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1645, 1406);
            Controls.Add(PanelContainer);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(InsertButton);
            Controls.Add(UpdateButton);
            Controls.Add(DeleteButton);
            Controls.Add(ChildTable);
            Controls.Add(ParentTable);
            Name = "App";
            Load += App_Load;
            ((System.ComponentModel.ISupportInitialize)ParentTable).EndInit();
            ((System.ComponentModel.ISupportInitialize)ChildTable).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private DataGridView ParentTable;
        private DataGridView ChildTable;
        private Button DeleteButton;
        private Button UpdateButton;
        private Button InsertButton;
        private Label label1;
        private Label label2;
        private Label label3;
        private Panel PanelContainer;
    }
}
