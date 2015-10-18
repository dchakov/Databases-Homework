namespace StudentSystem.Data.Migrations
{
    using System.Data.Entity.Migrations;
    using StudentSystem.Data;
    using Models;

    public sealed class Configuration : DbMigrationsConfiguration<StudentSystemContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = true;
            this.ContextKey = "StudentSystem.Data.StudentSystemContext";
        }

        protected override void Seed(StudentSystemContext context)
        {
            context.Courses
                .AddOrUpdate(
                c => c.Name,
                new Course()
                {
                    Name = "Seeded OOP",
                    Description = "Seeded description",
                    Materials = "Seeded Some materials"
                },
                new Course
                {
                    Name = "Seeded HTML",
                    Description = "Seeded description",
                    Materials = "Seeded www.telerik.com"
                });
        }
    }
}
