using System;
using System.Xml.Linq;
using System.Xml.Schema;

namespace _16.XSDSchema
{
    class Program
    {
        static void Main(string[] args)
        {
            // 16.Using Visual Studio generate an XSD schema for the file catalog.xml.
            // Write a C# program that takes an XML file and an XSD file (schema) and validates the XML file against the schema.
            // Test it with valid XML catalogs and invalid XML catalogs.
            // https://msdn.microsoft.com/en-us/library/bb387037.aspx

            XmlSchemaSet schemas = new XmlSchemaSet();
            schemas.Add(string.Empty, "../../catalog.xsd");

            Console.WriteLine("Attempting to validate");
            XDocument catalog = XDocument.Load("../../catalog.xml");
            bool errors = false;
            catalog.Validate(schemas, (o, e) =>
            {
                Console.WriteLine("{0}", e.Message);
                errors = true;
            });

            Console.WriteLine("catalog {0}", errors ? "did not validate" : "validated");


            // Modify the source document so that it will not validate.

            Console.WriteLine(new string('-',25));
            catalog.Root.Element("album").Element("price").Value = "AAAAA";
            Console.WriteLine("Attempting to validate after modification");
            errors = false;
            catalog.Validate(schemas, (o, e) =>
            {
                Console.WriteLine("{0}", e.Message);
                errors = true;
            });

            Console.WriteLine("catalog {0}", errors ? "did not validate" : "validated");
        }
    }
}
