using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Szyfrowanie_DES
{
    public partial class EncryptDES : Form
    {
        public EncryptDES()
        {
            InitializeComponent();
        }
        private string fileLocation;
        private void selectFileButton_Click(object sender, EventArgs e)
        {
            selectedFileLink.Text = string.Empty;
            operationGroupBox.Enabled = false;
            readFileButton.Enabled = false;
            dataTableGroupBox.Enabled = false;
            OpenFileDialog fileDialog = new OpenFileDialog();
            fileDialog.InitialDirectory = "C:/";
            if (fileDialog.ShowDialog() == DialogResult.OK)
            {
                selectedFileLink.Text = fileDialog.FileName;
                fileLocation = fileDialog.FileName;
                readFileButton.Enabled = true;

            }
            
        }

        private void fileDialog_FileOk(object sender, CancelEventArgs e)
        {

        }

        private void readFileButton_Click(object sender, EventArgs e)
        {
            operationGroupBox.Enabled = true;

            dataTableGroupBox.Enabled = true;
            FileStream file = new FileStream(fileLocation,FileMode.Open,FileAccess.Read);
            byte[] dataArray = new byte[file.Length];
            long lengthBlock = file.Length / 16;
            byte[][] blocksArray = new byte [16][];
            BinaryReader br = new BinaryReader(file);
            statusLabel.Text = (file.Length).ToString() + " | " + ((lengthBlock)*16).ToString();
            long arrayPosition = 0;
            for (int i = 0; i < file.Length; i++)
            {
                dataArray[i] = br.ReadByte();
            }
            DataGridViewCell tmpTable;
            
            dataTableVisualisation.ColumnHeadersVisible = false;
            dataTableVisualisation.RowHeadersVisible = false;
            dataTableVisualisation.ColumnCount = 16;
            dataTableVisualisation.RowCount = (int)lengthBlock;
            for (int i = 0; i < 16; i++)
            {
                blocksArray[i] = new byte[lengthBlock];
                for (int j = 0; j < lengthBlock; j++)
                {
                    blocksArray[i][j] = dataArray[arrayPosition];
                    arrayPosition += 1;
                    dataTableVisualisation.Rows[j].Cells[i].Value = blocksArray[i][j];
                }
                      
            }
        }
    }
}
