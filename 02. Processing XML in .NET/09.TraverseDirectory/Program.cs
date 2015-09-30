using System.IO;
using System.Text;
using System.Xml;

namespace _09.TraverseDirectory
{
    class Program
    {
        static void Main()
        {
            // 9.Write a program to traverse given directory and write to a XML file its contents together with all subdirectories and files.
            // Use tags <file> and <dir> with appropriate attributes.
            // For the generation of the XML document use the class XmlWriter.

            // https://msdn.microsoft.com/en-us/library/system.io.directoryinfo(v=vs.110).aspx

            string fileName = "../../directory.xml";
            Encoding encoding = Encoding.UTF8;
            DirectoryInfo directory = new DirectoryInfo(@"C:\Users\Nevena\Dropbox\education\Chapter11_Database\Databases");

            using (XmlTextWriter writer = new XmlTextWriter(fileName, encoding))
            {
                writer.Formatting = Formatting.Indented;
                writer.IndentChar = '\t';
                writer.Indentation = 1;

                writer.WriteStartDocument();
                writer.WriteStartElement("directory");
                TraverseDirectory(writer, directory);
                writer.WriteEndDocument();
            }
        }

        private static void TraverseDirectory(XmlTextWriter writer, DirectoryInfo directory)
        {
            foreach (var dir in directory.GetDirectories())
            {
                writer.WriteStartElement("dir");
                writer.WriteAttributeString("name", dir.Name);
                TraverseDirectory(writer, dir);
                writer.WriteEndElement();
            }

            foreach (var file in directory.GetFiles())
            {
                writer.WriteStartElement("file");
                writer.WriteAttributeString("name", file.Name);
                writer.WriteEndElement();
            }
        }
    }
}
