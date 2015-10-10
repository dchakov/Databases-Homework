--1.	Create a database with two tables: `Persons(Id(PK), FirstName, LastName, SSN)` and `Accounts(Id(PK), PersonId(FK), Balance)`.
--	*	Insert few records for testing.
--	*	Write a stored procedure that selects the full names of all persons.

USE [master]
GO

CREATE DATABASE PeopleDB
GO

USE PeopleDB
GO

CREATE TABLE Persons(
	Id int IDENTITY NOT NULL PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	SSN nvarchar(10) NOT NULL
)
GO

CREATE TABLE Accounts(
	Id int IDENTITY NOT NULL PRIMARY KEY,
	PersonId int NOT NULL,
	Balance money NOT NULL
	CONSTRAINT FK_Accounts_Persons FOREIGN KEY(PersonId)
	REFERENCES Persons(Id)
)
GO

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES
('Ivan', 'Nikolov', 6912063456),
('Asen', 'Ivanov', 7003022313),
('Hristo', 'Prodanov', 7301016789),
('Nikolaj', 'Haitov', 8904056789)

INSERT INTO Accounts(PersonId, Balance)
VALUES
(1, 2500.45),
(2, 1456.25),
(3, 1234.78),
(4, 678.40)

CREATE PROCEDURE dbo.usp_PersonsFullName
AS
	SELECT FirstName + ' ' + LastName AS [Full Name]
	FROM Persons
GO

EXEC usp_PersonsFullName

--2.	Create a stored procedure that accepts a number as a parameter and returns all persons who have more money in their accounts than the supplied number.

CREATE PROCEDURE dbo.usp_PersonsWithMoreMoneyInBalanceThan(
@moneyInBalance money)
AS
	SELECT FirstName + ' ' + LastName AS [Full Name], SSN, Balance
	FROM Persons p
	JOIN Accounts a
	ON p.Id = a.PersonId
	WHERE a.Balance > @moneyInBalance
GO

EXEC usp_PersonsWithMoreMoney 1500

--3.	Create a function that accepts as parameters – sum, yearly interest rate and number of months.
--	*	It should calculate and return the new sum.
--	*	Write a `SELECT` to test whether the function works as expected.

CREATE FUNCTION dbo.ufn_CalculateInterest(
@sum money, @interestRate float, @months int)
RETURNS money
AS
BEGIN
RETURN @sum + @sum * (@interestRate/12/100) * @months
END
GO

SELECT Balance, dbo.ufn_CalculateInterest(Balance, 10, 12) AS [Current Balance]
FROM Accounts

--4.	Create a stored procedure that uses the function from the previous example to give an interest to a person's account for one month.
--	*	It should take the `AccountId` and the interest rate as parameters.

CREATE PROCEDURE [dbo].[usp_InterestPerMonthPerPerson](
@accountId int, @interestRate float)
AS
DECLARE @balance money = 
(SELECT Balance FROM Accounts WHERE Id = @accountId)

SELECT Balance, dbo.ufn_CalculateInterest(Balance, @interestRate, 1)- @balance AS [Current Interest]
FROM Accounts
WHERE Id = @accountId
GO

EXEC usp_InterestPerMonthPerPerson 3, 12

--5.	Add two more stored procedures `WithdrawMoney(AccountId, money)` and `DepositMoney(AccountId, money)` that operate in transactions.

CREATE PROCEDURE [dbo].[usp_WithdrawMoney](@accountId int, @money money)
AS
BEGIN
	UPDATE Accounts
	SET Balance -=@money
	WHERE Id = @accountId
	END
GO

EXEC usp_WithdrawMoney 3, 100

CREATE PROCEDURE [dbo].[usp_DepositMoney](@accountId int, @money money)
AS
BEGIN
	UPDATE Accounts
	SET Balance +=@money
	WHERE Id = @accountId
	END
GO

EXEC usp_DepositMoney 3, 500


--6.	Create another table – `Logs(LogID, AccountID, OldSum, NewSum)`.
--	*	Add a trigger to the `Accounts` table that enters a new entry into the `Logs` table every time the sum on an account changes.

CREATE TABLE Logs(
	LogID int IDENTITY PRIMARY KEY,
	AccountID int NOT NULL,
	OldSum money,
	NewSum money,
	CONSTRAINT FK_Logs_Accounts FOREIGN KEY(AccountID)
	REFERENCES Accounts(Id)
)
GO

CREATE TRIGGER tr_AccountUpdate ON Accounts FOR UPDATE
AS
INSERT INTO Logs(AccountID, OldSum, NewSum)
SELECT i.Id, d.Balance, i.Balance
FROM inserted i, deleted d
GO

EXEC usp_WithdrawMoney 3, 100

EXEC usp_DepositMoney 4, 500

--7.	Define a function in the database `TelerikAcademy` that returns all Employee's names (first or middle or last name) and all town's names that are comprised of given set of letters.
--	*	_Example_: '`oistmiahf`' will return '`Sofia`', '`Smith`', … but not '`Rob`' and '`Guy`'.

use TelerikAcademy
GO

CREATE FUNCTION ufn_CheckName(
@nameToCheck NVARCHAR(50), 
@letters NVARCHAR(50))
RETURNS INT
AS
BEGIN
        DECLARE @i INT = 1
		DECLARE @currentChar NVARCHAR(1)
        WHILE (@i <= LEN(@nameToCheck))
			BEGIN
				SET @currentChar = SUBSTRING(@nameToCheck,@i, 1)
					IF (CHARINDEX(LOWER(@currentChar),LOWER(@letters)) <= 0) 
						BEGIN  
							RETURN 0
						END
				SET @i = @i + 1
			END
        RETURN 1
END
GO

CREATE FUNCTION dbo.ufn_AllEmploeeysAndTownByStringCondition(@format nvarchar(50))
RETURNS @table TABLE
	([Name] nvarchar(50) NOT NULL)
AS
BEGIN
	INSERT @table
	SELECT newTbl.LastName FROM
		(SELECT LastName FROM Employees
		UNION
		SELECT Name FROM Towns) as newTbl
		WHERE dbo.ufn_CheckName(newTbl.LastName, @format) > 0
	 RETURN
END
GO

SELECT * FROM ufn_AllEmploeeysAndTownByStringCondition('oiseltmiahf')

--8.	Using database cursor write a T-SQL script that scans all employees and their addresses and prints all pairs of employees that live in the same town.

DECLARE empCursor CURSOR READ_ONLY FOR
  SELECT e.FirstName, e.LastName, t.Name FROM Employees e
  JOIN Addresses a
  ON e.AddressID = a.AddressID
  JOIN Towns t
  ON a.TownID = t.TownID

OPEN empCursor
DECLARE @firstName nvarchar(50), @lastName nvarchar(50), @town nvarchar(50)
FETCH NEXT FROM empCursor INTO @firstName, @lastName, @town

WHILE @@FETCH_STATUS = 0
  BEGIN
  			  DECLARE empCursor1 CURSOR READ_ONLY FOR
			  SELECT e.FirstName, e.LastName, t.Name FROM Employees e
			  JOIN Addresses a
			  ON e.AddressID = a.AddressID
			  JOIN Towns t
			  ON a.TownID = t.TownID

			OPEN empCursor1
			DECLARE @firstName1 nvarchar(50), @lastName1 nvarchar(50), @town1 nvarchar(50)
			FETCH NEXT FROM empCursor1 INTO @firstName1, @lastName1, @town1

			WHILE @@FETCH_STATUS = 0
			  BEGIN
			  IF(@town=@town1 AND @firstName != @firstName1 AND @lastName != @lastName1)
				  BEGIN
					PRINT @town+':'+ @firstName + ' ' + @lastName + ':' + @firstName1 + ' ' + @lastName1 
				  END
				FETCH NEXT FROM empCursor1 INTO @firstName1, @lastName1, @town1
			  END

			CLOSE empCursor1
			DEALLOCATE empCursor1

    FETCH NEXT FROM empCursor  INTO @firstName, @lastName, @town
  END

CLOSE empCursor
DEALLOCATE empCursor


--9.	*Write a T-SQL script that shows for each town a list of all employees that live in it.
--	*	_Sample output_:	
--```sql
--Sofia -> Martin Kulov, George Denchev
--Ottawa -> Jose Saraiva
--…
--```

DECLARE empCursor CURSOR READ_ONLY FOR
  SELECT DISTINCT t.Name, t.Name AS [fullNames] FROM Towns t

OPEN empCursor
DECLARE @town nvarchar(50), @fullNames nvarchar(2000)
FETCH NEXT FROM empCursor INTO @town, @fullNames

WHILE @@FETCH_STATUS = 0
  BEGIN
  			  DECLARE empCursor1 CURSOR READ_ONLY FOR
			  SELECT e.FirstName, e.LastName, t.Name FROM Employees e
			  JOIN Addresses a
			  ON e.AddressID = a.AddressID
			  JOIN Towns t
			  ON a.TownID = t.TownID

			OPEN empCursor1
			DECLARE @firstName1 nvarchar(50), @lastName1 nvarchar(50), @town1 nvarchar(50)
			FETCH NEXT FROM empCursor1 INTO @firstName1, @lastName1, @town1

			WHILE @@FETCH_STATUS = 0
			  BEGIN
			  IF(@town=@town1)
				  BEGIN
					SET @fullNames+= @firstName1 + ' ' + @lastName1 + ', ' 
				  END
				FETCH NEXT FROM empCursor1 INTO @firstName1, @lastName1, @town1
			  END
			  
			CLOSE empCursor1
			DEALLOCATE empCursor1
		PRINT @town + ' -> '+ @fullNames
    FETCH NEXT FROM empCursor INTO @town, @fullNames
  END

CLOSE empCursor
DEALLOCATE empCursor

--10.	Define a .NET aggregate function `StrConcat` that takes as input a sequence of strings and return a single string that consists of the input strings separated by '`,`'.
--	*	For example the following SQL statement should return a single string:

--```sql
--SELECT StrConcat(FirstName + ' ' + LastName)
--FROM Employees
--```

EXEC sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

CREATE ASSEMBLY CommaSeparatedValue
AUTHORIZATION dbo
FROM 'C:\Users\Nevena\Dropbox\education\Chapter11_Database\Databases-Homework\09. Transact-SQL\CommaSeparatedValue\bin\Debug\CommaSeparatedValue.dll'
WITH PERMISSION_SET = SAFE;
GO

CREATE AGGREGATE dbo.StringConcat (
@value nvarchar(MAX), 
@delimiter nvarchar(50)
) 
RETURNS nvarchar(MAX)
EXTERNAL NAME CommaSeparatedValue.[CommaSeparatedValue.CommaSeparatedValue]
--–EXTERNAL NAME SQLAssemblyName.[C#NameSpace”.C#ClassName].C#MethodName

SELECT dbo.StringConcat(FirstName, ',')
FROM Employees

DROP AGGREGATE dbo.StringConcat
DROP ASSEMBLY CommaSeparatedValue