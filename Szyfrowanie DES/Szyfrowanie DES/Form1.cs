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
    {
        [DllImport("AsemblerDES.dll", CallingConvention = CallingConvention.StdCall)]
        public static extern void Szyfruj(byte []  a, byte []  b);
        [DllImport("AsemblerDES.dll", CallingConvention = CallingConvention.StdCall)]
        public static extern void Deszyfruj(byte[] a, byte[] b);
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

            int lengthBlock = 8;

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
        private int iterator = 0;
        private void realizeThreadEncrypt()
        {
            int loopIteration = blocksArray.Length / 4;
            for (int i = iterator * loopIteration; i < loopIteration + iterator * loopIteration; i++)
            {
                byte[] array = new byte[8];
                Szyfruj(blocksArray[i], array);
                blocksArray[i] = array;
            }
            
        }
        private void realizeThreadDecrypt()
        {
            int loopIteration = blocksArray.Length / 4;
            for (int i = iterator * loopIteration; i < loopIteration + iterator * loopIteration; i++)
            {
                byte[] array = new byte[8];
                Deszyfruj(blocksArray[i], array);
                blocksArray[i] = array;
            }
        }
        private void selectOperationButton_Click(object sender, EventArgs e)
        {
            DataPrepare dataPrepare = new DataPrepare();

            if (operationsComboBox.SelectedItem.Equals("Odszyfruj"))
            {
                statusLabel.Text = "Dane zostały odszyfrowane";

                iterator = 0;                 
                Thread thread1 = new Thread(new ThreadStart(realizeThreadDecrypt));
                thread1.Start();
                thread1.Join();
                iterator = 1;
                Thread thread2 = new Thread(new ThreadStart(realizeThreadDecrypt));
                thread2.Start();
                thread2.Join();
                iterator = 2;
                Thread thread3 = new Thread(new ThreadStart(realizeThreadDecrypt));
                thread3.Start();
                thread3.Join();
                iterator = 3;
                Thread thread4 = new Thread(new ThreadStart(realizeThreadDecrypt));
                thread4.Start();
                thread4.Join();

                dataArray = dataPrepare.integrateBlocks(blocksArray);
                dataPrepare.writeFile(fileLocation, dataArray);
            }
            else
            {
                statusLabel.Text = "Dane zostały zaszyfrowane";

                iterator = 0;
                Thread thread1 = new Thread(new ThreadStart(realizeThreadEncrypt));
                thread1.Start();
                thread1.Join();
                iterator = 1;
                Thread thread2 = new Thread(new ThreadStart(realizeThreadEncrypt));
                thread2.Start();
                thread2.Join();
                iterator = 2;
                Thread thread3 = new Thread(new ThreadStart(realizeThreadEncrypt));
                thread3.Start();
                thread3.Join();
                iterator = 3;
                Thread thread4 = new Thread(new ThreadStart(realizeThreadEncrypt));
                thread4.Start();
                thread4.Join();
               
                dataArray = dataPrepare.integrateBlocks(blocksArray);
                dataPrepare.writeFile(fileLocation, dataArray);
                
            }
        }
    }
}
