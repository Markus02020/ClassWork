using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace ConsoleApp3
{
    public class Something
    {
        public string Name { get; private set; }
        public int GooningTime { get; private set; }
        private int[] _ints;
        public int[] Ints => _ints.ToArray();
        public Something(string name = "I have no name, I'm two days old",int iamabouttostartgooning= 7)
        {
            Name = name;
            GooningTime=iamabouttostartgooning;
            _ints = new int[0];
        }
        
    }
    
    public class SomethingDTO
    {
        public int[] _ints;
        public int[] Ints => _ints.ToArray();
        public string Name { get; set; }
        public int GooningTime { get; set; }
        
        public SomethingDTO()
        {
            Name = "V";
            GooningTime = 7;
        }
        public SomethingDTO(Something a)
        {
            Name = a.Name;
            GooningTime= a.GooningTime;
            _ints = a.Ints;
        }
        public void Add(int a)
        {
            Array.Resize(ref _ints, _ints.Length + 1);
            _ints[_ints.Length - 1] = a;
        }
    }
    internal class Program
    {
        static void Main(string[] args)
        {
            Something a = new Something();
            SomethingDTO virodok = new SomethingDTO();
            virodok.Add(5);
            virodok.Add(6);
            virodok.Add(7);
            string folderpath = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            string filepath = Path.Combine(folderpath, "something.xml");
            //Console.WriteLine($"{a.GooningTime} hours,{a.GooningTime} hours is all I can spare to goon with you");
            // Конструктор без параметров, публичные сеттеры, публичный класс
            var serializer = new XmlSerializer(typeof(SomethingDTO));
            using (var stream = new StreamWriter(filepath))
            {
                serializer.Serialize(stream, virodok);
            }

            SomethingDTO aboba;
            using (var reader = new StreamReader(filepath))
            {
                aboba = (SomethingDTO)serializer.Deserialize(reader);
            }
            Something smthng = new Something();
            if (Compare(a, smthng)) { Console.WriteLine("имеется"); }
            else { Console.WriteLine("неимеется"); }
        }
        public static bool Compare(Something a, Something b)
        {
            if (a.Name != b.Name) return false;
            if (a.GooningTime != b.GooningTime) return false;
            return true;
        }
    }
}
