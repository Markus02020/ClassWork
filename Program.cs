using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
    internal class Program
    {
        static void Main(string[] args)
        {
        }

    }
    public abstract class Animal
    {
        private int _number;
        public Animal(int number)
        {
            _number = number;
        }
        public void Grow(int n)
        {
            n++;
        }
        public virtual void asdasd()
        {
            Console.WriteLine("asdasd");
        }
        public abstract void ads();
    }
    public class Cat : Animal
    {
        public Cat(int number): base(number)
        {

        }
        public override void ads() 
        {
            Console.WriteLine();
        }
    }
    public class Dog: Animal
    {
        public Dog(int n): base(n)
        {

        }
        
        public override void ads()
        {
            Console.WriteLine();
        }
    }
}
