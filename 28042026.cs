using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string folderpath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            string filePath = Path.Combine(folderpath, "Test","exxample.txt");
            if (!File.Exists(filePath))
            {
                File.Create(filePath).Close();
            }
            string folderpathforfile = Path.GetDirectoryName(filePath);
            if (Directory.Exists(folderpathforfile))
            {
                Console.WriteLine("Directrory exists");
            }
            else
            {
                Directory.CreateDirectory(folderpathforfile);
            }
            File.WriteAllText(filePath,"asdasd");
            File.WriteAllText(filePath, "dsadsa");
            string[] a = new string[] { "ba", "da", "sa" };
            File.WriteAllLines(filePath, a);
            File.AppendAllText(filePath, "Shimi shimi ya simi ya shimi ya");
            File.AppendAllText(filePath, "Shalalala........shalalala");
        }
    }
}
