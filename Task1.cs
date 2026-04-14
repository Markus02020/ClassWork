using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    public class Task1 : Pink
    {
        private int _output;
        public Task1(string name) : base(name)
        {
            _output = 0;
        }

        public override void Review()
        {
            throw new NotImplementedException();
        }
        public override string ToString()
        {
            return $"{Name}{Environment.NewLine}{_output}";
        }
    }
}
