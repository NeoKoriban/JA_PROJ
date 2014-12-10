﻿using System;
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



namespace Szyfrowanie_DES
{ 
    public partial class EncryptDES : Form
    {[DllImport("AsemblerDES.dll", CallingConvention = CallingConvention.StdCall)]

        public static extern int Dodaj(byte []  a, byte []  b);
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
                dataArray = dataPrepare.integrateBlocks(blocksArray);
                dataPrepare.writeFile(fileLocation, dataArray);
            }
            else
            {
                byte[] key = { 4, 6, 23, 222, 16, 42, 5, 7 };
                byte[] key2 = { 0, 0, 0, 0, 0, 0 };
                byte [] keyTest =  {12, 6};

                byte [] keyTest2 = {0, 0};
              
                int cos = Dodaj(key,key2);
                statusLabel.Text =     key2[0] + " " + key2[1] + " " + key2[2] + " "+//+ keyTest[6]
                                       key2[3] + " " + key2[4] + " " + key2[5] 
                                       ;
            }
        }
    }
}