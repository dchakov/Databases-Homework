using System.Xml.Xsl;

namespace _13_14XLSTransforms
{
    class Program
    {
        static void Main()
        {
            // 13.Create an XSL stylesheet, which transforms the file catalog.xml into HTML document, formatted for viewing in a standard Web-browser.
            // 14.Write a C# program to apply the XSLT stylesheet transformation on the file catalog.xml using the class XslTransform.

            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load("../../catalog.xslt");
            xslt.Transform("../../catalog.xml", "../../catalog.html");
        }
    }
}
