using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace Szyfrowanie_DES
{
    class DataPrepare
    {
        private byte[] addRestBlock(byte[] dataArray, int blockLength, int position)
        {
            byte[] block = new byte[blockLength];
            int restData = dataArray.Length % blockLength;
            int numberOfAdditionByte = blockLength - restData;
            int arrayIterator = 0;
            while (arrayIterator < restData)
            {
                block[arrayIterator] = dataArray[position];
                arrayIterator++;
                position++;
            }
            while (arrayIterator < restData + numberOfAdditionByte)
            {
                block[arrayIterator] = 0x00;
                arrayIterator++;
            }
            block[blockLength-1] = Convert.ToByte(numberOfAdditionByte);
            
            return block;
        }
        public byte[][] divideToBlocks(byte[] dataArray, int blockLength)
        { 
            int restData = dataArray.Length % blockLength;
            int numberOfBlocks = dataArray.Length / blockLength;
            if (restData != 0)
                numberOfBlocks++;

            byte [][] blocks  = new byte [numberOfBlocks][];

            int dataArrayIterator = 0;
            for (int i = 0; i < numberOfBlocks; i++)
            {
                
                blocks[i] = new byte[blockLength];

                if (restData != 0)
                    if (i == numberOfBlocks - 1)
                    {
                        blocks[i] = addRestBlock(dataArray, blockLength, dataArrayIterator);
                        break;
                    }
                        

                for (int j = 0; j < blockLength; j++)
                {
                    blocks[i][j] = dataArray[dataArrayIterator];
                    dataArrayIterator++;
                }
            }
                return blocks;
        }
        public byte[] integrateBlocks(byte[][] blocksArray)
        {
            
            int arrayCounter = 0;
         
            int additionContent = blocksArray[blocksArray.Length - 1][blocksArray[blocksArray.Length-1].Length-1];
            int restBlockByte = 16 - additionContent - 1;
            
            bool doing = true;
            for (int i = 0; i < additionContent; i++)
            {
                if (blocksArray[blocksArray.Length - 1][blocksArray[blocksArray.Length - 1].Length - i - 2] != 0x00)
                {
                    doing = false;
                    additionContent = 0;
                    break;
                }                    
            }

            if (doing == true)
                additionContent += 1;
            
            byte[] dataArray = new byte[(blocksArray.Length * blocksArray[1].Length)-additionContent];

            for (int i = 0; i < blocksArray.Length; i++)
            {
                if(i == blocksArray.Length-1)
                    if (doing == true)
                    {
                        for (int j = 0; j < restBlockByte; j++ )
                        {
                            dataArray[arrayCounter] = blocksArray[i][j];
                            arrayCounter++;
                        }
                        break;
                    }
                       
                for (int j = 0; j < blocksArray[i].Length; j++)
                {
                    dataArray[arrayCounter] = blocksArray[i][j];
                    arrayCounter++;
                }
            }
            return dataArray;
        }
        public byte [] readFile(string nameFile)
        {
            FileStream file = new FileStream(nameFile, FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(file);
            byte [] dataArray = new byte[file.Length];

            for (int i = 0; i < file.Length; i++)
            {
                dataArray[i] = br.ReadByte();
            }
            file.Close();
            return dataArray;
        }
        public void writeFile(string nameFile, byte[] dataArray)
        {
            FileStream file = new FileStream(nameFile, FileMode.Open, FileAccess.Write);
            BinaryWriter bw = new BinaryWriter(file);

            for (int i = 0; i < dataArray.Length; i++)
            {
                bw.Write(Convert.ToByte(dataArray[i]));
            }
            file.Close();
        }
    }
}
