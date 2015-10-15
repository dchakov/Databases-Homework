namespace _09_10.MySqlDB
{
    using MySql.Data.MySqlClient;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    public class Program
    {
        internal static void Main()
        {
            // 9. Download and install MySQL database, MySQL Connector/Net (.NET Data Provider for MySQL) + MySQL Workbench GUI administration tool.
            // Create a MySQL database to store Books(title, author, publish date and ISBN).
            // Write methods for listing all books, finding a book by name and adding a book.

           MySqlConnection dbConnection = new MySqlConnection("Server=localhost; Port=3306;" +
                "Database=library; Uid = root; Pwd = root; pooling = true");

            dbConnection.Open();
            using (dbConnection)
            {
                int newBook = AddNewBookToDBTable(dbConnection, "King Lion", "James Clavel", DateTime.Parse("2015.10.10"), 1234567890123);
                Console.WriteLine("Inserted new product with Id: {0}", newBook);
                Console.WriteLine(new string('-', 30));
            }
        }

        private static int AddNewBookToDBTable(MySqlConnection dbConnection, string title, string author, DateTime publishDate, ulong isbn)
        {
            string sqlStringCommand = @"
                    INSERT INTO Books(title, author, publishDate, isbn)
                    VALUES (@title, @author, @publishDate, @isbn)";

            MySqlCommand insertBook = new MySqlCommand(sqlStringCommand, dbConnection);
            insertBook.Parameters.AddWithValue("@title", title);
            insertBook.Parameters.AddWithValue("@author", author);
            insertBook.Parameters.AddWithValue("@publishDate", publishDate);
            insertBook.Parameters.AddWithValue("@isbn", isbn);

            insertBook.ExecuteNonQuery();

            return (int)insertBook.LastInsertedId;
        }
    }
}
