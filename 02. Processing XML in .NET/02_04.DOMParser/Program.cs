using System;
using System.Xml;
using System.Collections;

namespace XMLProcessingIn.NET
{
    public class Program
    {
        static void Main()
        {
            // 2.Write program that extracts all different artists which are found in the catalog.xml.
            // For each author you should print the number of albums in the catalogue.
            // Use the DOM parser and a hash-table.

            XmlDocument catalog = new XmlDocument();
            catalog.Load("../../catalog.xml");
            Hashtable artists = new Hashtable();
            XmlNode rootNode = catalog.DocumentElement;

            foreach (XmlNode node in rootNode.ChildNodes)
            {
                string currentArtistName = node["artist"].InnerText;
                if (artists.Contains(currentArtistName))
                {
                    artists[currentArtistName] = (int)artists[currentArtistName] + 1;
                }
                else
                {
                    artists.Add(currentArtistName, 1);
                }
            }

            foreach (DictionaryEntry item in artists)
            {
                Console.WriteLine("Artist = {0} => {1} albums", item.Key, item.Value);
            }

            // 3.Implement the previous using XPath.

            Console.WriteLine(new string('-', 25));
            Hashtable artistsXPath = new Hashtable();
            string xPath = "/catalogue/album";

            XmlNodeList artistList = catalog.SelectNodes(xPath);

            foreach (XmlNode node in artistList)
            {
                string currentArtistName = node.SelectSingleNode("artist").InnerText;
                if (artistsXPath.Contains(currentArtistName))
                {
                    artistsXPath[currentArtistName] = (int)artistsXPath[currentArtistName] + 1;
                }
                else
                {
                    artistsXPath.Add(currentArtistName, 1);
                }
            }

            foreach (DictionaryEntry item in artistsXPath)
            {
                Console.WriteLine("Artist = {0} => {1} albums", item.Key, item.Value);
            }

            // 4.Using the DOM parser write a program to delete from catalog.xml all albums having price > 20.

            Console.WriteLine(new string('-', 25));
            foreach (XmlElement node in rootNode.SelectNodes("album"))
            {
                var price = Decimal.Parse(node["price"].InnerText);
                var filterPrivce = (decimal)20;
                if (price > filterPrivce)
                {
                    rootNode.RemoveChild(node);
                }
            }

            Console.WriteLine("writing in catalogNew.xml....");
            catalog.Save("../../catalogNew.xml");
        }
    }
}
