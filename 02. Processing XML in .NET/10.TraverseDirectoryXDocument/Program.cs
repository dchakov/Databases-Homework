using System.IO;
using System.Xml.Linq;

namespace _10.TraverseDirectoryXDocument
{
    class Program
    {
        static void Main()
        {
            // 10.Rewrite the last exercises using XDocument, XElement and XAttribute
            // https://msdn.microsoft.com/en-us/library/system.io.directoryinfo(v=vs.110).aspx

            DirectoryInfo directoryInfo = new DirectoryInfo(@"C:\Users\Nevena\Dropbox\education\Chapter11_Database\Databases");

            XElement dirXml = new XElement("directory");
            dirXml.Add(TraverseDirectory(directoryInfo));
            dirXml.Save("../../directory.xml");
        }

        private static XElement TraverseDirectory(DirectoryInfo directoryInfo)
        {
            XElement dirElement = new XElement("dir",
                    new XAttribute("name", directoryInfo.Name));
           
            foreach (var directory in directoryInfo.GetDirectories())
            {
                dirElement.Add(TraverseDirectory(directory));
            }

            foreach (var file in directoryInfo.GetFiles())
            {
                dirElement.Add(new XElement("file",
                    new XAttribute("name", file.Name)));
            }

            return dirElement;
        }
    }
}
