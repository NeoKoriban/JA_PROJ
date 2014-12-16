namespace Szyfrowanie_DES
{
    partial class EncryptDES
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
            this.optionsGroupBox = new System.Windows.Forms.GroupBox();
            this.operationGroupBox = new System.Windows.Forms.GroupBox();
            this.selectOperationButton = new System.Windows.Forms.Button();
            this.operationsComboBox = new System.Windows.Forms.ComboBox();
            this.selectFileGroupBox = new System.Windows.Forms.GroupBox();
            this.readFileButton = new System.Windows.Forms.Button();
            this.selectFileButton = new System.Windows.Forms.Button();
            this.selectedFileLink = new System.Windows.Forms.TextBox();
            this.selectFileLabel = new System.Windows.Forms.Label();
            this.fileDialog = new System.Windows.Forms.OpenFileDialog();
            this.dataTableGroupBox = new System.Windows.Forms.GroupBox();
            this.statusGroupBox = new System.Windows.Forms.GroupBox();
            this.statusLabel = new System.Windows.Forms.Label();
            this.dataTableVisualisation = new System.Windows.Forms.DataGridView();
            this.optionsGroupBox.SuspendLayout();
            this.operationGroupBox.SuspendLayout();
            this.selectFileGroupBox.SuspendLayout();
            this.dataTableGroupBox.SuspendLayout();
            this.statusGroupBox.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataTableVisualisation)).BeginInit();
            this.SuspendLayout();
            // 
            // optionsGroupBox
            // 
            this.optionsGroupBox.Controls.Add(this.operationGroupBox);
            this.optionsGroupBox.Controls.Add(this.selectFileGroupBox);
            this.optionsGroupBox.Location = new System.Drawing.Point(12, 12);
            this.optionsGroupBox.Name = "optionsGroupBox";
            this.optionsGroupBox.Size = new System.Drawing.Size(283, 367);
            this.optionsGroupBox.TabIndex = 0;
            this.optionsGroupBox.TabStop = false;
            this.optionsGroupBox.Text = "Opcje";
            // 
            // operationGroupBox
            // 
            this.operationGroupBox.Controls.Add(this.selectOperationButton);
            this.operationGroupBox.Controls.Add(this.operationsComboBox);
            this.operationGroupBox.Enabled = false;
            this.operationGroupBox.Location = new System.Drawing.Point(6, 202);
            this.operationGroupBox.Name = "operationGroupBox";
            this.operationGroupBox.Size = new System.Drawing.Size(271, 145);
            this.operationGroupBox.TabIndex = 1;
            this.operationGroupBox.TabStop = false;
            this.operationGroupBox.Text = "Wybór operacji";
            // 
            // selectOperationButton
            // 
            this.selectOperationButton.Enabled = false;
            this.selectOperationButton.Location = new System.Drawing.Point(24, 69);
            this.selectOperationButton.Name = "selectOperationButton";
            this.selectOperationButton.Size = new System.Drawing.Size(227, 50);
            this.selectOperationButton.TabIndex = 4;
            this.selectOperationButton.Text = "Wybierz operację";
            this.selectOperationButton.UseVisualStyleBackColor = true;
            this.selectOperationButton.Click += new System.EventHandler(this.selectOperationButton_Click);
            // 
            // operationsComboBox
            // 
            this.operationsComboBox.FormattingEnabled = true;
            this.operationsComboBox.Location = new System.Drawing.Point(24, 31);
            this.operationsComboBox.Name = "operationsComboBox";
            this.operationsComboBox.Size = new System.Drawing.Size(227, 21);
            this.operationsComboBox.TabIndex = 0;
            this.operationsComboBox.SelectedIndexChanged += new System.EventHandler(this.operationsComboBox_SelectedIndexChanged);
            // 
            // selectFileGroupBox
            // 
            this.selectFileGroupBox.Controls.Add(this.readFileButton);
            this.selectFileGroupBox.Controls.Add(this.selectFileButton);
            this.selectFileGroupBox.Controls.Add(this.selectedFileLink);
            this.selectFileGroupBox.Controls.Add(this.selectFileLabel);
            this.selectFileGroupBox.Location = new System.Drawing.Point(6, 21);
            this.selectFileGroupBox.Name = "selectFileGroupBox";
            this.selectFileGroupBox.Size = new System.Drawing.Size(271, 165);
            this.selectFileGroupBox.TabIndex = 0;
            this.selectFileGroupBox.TabStop = false;
            this.selectFileGroupBox.Text = "Wybór pliku";
            // 
            // readFileButton
            // 
            this.readFileButton.Enabled = false;
            this.readFileButton.Location = new System.Drawing.Point(146, 86);
            this.readFileButton.Name = "readFileButton";
            this.readFileButton.Size = new System.Drawing.Size(105, 49);
            this.readFileButton.TabIndex = 3;
            this.readFileButton.Text = "Wczytaj Plik";
            this.readFileButton.UseVisualStyleBackColor = true;
            this.readFileButton.Click += new System.EventHandler(this.readFileButton_Click);
            // 
            // selectFileButton
            // 
            this.selectFileButton.Location = new System.Drawing.Point(24, 86);
            this.selectFileButton.Name = "selectFileButton";
            this.selectFileButton.Size = new System.Drawing.Size(103, 50);
            this.selectFileButton.TabIndex = 2;
            this.selectFileButton.Text = "Wybierz Plik";
            this.selectFileButton.UseVisualStyleBackColor = true;
            this.selectFileButton.Click += new System.EventHandler(this.selectFileButton_Click);
            // 
            // selectedFileLink
            // 
            this.selectedFileLink.Location = new System.Drawing.Point(85, 44);
            this.selectedFileLink.Name = "selectedFileLink";
            this.selectedFileLink.Size = new System.Drawing.Size(166, 20);
            this.selectedFileLink.TabIndex = 1;
            // 
            // selectFileLabel
            // 
            this.selectFileLabel.AutoSize = true;
            this.selectFileLabel.Location = new System.Drawing.Point(21, 44);
            this.selectFileLabel.Name = "selectFileLabel";
            this.selectFileLabel.Size = new System.Drawing.Size(48, 13);
            this.selectFileLabel.TabIndex = 0;
            this.selectFileLabel.Text = "Ścieżka:";
            // 
            // fileDialog
            // 
            this.fileDialog.FileName = "fileToOperation";
            this.fileDialog.FileOk += new System.ComponentModel.CancelEventHandler(this.fileDialog_FileOk);
            // 
            // dataTableGroupBox
            // 
            this.dataTableGroupBox.Controls.Add(this.statusGroupBox);
            this.dataTableGroupBox.Controls.Add(this.dataTableVisualisation);
            this.dataTableGroupBox.Enabled = false;
            this.dataTableGroupBox.Location = new System.Drawing.Point(302, 13);
            this.dataTableGroupBox.Name = "dataTableGroupBox";
            this.dataTableGroupBox.Size = new System.Drawing.Size(413, 366);
            this.dataTableGroupBox.TabIndex = 1;
            this.dataTableGroupBox.TabStop = false;
            this.dataTableGroupBox.Text = "Tablica z zawartością";
            // 
            // statusGroupBox
            // 
            this.statusGroupBox.Controls.Add(this.statusLabel);
            this.statusGroupBox.Location = new System.Drawing.Point(20, 20);
            this.statusGroupBox.Name = "statusGroupBox";
            this.statusGroupBox.Size = new System.Drawing.Size(374, 64);
            this.statusGroupBox.TabIndex = 1;
            this.statusGroupBox.TabStop = false;
            this.statusGroupBox.Text = "Status";
            // 
            // statusLabel
            // 
            this.statusLabel.AutoSize = true;
            this.statusLabel.Location = new System.Drawing.Point(16, 28);
            this.statusLabel.Name = "statusLabel";
            this.statusLabel.Size = new System.Drawing.Size(28, 13);
            this.statusLabel.TabIndex = 0;
            this.statusLabel.Text = "brak";
            // 
            // dataTableVisualisation
            // 
            this.dataTableVisualisation.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataTableVisualisation.Location = new System.Drawing.Point(20, 106);
            this.dataTableVisualisation.Name = "dataTableVisualisation";
            this.dataTableVisualisation.Size = new System.Drawing.Size(374, 240);
            this.dataTableVisualisation.TabIndex = 0;
            // 
            // EncryptDES
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(727, 391);
            this.Controls.Add(this.dataTableGroupBox);
            this.Controls.Add(this.optionsGroupBox);
            this.Name = "EncryptDES";
            this.Text = "Szyfrowanie DES";
            this.optionsGroupBox.ResumeLayout(false);
            this.operationGroupBox.ResumeLayout(false);
            this.selectFileGroupBox.ResumeLayout(false);
            this.selectFileGroupBox.PerformLayout();
            this.dataTableGroupBox.ResumeLayout(false);
            this.statusGroupBox.ResumeLayout(false);
            this.statusGroupBox.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataTableVisualisation)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox optionsGroupBox;
        private System.Windows.Forms.GroupBox selectFileGroupBox;
        private System.Windows.Forms.Button selectFileButton;
        private System.Windows.Forms.TextBox selectedFileLink;
        private System.Windows.Forms.Label selectFileLabel;
        private System.Windows.Forms.OpenFileDialog fileDialog;
        private System.Windows.Forms.Button readFileButton;
        private System.Windows.Forms.GroupBox operationGroupBox;
        private System.Windows.Forms.Button selectOperationButton;
        private System.Windows.Forms.ComboBox operationsComboBox;
        private System.Windows.Forms.GroupBox dataTableGroupBox;
        private System.Windows.Forms.DataGridView dataTableVisualisation;
        private System.Windows.Forms.GroupBox statusGroupBox;
        private System.Windows.Forms.Label statusLabel;
    }
}

