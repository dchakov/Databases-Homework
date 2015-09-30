using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace _11.ExtractPrices
{
    class Program
    { 
        static void Main()
        {
            // 11.Write a program, which extract from the file catalog.xml the prices for all albums, published 5 years ago or earlier.
            // Use XPath query.

            Console.WriteLine("XPath query");
            Console.WriteLine(new string('-', 25));

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("../../catalog.xml");
            string xPathQuery = "/catalogue/album[year<2010]";

            XmlNodeList priceList = xmlDoc.SelectNodes(xPathQuery);
            foreach (XmlNode item in priceList)
            {
                string price = item.SelectSingleNode("price").InnerText;
                Console.WriteLine(price);
            }

            // 12.Rewrite the previous using LINQ query.

            Console.WriteLine(new string('-', 25));
            Console.WriteLine("XPath query");
            Console.WriteLine(new string('-', 25));

            XDocument linqDoc = XDocument.Load("../../catalog.xml");

            var albums = from album in linqDoc.Descendants("album")
                         where int.Parse(album.Element("year").Value) < 2010
                         select album;

            foreach (var item in albums)
            {
                Console.WriteLine(item.Element("price").Value);
            }

        }
    }
}
