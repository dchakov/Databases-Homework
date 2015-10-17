namespace EmployeeInh
{
    using EntityFrameworkModels;
    using System;

    public class Program
    {
        public static void Main()
        {
            // 8.By inheriting the Employee entity class create a class which allows employees to access their corresponding territories as property of type EntitySet<T>.

            // class EmployeeExtend in EntityFrameworkModels

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
