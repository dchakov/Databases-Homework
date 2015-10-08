USE TelerikAcademy

--1.	Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.
--	*	Use a nested `SELECT` statement.

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary =
	(SELECT MIN(Salary) FROM Employees)

--2.	Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.

SELECT FirstName, LastName, Salary
FROM Employees
WHERE 
	Salary > (SELECT MIN(Salary) FROM Employees) AND
	Salary <= (SELECT MIN(Salary)*1.1 FROM Employees)
ORDER BY Salary

--3.	Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department.
--	*	Use a nested `SELECT` statement.

SELECT e.FirstName +' '+ e.LastName AS [Full Name], e.Salary, d.Name
FROM Employees e
 INNER JOIN Departments d
 ON e.DepartmentID = d.DepartmentID
WHERE Salary =
	(SELECT MIN(Salary) FROM Employees
	WHERE DepartmentID = e.DepartmentID)
ORDER BY Salary

--4.	Write a SQL query to find the average salary in the department #1.

SELECT AVG(Salary) AS [Average Salary]
FROM Employees
WHERE DepartmentID = 1

--5.	Write a SQL query to find the average salary  in the "Sales" department.

SELECT AVG(Salary) AS [Average Salary]
FROM Employees e
 INNER JOIN Departments d
 ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

--6.	Write a SQL query to find the number of employees in the "Sales" department.

SELECT COUNT(*) AS [Number of Employees]
FROM Employees e
 INNER JOIN Departments d
 ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

--7.	Write a SQL query to find the number of all employees that have manager.

SELECT COUNT(ManagerID) AS [Number of Employees with manager]
FROM Employees

--8.	Write a SQL query to find the number of all employees that have no manager.

SELECT COUNT(*) AS [Number of Employees with NO manager]
FROM Employees
WHERE ManagerID IS NULL

--9.	Write a SQL query to find all departments and the average salary for each of them.

SELECT d.Name, AVG(e.Salary) AS [Average Salary of Department]
FROM Employees e
 INNER JOIN Departments d
 ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name

--10.	Write a SQL query to find the count of all employees in each department and for each town.

SELECT d.Name AS Department, t.Name AS Town, COUNT(*) AS [Number Of Employees]
FROM Employees e
	INNER JOIN Addresses a
	ON a.AddressID = e.AddressID
	INNER JOIN Towns t
	ON a.TownID = t.TownID
	INNER JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, t.Name

--11.	Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.

SELECT m.FirstName, m.LastName, e.ManagerID, COUNT(*) AS [Number of Employees]
FROM Employees e
JOIN Employees m
ON e.ManagerID = m.EmployeeID
GROUP BY m.FirstName, m.LastName, e.ManagerID
HAVING COUNT(*) = 5

--12.	Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)".

SELECT e.FirstName +' '+ e.LastName AS [Full Name],
	 ISNULL(m.FirstName +' '+ m.LastName, '(no manager)') AS [Manager Id]
FROM Employees e
LEFT OUTER JOIN Employees m
ON e.ManagerID = m.EmployeeID

--13.	Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. Use the built-in `LEN(str)` function.

SELECT FirstName +' '+ LastName AS [Full Name]
FROM Employees
WHERE LEN(Lastname) = 5

--14.	Write a SQL query to display the current date and time in the following format "`day.month.year hour:minutes:seconds:milliseconds`".
--	*	Search in Google to find how to format dates in SQL Server.
--15.	Write a SQL statement to create a table `Users`. Users should have username, password, full name and last login time.
--	*	Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
--	*	Define the primary key column as identity to facilitate inserting records.
--	*	Define unique constraint to avoid repeating usernames.
--	*	Define a check constraint to ensure the password is at least 5 characters long.
--16.	Write a SQL statement to create a view that displays the users from the `Users` table that have been in the system today.
--	*	Test if the view works correctly.
--17.	Write a SQL statement to create a table `Groups`. Groups should have unique name (use unique constraint).
--	*	Define primary key and identity column.
--18.	Write a SQL statement to add a column `GroupID` to the table `Users`.
--	*	Fill some data in this new column and as well in the `Groups table.
--	*	Write a SQL statement to add a foreign key constraint between tables `Users` and `Groups` tables.
--19.	Write SQL statements to insert several records in the `Users` and `Groups` tables.
--20.	Write SQL statements to update some of the records in the `Users` and `Groups` tables.
--21.	Write SQL statements to delete some of the records from the `Users` and `Groups` tables.
--22.	Write SQL statements to insert in the `Users` table the names of all employees from the `Employees` table.
--	*	Combine the first and last names as a full name.
--	*	For username use the first letter of the first name + the last name (in lowercase).
--	*	Use the same for the password, and `NULL` for last login time.
--23.	Write a SQL statement that changes the password to `NULL` for all users that have not been in the system since 10.03.2010.
--24.	Write a SQL statement that deletes all users without passwords (`NULL` password).
--25.	Write a SQL query to display the average employee salary by department and job title.
--26.	Write a SQL query to display the minimal employee salary by department and job title along with the name of some of the employees that take it.
--27.	Write a SQL query to display the town where maximal number of employees work.
--28.	Write a SQL query to display the number of managers from each town.
--29.	Write a SQL to create table `WorkHours` to store work reports for each employee (employee id, date, task, hours, comments).
--	*	Don't forget to define  identity, primary key and appropriate foreign key. 
--	*	Issue few SQL statements to insert, update and delete of some data in the table.
--	*	Define a table `WorkHoursLogs` to track all changes in the `WorkHours` table with triggers.
--		*	For each change keep the old record data, the new record data and the command (insert / update / delete).
--30.	Start a database transaction, delete all employees from the '`Sales`' department along with all dependent records from the pother tables.
--	*	At the end rollback the transaction.
--31.	Start a database transaction and drop the table `EmployeesProjects`.
--	*	Now how you could restore back the lost table data?
--32.	Find how to use temporary tables in SQL Server.
--	*	Using temporary tables backup all records from `EmployeesProjects` and restore them back after dropping and re-creating the table.
