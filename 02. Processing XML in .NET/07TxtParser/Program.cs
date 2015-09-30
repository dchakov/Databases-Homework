using System;
using System.IO;
using System.Xml.Linq;

namespace _07TxtParser
{
    class Program
    {
        public static void Main()
        {
            // 7.In a text file we are given the name, address and phone number of given person (each at a single line).
            // Write a program, which creates new XML document, which contains these data in structured XML format.

            try
            {
                using (StreamReader streamReader = new StreamReader("../../person.txt"))
                {
                    string name = streamReader.ReadLine();
                    string address = streamReader.ReadLine();
                    string phone = streamReader.ReadLine();

                    XElement personXml = new XElement("person",
                        new XElement("name", name),
                        new XElement("adress", address),
                        new XElement("phone", phone));

                    Console.WriteLine(personXml);
                    personXml.Save("../../person.xml");
                }
                
            }
            catch (Exception e)
            {
                Console.WriteLine("The file could not be read:");
                Console.WriteLine(e.Message);
            }
        }


    }
}
