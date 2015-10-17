using EntityFrameworkModels;
using System;
using System.Configuration;

namespace DatabaseClone
{
    class Program
    {
        static void Main()
        {
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);

            ConnectionStringSettings csSettings =
                    new ConnectionStringSettings("NorthwindEntities",
                    "metadata = res://*/NorthwindModel.csdl|res://*/NorthwindModel.ssdl|res://*/NorthwindModel.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=.;initial catalog=NorthwindTwin;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework&quot;",
                    "System.Data.EntityClient");

            ConnectionStringsSection csSection = config.ConnectionStrings;
            csSection.ConnectionStrings.Add(csSettings);
            config.Save(ConfigurationSaveMode.Modified);

            using (var db = new NorthwindEntities())
            {
                Console.WriteLine("Created a clone of northwind");
                Console.WriteLine(db.Database.CreateIfNotExists());
            }
        }
    }
}
