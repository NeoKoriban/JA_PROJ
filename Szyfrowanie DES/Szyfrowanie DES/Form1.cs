using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Threading;



namespace Szyfrowanie_DES
{ 
    public partial class EncryptDES : Form
    {[DllImport("AsemblerDES.dll", CallingConvention = CallingConvention.StdCall)]
        public static extern int Szyfruj(byte []  a, byte []  b);
        [DllImport("AsemblerDES.dll", CallingConvention = CallingConvention.StdCall)]
        public static extern int Deszyfruj(byte[] a, byte[] b);
        //
        private byte[][] blocksArray;
        //
        
        private byte[] dataArray;

        public EncryptDES()
        {
            InitializeComponent();
        }
        private string fileLocation;
        private void selectFileButton_Click(object sender, EventArgs e)
        {
            selectOperationButton.Enabled = false;
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

            dataTableVisualisation.ColumnHeadersVisible = false;
            dataTableVisualisation.RowHeadersVisible = false;
            DataPrepare dataPrepare = new DataPrepare();

            int lengthBlock = 16;

            dataArray = dataPrepare.readFile(fileLocation);
           
            blocksArray = dataPrepare.divideToBlocks(dataArray, lengthBlock);
            
            dataTableVisualisation.ColumnCount = lengthBlock;
            dataTableVisualisation.RowCount = (int)blocksArray.Length;
            statusLabel.Text = "Dane zostały wczytane";
            statusLabel.ForeColor = Color.Green;


            for (int i = 0; i < blocksArray.Length; i++)
            {             
                for (int j = 0; j < lengthBlock; j++)
                {
                    dataTableVisualisation.Rows[i].Cells[j].Value = blocksArray[i][j];
                }
                      
            }
            operationsComboBox.Items.Clear();
            operationsComboBox.Items.Add("Zaszyfruj");
            operationsComboBox.Items.Add("Odszyfruj");
        }

        private void operationsComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectOperationButton.Enabled = true;
        }

        private void selectOperationButton_Click(object sender, EventArgs e)
        {
            DataPrepare dataPrepare = new DataPrepare();

            if (operationsComboBox.SelectedItem.Equals("Odszyfruj"))
            {
                statusLabel.Text = "Dane zostały odszyfrowane";
                
                for (int i = 0; i < blocksArray.Length / 16; i++)
                {
                    int cos = Deszyfruj(blocksArray[i], blocksArray[i]);
                }
                dataArray = dataPrepare.integrateBlocks(blocksArray);
                dataPrepare.writeFile(fileLocation, dataArray);
            }
            else
            {
                statusLabel.Text = "Dane zostały odszyfrowane";

                for(int i = 0; i < blocksArray.Length/16; i++) 
                {
                    int cos = Szyfruj(blocksArray[i],blocksArray[i]);
                }
                dataArray = dataPrepare.integrateBlocks(blocksArray);
                dataPrepare.writeFile(fileLocation, dataArray);
              

            }
        }
    }
}
