using System;
using System.Collections.Generic;
using System.Xml;
using System.Xml.Linq;

namespace XMLReader
{
    class Program
    {
        static void Main()
        {
            // 5.Write a program, which using XmlReader extracts all song titles from catalog.xml.

            using (XmlReader reader = XmlReader.Create("../../catalog.xml"))
            {
                while (reader.Read())
                {
                    if ((reader.NodeType == XmlNodeType.Element) && 
                        (reader.Name == "title"))
                    {
                        Console.WriteLine(reader.ReadElementContentAsString());
                    }
                }
            }

            // 6.Rewrite the same using XDocument and LINQ query.

            Console.WriteLine(new string('-', 25));
            Console.WriteLine("LINQ");
            Console.WriteLine(new string('-', 25));

            XDocument xmlDoc = XDocument.Load("../../catalog.xml");
            IEnumerable<XElement> songs = xmlDoc.Descendants("title");
            foreach (var element in songs)
            {
                Console.WriteLine(element.Value);
            }
        }
    }
}
