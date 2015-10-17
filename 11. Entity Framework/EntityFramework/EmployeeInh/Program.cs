using EntityFrameworkModels;
using System;

namespace EmployeeInh
{
    public class Program
    {
        public static void Main()
        {
            using (var northwind = new NorthwindEntities())
            {
                var employee = northwind.Employees.Find(2);

                foreach (var item in employee.TerritoryProperty)
                {
                    Console.WriteLine("Employee:{0} Teritory desctiption: {1}", employee.FirstName, item.TerritoryDescription);
                }
            }
        }
    }
}
