using System;
using System.Text;
using System.Xml;

namespace _08.CreateAlbum
{
    class Program
    {
        static void Main()
        {
            // 8.Write a program, which (using XmlReader and XmlWriter) reads the file catalog.xml and creates the file album.xml,
            // in which stores in appropriate way the names of all albums and their authors.

            string fileName = "../../album.xml";
            Encoding encoding = Encoding.UTF8;
            using (XmlReader reader = XmlReader.Create("../../catalog.xml"))
            {
                using (XmlTextWriter writer = new XmlTextWriter(fileName, encoding))
                {
                    writer.Formatting = Formatting.Indented;
                    writer.IndentChar = '\t';
                    writer.Indentation = 1;

                    writer.WriteStartDocument();
                    writer.WriteStartElement("albums");
                    writer.WriteAttributeString("name", "My Albums");

                    while (reader.Read())
                    {
                        if (reader.NodeType == XmlNodeType.Element &&
                            (reader.Name == "name"))
                        {
                            string name = reader.ReadElementContentAsString();
                            reader.ReadToFollowing("artist");
                            string artist = reader.ReadElementContentAsString();
                            Console.WriteLine(name);
                            Console.WriteLine(artist);

                            writer.WriteStartElement("album");
                            writer.WriteElementString("name", name);
                            writer.WriteElementString("artist", artist);
                            writer.WriteEndElement();
                            
                        }
                    }
                    writer.WriteEndDocument();
                }
            }
        }
    }
}
