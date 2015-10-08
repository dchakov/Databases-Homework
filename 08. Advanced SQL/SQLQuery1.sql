CREATE TABLE WorkHours (
	WorkHourID int IDENTITY,
	EmployeeID int NOT NULL,
	[Date] datetime,
	Task nvarchar(100),
	[Hours] int,
	Comments nvarchar(500),
	CONSTRAINT PK_WorkHours PRIMARY KEY(WorkHourID),
	CONSTRAINT FK_WorkHourss_Employees FOREIGN KEY(EmployeeID)
	REFERENCES Employees(EmployeeID)
)
GO

INSERT INTO WorkHours(EmployeeID, [Date], Task, [Hours], Comments)
VALUES
(2, GETDATE(),'Read SQL', 8, 'Database homework'),
(3, GETDATE(),'Learn AppHarbour', 12, 'JS aplication')

UPDATE WorkHours
SET [Hours] = 5
WHERE EmployeeID = 2

DELETE FROM WorkHours
WHERE Task='Read SQL'

CREATE TABLE WorkHoursLogs (
	WorkHoursLogID int IDENTITY,
	EmployeeID int NOT NULL,
	[Date] datetime,
	Task nvarchar(100),
	[Hours] int,
	Comments nvarchar(500),
	Command nvarchar(30) NOT NULL,
	CONSTRAINT PK_WorkHoursLogs PRIMARY KEY(WorkHoursLogID),
	CONSTRAINT FK_WorkHoursLogs_Employees FOREIGN KEY(EmployeeID)
	REFERENCES Employees(EmployeeID)
)
GO