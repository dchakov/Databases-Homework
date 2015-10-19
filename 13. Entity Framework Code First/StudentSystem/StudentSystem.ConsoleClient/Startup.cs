namespace StudentSystem.ConsoleClient
{
    using System;
    using System.Linq;
    using Data;
    using Models;
    using System.Data.Entity;
    using Data.Migrations;

    public class Startup
    {
        public static void Main()
        {
            Database.SetInitializer(
                new MigrateDatabaseToLatestVersion
                <StudentSystemContext, Configuration>());

            var db = new StudentSystemContext();

            var student = new Student
            {
                FirstName = "Ivan",
                LastName = "Ivanov",
                Number = 13532
            };

            var course = new Course
            {
                Name = "JS",
                Description = "JS",
                Materials = "www.telerik"
            };

            var homework = new Homework
            {
                Content = "Done",
                TimeSent = DateTime.Now,
                StudentId = 2,
                CourseId = 2
            };

            db.Homeworks.Add(homework);
            student.Courses.Add(course);
            db.Students.Add(student);
            db.Courses.Add(course);
            db.SaveChanges();

            Console.WriteLine(db.Students.Count());
            Console.WriteLine(db.Courses.Count());
        }
    }
}
