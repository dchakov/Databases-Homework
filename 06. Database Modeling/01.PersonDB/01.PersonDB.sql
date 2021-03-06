USE [master]
GO
/****** Object:  Database [PersonDB]    Script Date: 05/10/2015 11:56:56 ******/
CREATE DATABASE [PersonDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PersonsDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PersonsDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PersonsDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PersonsDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PersonDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PersonDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PersonDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PersonDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PersonDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PersonDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PersonDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PersonDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PersonDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PersonDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PersonDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PersonDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PersonDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PersonDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PersonDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PersonDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PersonDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PersonDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PersonDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PersonDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PersonDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PersonDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PersonDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PersonDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PersonDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PersonDB] SET  MULTI_USER 
GO
ALTER DATABASE [PersonDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PersonDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PersonDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PersonDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PersonDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PersonDB', N'ON'
GO
USE [PersonDB]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 05/10/2015 11:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressText] [ntext] NOT NULL,
	[TownId] [int] NOT NULL,
 CONSTRAINT [PK_ADDRESS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Continent]    Script Date: 05/10/2015 11:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Continent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Continent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 05/10/2015 11:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ContinentId] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 05/10/2015 11:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[AddressId] [int] NOT NULL,
 CONSTRAINT [PK_Persons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Town]    Script Date: 05/10/2015 11:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Town](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CountryID] [int] NOT NULL,
 CONSTRAINT [PK_Town] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([Id], [AddressText], [TownId]) VALUES (1, N'Key Poh Road', 3)
INSERT [dbo].[Address] ([Id], [AddressText], [TownId]) VALUES (2, N'Pekin', 5)
INSERT [dbo].[Address] ([Id], [AddressText], [TownId]) VALUES (3, N'Boris I  14', 5)
INSERT [dbo].[Address] ([Id], [AddressText], [TownId]) VALUES (4, N'14 Maria Luisa blv.', 4)
SET IDENTITY_INSERT [dbo].[Address] OFF
SET IDENTITY_INSERT [dbo].[Continent] ON 

INSERT [dbo].[Continent] ([Id], [Name]) VALUES (1, N'Asia')
INSERT [dbo].[Continent] ([Id], [Name]) VALUES (2, N'Europe')
INSERT [dbo].[Continent] ([Id], [Name]) VALUES (3, N'Africa')
SET IDENTITY_INSERT [dbo].[Continent] OFF
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([Id], [Name], [ContinentId]) VALUES (1, N'Singapore', 1)
INSERT [dbo].[Country] ([Id], [Name], [ContinentId]) VALUES (2, N'Thailand', 1)
INSERT [dbo].[Country] ([Id], [Name], [ContinentId]) VALUES (4, N'Bulgaria', 2)
INSERT [dbo].[Country] ([Id], [Name], [ContinentId]) VALUES (5, N'Macedonia', 2)
INSERT [dbo].[Country] ([Id], [Name], [ContinentId]) VALUES (6, N'Marocco', 3)
INSERT [dbo].[Country] ([Id], [Name], [ContinentId]) VALUES (7, N'Egypt', 3)
SET IDENTITY_INSERT [dbo].[Country] OFF
SET IDENTITY_INSERT [dbo].[Person] ON 

INSERT [dbo].[Person] ([Id], [FirstName], [LastName], [AddressId]) VALUES (1, N'Ivan', N'Ivanov', 1)
INSERT [dbo].[Person] ([Id], [FirstName], [LastName], [AddressId]) VALUES (3, N'Ivan', N'Ivanov', 2)
INSERT [dbo].[Person] ([Id], [FirstName], [LastName], [AddressId]) VALUES (4, N'Kiro', N'Maglata', 3)
INSERT [dbo].[Person] ([Id], [FirstName], [LastName], [AddressId]) VALUES (5, N'Kiro', N'Tkvata', 4)
SET IDENTITY_INSERT [dbo].[Person] OFF
SET IDENTITY_INSERT [dbo].[Town] ON 

INSERT [dbo].[Town] ([Id], [Name], [CountryID]) VALUES (3, N'Singapore', 1)
INSERT [dbo].[Town] ([Id], [Name], [CountryID]) VALUES (4, N'Bangkok', 2)
INSERT [dbo].[Town] ([Id], [Name], [CountryID]) VALUES (5, N'Plovdiv', 4)
INSERT [dbo].[Town] ([Id], [Name], [CountryID]) VALUES (6, N'Lovech', 4)
INSERT [dbo].[Town] ([Id], [Name], [CountryID]) VALUES (8, N'Varna', 4)
INSERT [dbo].[Town] ([Id], [Name], [CountryID]) VALUES (9, N'Kairo', 7)
SET IDENTITY_INSERT [dbo].[Town] OFF
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Town] FOREIGN KEY([TownId])
REFERENCES [dbo].[Town] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Town]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Continent] FOREIGN KEY([ContinentId])
REFERENCES [dbo].[Continent] ([Id])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Continent]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Persons_Address] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Persons_Address]
GO
ALTER TABLE [dbo].[Town]  WITH CHECK ADD  CONSTRAINT [FK_Town_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Town] CHECK CONSTRAINT [FK_Town_Country]
GO
USE [master]
GO
ALTER DATABASE [PersonDB] SET  READ_WRITE 
GO
