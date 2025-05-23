USE [master]
GO
/****** Object:  Database [Aaron'sContacts]    Script Date: 5/6/2025 6:37:47 PM ******/
CREATE DATABASE [Aaron'sContacts]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Contacts', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Contacts.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Contacts_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Contacts_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Aaron'sContacts] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Aaron'sContacts].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Aaron'sContacts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET ARITHABORT OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Aaron'sContacts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Aaron'sContacts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Aaron'sContacts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Aaron'sContacts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET RECOVERY FULL 
GO
ALTER DATABASE [Aaron'sContacts] SET  MULTI_USER 
GO
ALTER DATABASE [Aaron'sContacts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Aaron'sContacts] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Aaron'sContacts] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Aaron'sContacts] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Aaron'sContacts] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Aaron'sContacts] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Aaron''sContacts', N'ON'
GO
ALTER DATABASE [Aaron'sContacts] SET QUERY_STORE = ON
GO
ALTER DATABASE [Aaron'sContacts] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Aaron'sContacts]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAge]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: A scalar function that retrieves the age for us!>
-- =============================================
CREATE FUNCTION [dbo].[GetAge] (@DoB DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;

    -- Calculate age using current date and subtracting years
    SET @Age = DATEDIFF(YEAR, @DoB, GETDATE());

    -- Adjust if birthday hasn't occurred yet this year
    IF (MONTH(@DoB) > MONTH(GETDATE())) 
        OR (MONTH(@DoB) = MONTH(GETDATE()) AND DAY(@DoB) > DAY(GETDATE()))
    BEGIN
        SET @Age = @Age - 1;
    END

    RETURN @Age;
END;
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[MiddleName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[Suffix] [varchar](50) NULL,
	[DoB] [date] NOT NULL,
	[Gender] [int] NOT NULL,
	[Alias] [varchar](255) NULL,
 CONSTRAINT [PK_Contact2] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personal]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personal](
	[Spouse's name] [varchar](50) NOT NULL,
	[Anniversary Date] [date] NOT NULL,
	[PersonalID] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_Personal] PRIMARY KEY CLUSTERED 
(
	[PersonalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PersonalView]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PersonalView]
AS
SELECT c.FirstName, c.LastName, p.[Spouse's name] AS SpouseName, p.[Anniversary Date] AS AnniversaryDate, p.PersonalID, p.ContactId
FROM   dbo.Personal AS p INNER JOIN
             dbo.Contact AS c ON p.ContactId = c.ContactId
GO
/****** Object:  Table [dbo].[StateType]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateType](
	[StateTypeID] [int] IDENTITY(1,1) NOT NULL,
	[StateType] [nchar](2) NULL,
 CONSTRAINT [PK_StateType] PRIMARY KEY CLUSTERED 
(
	[StateTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AddressTypeID]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressTypeID](
	[AddressType] [varchar](50) NULL,
	[AddressTypeID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_AddressTypeID] PRIMARY KEY CLUSTERED 
(
	[AddressTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[ContactId] [int] NOT NULL,
	[Street] [varchar](100) NOT NULL,
	[City] [varchar](100) NOT NULL,
	[State] [int] NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[AddressTypeID] [int] NOT NULL,
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Address_1] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewAddress]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewAddress]
AS
SELECT c.FirstName, c.LastName, a.ContactId, a.Street, a.City, st.StateType AS StateName, a.ZipCode, d.AddressType AS AddressTypeDescription, a.AddressID
FROM   dbo.Address AS a INNER JOIN
             dbo.Contact AS c ON a.ContactId = c.ContactId INNER JOIN
             dbo.AddressTypeID AS d ON a.AddressTypeID = d.AddressTypeID INNER JOIN
             dbo.StateType AS st ON a.State = st.StateTypeID
GO
/****** Object:  Table [dbo].[PhoneType]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneType](
	[PhoneType] [nchar](10) NULL,
	[PhoneTypeID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PhoneType1] PRIMARY KEY CLUSTERED 
(
	[PhoneTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phone]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phone](
	[ContactId] [int] NOT NULL,
	[Phone#] [varchar](18) NOT NULL,
	[PhoneType] [int] NOT NULL,
	[PhoneID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[PhoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PhoneView]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PhoneView]
AS
SELECT c.FirstName, c.LastName, p.ContactId, '(' + LEFT(p.Phone#, 3) + ') ' + SUBSTRING(p.Phone#, 4, 3) + '-' + RIGHT(p.Phone#, 4) AS FormattedPhone, pt.PhoneType AS PhoneTypeDescription, p.PhoneID
FROM   dbo.Phone AS p INNER JOIN
             dbo.Contact AS c ON p.ContactId = c.ContactId INNER JOIN
             dbo.PhoneType AS pt ON p.PhoneType = pt.PhoneTypeID
GO
/****** Object:  Table [dbo].[EmailType]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailType](
	[EmailType] [nchar](10) NOT NULL,
	[EmailTypeID] [nchar](10) NOT NULL,
 CONSTRAINT [PK_EmailType_1] PRIMARY KEY CLUSTERED 
(
	[EmailTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[EmailTypeID] [nchar](10) NOT NULL,
	[ContactId] [int] NOT NULL,
	[Email] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Email_1] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EmailView]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmailView]
AS
SELECT c.FirstName, c.LastName, e.EmailID, e.Email, et.EmailType AS EmailTypeDescription, e.ContactId
FROM   dbo.Email AS e INNER JOIN
             dbo.Contact AS c ON e.ContactId = c.ContactId INNER JOIN
             dbo.EmailType AS et ON e.EmailTypeID = et.EmailTypeID
GO
/****** Object:  Table [dbo].[PreferredContactMethod]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreferredContactMethod](
	[PreferredContactType] [varchar](20) NULL,
	[PreferredContactID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PreferredContactMethod] PRIMARY KEY CLUSTERED 
(
	[PreferredContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PreferredContact]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreferredContact](
	[PreferredContactID] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[PreferredContact] [int] NULL,
 CONSTRAINT [PK_PreferredContact] PRIMARY KEY CLUSTERED 
(
	[PreferredContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreferredContactView]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreferredContactView]
AS
SELECT c.FirstName, c.LastName, pc.ContactId, pcm.PreferredContactType AS PreferredMethod
FROM   dbo.PreferredContact AS pc INNER JOIN
             dbo.Contact AS c ON pc.ContactId = c.ContactId INNER JOIN
             dbo.PreferredContactMethod AS pcm ON pc.PreferredContact = pcm.PreferredContactID
GO
/****** Object:  View [dbo].[AgeContactView]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AgeContactView]
AS
SELECT ContactId, FirstName, LastName, DoB, dbo.GetAge(DoB) AS Age
FROM   dbo.Contact
GO
/****** Object:  Table [dbo].[Job]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job](
	[Title] [varchar](50) NOT NULL,
	[Company] [varchar](100) NOT NULL,
	[Department] [varchar](100) NOT NULL,
	[Manager's Name] [varchar](70) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[URL] [varchar](120) NOT NULL,
	[JobID] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_Job_1] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[JobsView]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JobsView]
AS
SELECT c.FirstName, c.LastName, j.JobID, j.Title AS JobTitle, j.Company, j.Department, j.[Manager's Name] AS ManagerName, j.Address, j.URL, j.ContactId
FROM   dbo.Job AS j INNER JOIN
             dbo.Contact AS c ON j.ContactId = c.ContactId
GO
/****** Object:  Table [dbo].[Notes]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notes](
	[Note(s)] [varchar](300) NULL,
	[Title] [varchar](300) NULL,
	[More Details] [varchar](300) NULL,
	[NotesID] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_Notes_1] PRIMARY KEY CLUSTERED 
(
	[NotesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[notesview]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[notesview]
AS
SELECT c.FirstName, c.LastName, n.NotesID, n.Title AS NoteTitle, n.[Note(s)] AS NoteContent, n.[More Details] AS MoreDetails, n.ContactId
FROM   dbo.Notes AS n INNER JOIN
             dbo.Contact AS c ON n.ContactId = c.ContactId
GO
/****** Object:  Table [dbo].[GenderType]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenderType](
	[GenderTypeID] [int] IDENTITY(1,1) NOT NULL,
	[GenderType] [varchar](50) NULL,
 CONSTRAINT [PK_GenderType] PRIMARY KEY CLUSTERED 
(
	[GenderTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (12, N'20 Seminary Lane', N'Granite Springs', 32, N'10527', 1, 1)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (12, N'S Moger Avenue', N'Mount Kisco', 32, N'10549', 0, 2)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (13, N'17 circle lane', N'Carmel', 32, N'10512', 1, 3)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (13, N'8 ridge way', N'Somers', 32, N'10567', 0, 4)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (14, N'80 Wheeler Ave', N'Pleasantville', 32, N'10570', 1, 5)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (14, N'861 Bedford Rd', N'Pleasantville', 32, N'10570', 0, 6)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (15, N'1600 Pennsylvania Avenue NW', N'Washington', 51, N'20500', 1, 7)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (15, N'861 Bedford Rd', N'Pleasantville', 32, N'10570', 0, 8)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (16, N'12055 Summit Cir', N'Beverly Hills', 5, N'90210', 1, 9)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (16, N'1440 Broadway Fl', N'New York', 32, N'10018-2305', 0, 10)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (17, N'82 Kingston Drive', N'New York', 32, N'10629', 1, 11)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (17, N'56 Lincoln Ave', N'New York', 32, N'14032', 0, 12)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (18, N'123 Main Street', N'Congers', 32, N'10920', 1, 13)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (18, N'861 Bedford Rd', N'Pleasantville', 32, N'10570', 0, 14)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (19, N'123 Main Street', N'New York', 32, N'10018', 1, 15)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (19, N'456 elm st', N'New York', 32, N'10018', 0, 16)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (20, N'414 Oak Ln', N'Palmyra', 38, N'17078', 1, 17)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (20, N'34 Edgemoor Dr', N'Burlington', 45, N'05408', 0, 18)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (21, N'115 DeHaven Dr #308', N'Yonkers', 32, N'10703', 1, 19)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (21, N'15 Volvo Drive', N'Rockleigh', 30, N'10703', 0, 20)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (22, N'121 Berger Ave', N'Blauvelt', 32, N'10913', 1, 21)
INSERT [dbo].[Address] ([ContactId], [Street], [City], [State], [ZipCode], [AddressTypeID], [AddressID]) VALUES (22, N'861 Bedford Rd ', N'Pleasantville', 32, N'10570', 0, 22)
SET IDENTITY_INSERT [dbo].[Address] OFF
GO
SET IDENTITY_INSERT [dbo].[AddressTypeID] ON 

INSERT [dbo].[AddressTypeID] ([AddressType], [AddressTypeID]) VALUES (N'work      ', 0)
INSERT [dbo].[AddressTypeID] ([AddressType], [AddressTypeID]) VALUES (N'home', 1)
INSERT [dbo].[AddressTypeID] ([AddressType], [AddressTypeID]) VALUES (N'business', 2)
SET IDENTITY_INSERT [dbo].[AddressTypeID] OFF
GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (12, N'', N'Michael', N'', N'Rourke', N'', CAST(N'2003-06-16' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (13, N'', N'Ashley', N'r', N'Peleg', N'', CAST(N'1997-08-21' AS Date), 2, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (14, N'', N'Anthony', N'', N'Gjivovich', N'', CAST(N'2004-03-30' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (15, N'', N'Daniel', N'', N'Ramos', N'', CAST(N'2004-07-23' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (16, N'', N'Sean', N'', N'Combs', N'', CAST(N'1969-11-04' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (17, N'', N'Andres', N'', N'Rodriguez', N'', CAST(N'1999-04-20' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (18, N'', N'Aaron', N'', N'Amalraj', N'', CAST(N'2003-02-11' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (19, N'', N'Gerry', N'', N'Basso', N'', CAST(N'2004-10-16' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (20, N'', N'Rejos', N'', N'Neopaney', N'', CAST(N'2003-07-10' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (21, N'', N'Marwan', N'', N'Shouery', N'', CAST(N'1970-03-01' AS Date), 1, N'')
INSERT [dbo].[Contact] ([ContactId], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [DoB], [Gender], [Alias]) VALUES (22, N'', N'Darius', N'', N'Bingleton', N'', CAST(N'2004-10-16' AS Date), 1, N'')
SET IDENTITY_INSERT [dbo].[Contact] OFF
GO
SET IDENTITY_INSERT [dbo].[Email] ON 

INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (35, N'0         ', 21, N'mshouery@pace.edu                                                                                   ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (36, N'1         ', 21, N'marwan.shouery@hotmail.com                                                                          ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (37, N'0         ', 12, N'mr18038p@pace.edu                                                                                   ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (38, N'0         ', 13, N'ap84388p@pace.edu                                                                                   ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (39, N'1         ', 13, N'ashleypeleg333@gmail.com                                                                            ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (40, N'0         ', 14, N'ag17839p@pace.edu                                                                                   ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (41, N'1         ', 14, N'agjivovich@pace.edu                                                                                 ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (42, N'0         ', 15, N'dramos@pace.edu                                                                                     ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (43, N'1         ', 15, N'dr39550p@pace.edu                                                                                   ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (44, N'0         ', 17, N'arodatwork@gmail.com                                                                                ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (45, N'1         ', 17, N'arod1403@gmail.com                                                                                  ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (46, N'0         ', 19, N'theguy@hotmail.com                                                                                  ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (47, N'1         ', 19, N'gmb@gmail.com                                                                                       ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (48, N'0         ', 20, N'rn72386p@pace.edu                                                                                   ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (49, N'1         ', 20, N'rejos2003@gmail.com                                                                                 ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (50, N'0         ', 21, N'jk87807p@pace.edu                                                                                   ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (51, N'1         ', 21, N'jkapiti7@gmail.com                                                                                  ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (52, N'0         ', 18, N'aaron.p.amalraj@pace.edu                                                                            ')
INSERT [dbo].[Email] ([EmailID], [EmailTypeID], [ContactId], [Email]) VALUES (53, N'1         ', 18, N'aaronamalraj3@gmail.com                                                                             ')
SET IDENTITY_INSERT [dbo].[Email] OFF
GO
INSERT [dbo].[EmailType] ([EmailType], [EmailTypeID]) VALUES (N'work      ', N'0         ')
INSERT [dbo].[EmailType] ([EmailType], [EmailTypeID]) VALUES (N'personal  ', N'1         ')
INSERT [dbo].[EmailType] ([EmailType], [EmailTypeID]) VALUES (N'preferred ', N'2         ')
GO
SET IDENTITY_INSERT [dbo].[GenderType] ON 

INSERT [dbo].[GenderType] ([GenderTypeID], [GenderType]) VALUES (1, N'Male')
INSERT [dbo].[GenderType] ([GenderTypeID], [GenderType]) VALUES (2, N'Female')
INSERT [dbo].[GenderType] ([GenderTypeID], [GenderType]) VALUES (3, N'N/A')
SET IDENTITY_INSERT [dbo].[GenderType] OFF
GO
SET IDENTITY_INSERT [dbo].[Phone] ON 

INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (12, N'9142487541', 6, 3)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (12, N'9143641863', 0, 4)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (13, N'9133425674', 6, 5)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (13, N'9142341543', 0, 6)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (13, N'9142344567', 1, 7)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (14, N'9142418214', 6, 8)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (14, N'9147733379', 0, 9)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (14, N'6310400474', 1, 10)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (15, N'9147733379', 0, 11)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (15, N'2037961037', 3, 12)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (16, N'4204206969', 0, 13)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (16, N'9177461444', 3, 14)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (17, N'9148232942', 0, 15)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (17, N'8452046560', 6, 16)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (18, N'9143544083', 1, 17)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (18, N'1234567890', 6, 18)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (19, N'8900831345', 0, 19)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (19, N'5671239876', 6, 20)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (20, N'7712697275', 0, 21)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (20, N'8023634491', 1, 22)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (21, N'2017507004 ', 0, 23)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (21, N'9143764942', 6, 24)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (21, N'9149879680', 1, 25)
INSERT [dbo].[Phone] ([ContactId], [Phone#], [PhoneType], [PhoneID]) VALUES (22, N'9172424192', 1, 26)
SET IDENTITY_INSERT [dbo].[Phone] OFF
GO
SET IDENTITY_INSERT [dbo].[PhoneType] ON 

INSERT [dbo].[PhoneType] ([PhoneType], [PhoneTypeID]) VALUES (N'work      ', 0)
INSERT [dbo].[PhoneType] ([PhoneType], [PhoneTypeID]) VALUES (N'cell      ', 1)
INSERT [dbo].[PhoneType] ([PhoneType], [PhoneTypeID]) VALUES (N'office    ', 2)
INSERT [dbo].[PhoneType] ([PhoneType], [PhoneTypeID]) VALUES (N'personal  ', 3)
INSERT [dbo].[PhoneType] ([PhoneType], [PhoneTypeID]) VALUES (N'family    ', 5)
INSERT [dbo].[PhoneType] ([PhoneType], [PhoneTypeID]) VALUES (N'home      ', 6)
SET IDENTITY_INSERT [dbo].[PhoneType] OFF
GO
SET IDENTITY_INSERT [dbo].[PreferredContact] ON 

INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (1, 12, 1)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (2, 13, 0)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (3, 14, 2)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (4, 15, 1)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (5, 16, 2)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (6, 17, 0)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (7, 18, 1)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (8, 19, 0)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (9, 20, 2)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (10, 21, 1)
INSERT [dbo].[PreferredContact] ([PreferredContactID], [ContactId], [PreferredContact]) VALUES (11, 22, 0)
SET IDENTITY_INSERT [dbo].[PreferredContact] OFF
GO
SET IDENTITY_INSERT [dbo].[PreferredContactMethod] ON 

INSERT [dbo].[PreferredContactMethod] ([PreferredContactType], [PreferredContactID]) VALUES (N'Email     ', 0)
INSERT [dbo].[PreferredContactMethod] ([PreferredContactType], [PreferredContactID]) VALUES (N'Call      ', 1)
INSERT [dbo].[PreferredContactMethod] ([PreferredContactType], [PreferredContactID]) VALUES (N'Text      ', 2)
SET IDENTITY_INSERT [dbo].[PreferredContactMethod] OFF
GO
SET IDENTITY_INSERT [dbo].[StateType] ON 

INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (1, N'AL')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (2, N'AK')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (3, N'AZ')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (4, N'AR')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (5, N'CA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (6, N'CO')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (7, N'CT')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (8, N'DE')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (9, N'FL')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (10, N'GA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (11, N'HI')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (12, N'ID')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (13, N'IL')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (14, N'IN')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (15, N'IA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (16, N'KS')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (17, N'KY')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (18, N'LA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (19, N'ME')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (20, N'MD')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (21, N'MA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (22, N'MI')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (23, N'MN')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (24, N'MS')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (25, N'MO')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (26, N'MT')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (27, N'NE')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (28, N'NV')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (29, N'NH')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (30, N'NJ')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (31, N'NM')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (32, N'NY')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (33, N'NC')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (34, N'ND')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (35, N'OH')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (36, N'OK')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (37, N'OR')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (38, N'PA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (39, N'RI')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (40, N'SC')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (41, N'SD')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (42, N'TN')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (43, N'TX')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (44, N'UT')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (45, N'VT')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (46, N'VA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (47, N'WA')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (48, N'WV')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (49, N'WI')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (50, N'WY')
INSERT [dbo].[StateType] ([StateTypeID], [StateType]) VALUES (51, N'DC')
SET IDENTITY_INSERT [dbo].[StateType] OFF
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_Street]  DEFAULT ('') FOR [Street]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_City]  DEFAULT ('') FOR [City]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_State]  DEFAULT ('') FOR [State]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_ZipCode]  DEFAULT ('') FOR [ZipCode]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_AddressTypeID]  DEFAULT ('') FOR [AddressTypeID]
GO
ALTER TABLE [dbo].[Contact] ADD  CONSTRAINT [DF_Contact_Title]  DEFAULT ('') FOR [Title]
GO
ALTER TABLE [dbo].[Contact] ADD  CONSTRAINT [DF_Contact_MiddleName]  DEFAULT ('') FOR [MiddleName]
GO
ALTER TABLE [dbo].[Contact] ADD  CONSTRAINT [DF_Contact_Suffix]  DEFAULT ('') FOR [Suffix]
GO
ALTER TABLE [dbo].[Contact] ADD  CONSTRAINT [DF_Contact_Alias]  DEFAULT ('') FOR [Alias]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_Title]  DEFAULT ('') FOR [Title]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_Company]  DEFAULT ('') FOR [Company]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_Department]  DEFAULT ('') FOR [Department]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_Manager's Name]  DEFAULT ('') FOR [Manager's Name]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_Address]  DEFAULT ('') FOR [Address]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_URL]  DEFAULT ('') FOR [URL]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_AddressTypeID] FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[AddressTypeID] ([AddressTypeID])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_AddressTypeID]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Contact]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_StateType] FOREIGN KEY([State])
REFERENCES [dbo].[StateType] ([StateTypeID])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_StateType]
GO
ALTER TABLE [dbo].[AddressTypeID]  WITH CHECK ADD  CONSTRAINT [FK_AddressTypeID_AddressTypeID] FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[AddressTypeID] ([AddressTypeID])
GO
ALTER TABLE [dbo].[AddressTypeID] CHECK CONSTRAINT [FK_AddressTypeID_AddressTypeID]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_Contact]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_GenderType] FOREIGN KEY([Gender])
REFERENCES [dbo].[GenderType] ([GenderTypeID])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_GenderType]
GO
ALTER TABLE [dbo].[Email]  WITH CHECK ADD  CONSTRAINT [FK_Email_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Email] CHECK CONSTRAINT [FK_Email_Contact]
GO
ALTER TABLE [dbo].[Email]  WITH CHECK ADD  CONSTRAINT [FK_Email_EmailType] FOREIGN KEY([EmailTypeID])
REFERENCES [dbo].[EmailType] ([EmailTypeID])
GO
ALTER TABLE [dbo].[Email] CHECK CONSTRAINT [FK_Email_EmailType]
GO
ALTER TABLE [dbo].[EmailType]  WITH CHECK ADD  CONSTRAINT [FK_EmailType_EmailType] FOREIGN KEY([EmailTypeID])
REFERENCES [dbo].[EmailType] ([EmailTypeID])
GO
ALTER TABLE [dbo].[EmailType] CHECK CONSTRAINT [FK_EmailType_EmailType]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Contact]
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_Notes_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_Notes_Contact]
GO
ALTER TABLE [dbo].[Personal]  WITH CHECK ADD  CONSTRAINT [FK_Personal_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Personal] CHECK CONSTRAINT [FK_Personal_Contact]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Contact]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_PhoneType] FOREIGN KEY([PhoneType])
REFERENCES [dbo].[PhoneType] ([PhoneTypeID])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_PhoneType]
GO
ALTER TABLE [dbo].[PreferredContact]  WITH CHECK ADD  CONSTRAINT [FK_PreferredContact_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[PreferredContact] CHECK CONSTRAINT [FK_PreferredContact_Contact]
GO
ALTER TABLE [dbo].[PreferredContact]  WITH CHECK ADD  CONSTRAINT [FK_PreferredContact_PreferredContactMethod] FOREIGN KEY([PreferredContact])
REFERENCES [dbo].[PreferredContactMethod] ([PreferredContactID])
GO
ALTER TABLE [dbo].[PreferredContact] CHECK CONSTRAINT [FK_PreferredContact_PreferredContactMethod]
GO
ALTER TABLE [dbo].[StateType]  WITH CHECK ADD  CONSTRAINT [FK_StateType_StateType] FOREIGN KEY([StateTypeID])
REFERENCES [dbo].[StateType] ([StateTypeID])
GO
ALTER TABLE [dbo].[StateType] CHECK CONSTRAINT [FK_StateType_StateType]
GO
/****** Object:  StoredProcedure [dbo].[AddAddress]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:     Aaron Amalraj
-- Create date: 4/22/2025
-- Description: Adds an address linked to a contact, with auto-incrementing AddressID
-- =============================================
CREATE PROCEDURE [dbo].[AddAddress] 
    @ContactId INT,
    @Street VARCHAR(100),
    @City VARCHAR(100),
    @State VARCHAR(50),
    @ZipCode VARCHAR(20),
    @AddressTypeID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the ContactId exists
    IF EXISTS (SELECT 1 FROM Contact WHERE ContactId = @ContactId)
    BEGIN
        -- If so, Insert new address (AddressID is auto-generated)
        INSERT INTO Address (ContactId, Street, City, State, ZipCode, AddressTypeID)
        VALUES (@ContactId, @Street, @City, @State, @ZipCode, @AddressTypeID);

        -- Return the newly inserted row using the generated AddressID
        SELECT * FROM Address WHERE AddressID = SCOPE_IDENTITY();
		-- SCOPE_IDENTITY() gets the most recent identity value 
		--(i.e., the new AddressID) that was auto-generated in this session and scope.
    END
    ELSE
    BEGIN
        SELECT 'Error: ContactID ' + CAST(@ContactId AS VARCHAR) + ' does not exist.' AS Error;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[AddContact]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:      Aaron Amalraj
-- Create date: 2025-04-23
-- Procedure:   AddContact
-- Purpose:
--   Inserts a new contact record into the dbo.Contact table.
--   Required fields must be provided.
--   Optional fields are only inserted if non-empty.
--   Empty or whitespace-only values for optional fields are rejected.
--   If optional fields are omitted entirely, the table-level DEFAULT ('') applies.
--   Returns the new ContactId using the OUTPUT parameter.
-- ================================================

CREATE PROCEDURE [dbo].[AddContact]
     @Title        VARCHAR(50) = NULL,        -- Optional: only inserted if not blank
    @FirstName    VARCHAR(255),              -- Required
    @MiddleName   VARCHAR(255) = NULL,       -- Optional
    @LastName     VARCHAR(255),              -- Required
    @Suffix       VARCHAR(50) = NULL,        -- Optional
    @DoB          DATE,                      -- Required
    @Gender       INT,                       -- Required (foreign key to GenderType)
    @Alias        VARCHAR(255) = NULL,       -- Optional
    @NewContactId INT OUTPUT                 -- Returns new identity value
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Step 1: Trim all inputs upfront (removes leading/trailing spaces)
    --        and prepare safe variables for later use
    ------------------------------------------------------------
    DECLARE 
        @TrimmedFirstName   VARCHAR(255) = LTRIM(RTRIM(@FirstName)),
        @TrimmedLastName    VARCHAR(255) = LTRIM(RTRIM(@LastName)),
        @TrimmedTitle       VARCHAR(50)  = LTRIM(RTRIM(ISNULL(@Title, ''))),
        @TrimmedMiddleName  VARCHAR(255) = LTRIM(RTRIM(ISNULL(@MiddleName, ''))),
        @TrimmedSuffix      VARCHAR(50)  = LTRIM(RTRIM(ISNULL(@Suffix, ''))),
        @TrimmedAlias       VARCHAR(255) = LTRIM(RTRIM(ISNULL(@Alias, '')));

    ------------------------------------------------------------
    -- Step 2: Validate that required fields are provided
    ------------------------------------------------------------
    IF @TrimmedFirstName = '' OR @TrimmedLastName = '' OR @DoB IS NULL OR @Gender IS NULL
    BEGIN
        PRINT 'Error: FirstName, LastName, DoB, and Gender are required.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 3: Reject optional fields if passed as empty or whitespace
    --         This prevents storing '' explicitly and enforces defaults
    ------------------------------------------------------------
    IF (@Title IS NOT NULL AND @TrimmedTitle = '')
        OR (@MiddleName IS NOT NULL AND @TrimmedMiddleName = '')
        OR (@Suffix IS NOT NULL AND @TrimmedSuffix = '')
        OR (@Alias IS NOT NULL AND @TrimmedAlias = '')
    BEGIN
        PRINT 'Error: Optional fields cannot be empty or whitespace.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 4: Validate that the Gender value exists in the reference table
    ------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1 FROM dbo.GenderType WHERE GenderTypeID = @Gender
    )
    BEGIN
        PRINT 'Error: Invalid GenderTypeID.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 5: Prevent duplicates based on FirstName, LastName, and DoB
    ------------------------------------------------------------
    IF EXISTS (
        SELECT 1 FROM dbo.Contact
        WHERE FirstName = @TrimmedFirstName
          AND LastName = @TrimmedLastName
          AND DoB = @DoB
    )
    BEGIN
        PRINT 'Error: Duplicate contact exists.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 6: Build dynamic INSERT statement
    --         Only include optional fields that are valid and provided
    ------------------------------------------------------------
    DECLARE 
        @SQL NVARCHAR(MAX),      -- Final SQL statement
        @Cols NVARCHAR(MAX) = 'FirstName, LastName, DoB, Gender',  -- Required columns
        @Vals NVARCHAR(MAX) = '@FirstName, @LastName, @DoB, @Gender'; -- Required values

    -- Conditionally add each optional field
    IF @Title IS NOT NULL AND @TrimmedTitle <> ''
    BEGIN
        SET @Cols += ', Title'
        SET @Vals += ', @Title'
    END

    IF @MiddleName IS NOT NULL AND @TrimmedMiddleName <> ''
    BEGIN
        SET @Cols += ', MiddleName'
        SET @Vals += ', @MiddleName'
    END

    IF @Suffix IS NOT NULL AND @TrimmedSuffix <> ''
    BEGIN
        SET @Cols += ', Suffix'
        SET @Vals += ', @Suffix'
    END

    IF @Alias IS NOT NULL AND @TrimmedAlias <> ''
    BEGIN
        SET @Cols += ', Alias'
        SET @Vals += ', @Alias'
    END

    -- Construct full SQL string using validated columns
    SET @SQL = '
        INSERT INTO dbo.Contact (' + @Cols + ')
        VALUES (' + @Vals + ');
        SET @NewContactId = SCOPE_IDENTITY();
    '

    ------------------------------------------------------------
    -- Step 7: Execute dynamic SQL with all trimmed parameters
    --         sp_executesql ensures type safety and performance
    ------------------------------------------------------------
    EXEC sp_executesql @SQL,
        N'@FirstName VARCHAR(255), @LastName VARCHAR(255), @DoB DATE, @Gender INT,
          @Title VARCHAR(50), @MiddleName VARCHAR(255), @Suffix VARCHAR(50), @Alias VARCHAR(255),
          @NewContactId INT OUTPUT',
        @FirstName = @TrimmedFirstName,
        @LastName = @TrimmedLastName,
        @DoB = @DoB,
        @Gender = @Gender,
        @Title = @TrimmedTitle,
        @MiddleName = @TrimmedMiddleName,
        @Suffix = @TrimmedSuffix,
        @Alias = @TrimmedAlias,
        @NewContactId = @NewContactId OUTPUT;

    PRINT 'Contact added successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[AddContactPreferredMethod]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Aaron Amalraj>
-- Create date: <4/24/2025>
-- Description:	<Description: AddContactPreferred Method to Preferred Contact Table>
-- =============================================
CREATE PROCEDURE [dbo].[AddContactPreferredMethod]
    @PreferredContactID INT,
	@ContactId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Validate ContactId exists
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Contact WHERE ContactId = @ContactId
    )
    BEGIN
        PRINT 'Error: Contact does not exist.';
        RETURN;
    END

    -- Step 2: Validate PreferredContactID exists in PreferredContactMethod Table
    IF NOT EXISTS (
        SELECT 1 FROM PreferredContactMethod WHERE PreferredContactID = @PreferredContactID
    )
    BEGIN
        PRINT 'Error: Invalid preferred contact type.';
        RETURN;
    END

    -- Step 3: Optional - Prevent duplicate preference
    IF EXISTS (
        SELECT 1 FROM PreferredContact WHERE ContactId = @ContactId
    )
    BEGIN
        PRINT 'Error: This contact already has a preferred contact method.';
        RETURN;
    END

    -- Step 4: Insert the preferred contact method
    INSERT INTO PreferredContact (PreferredContact, ContactId)
    VALUES (@PreferredContactID, @ContactId);
    PRINT 'Preferred contact method added successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[AddEmail]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:     Aaron Amalraj
-- Create date: 4/22/2025
-- Description: Adds a new email for a contact (EmailID is auto-incremented)
-- =============================================
CREATE PROCEDURE [dbo].[AddEmail] 
    @ContactId INT,            -- Foreign key to associate email with a contact
    @EmailTypeID NCHAR(10),    -- Type of email (e.g., work, personal, etc.)
    @Email NCHAR(100)          -- The actual email address
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the Contact exists
    IF EXISTS (SELECT 1 FROM Contact WHERE ContactId = @ContactId)
    BEGIN
        -- Insert the new email (EmailID is auto-generated)
        INSERT INTO Email (ContactId, EmailTypeID, Email)
        VALUES (@ContactId, @EmailTypeID, @Email);

        -- Return the newly inserted email row
        SELECT * FROM Email WHERE EmailID = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        -- If contact doesn't exist, return an error
        SELECT 'Error: ContactID ' + CAST(@ContactId AS VARCHAR) + ' does not exist.' AS Error;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[AddJob]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: AddJob: storied procedure, that adds a job utilizing these parameters>
-- =============================================
CREATE PROCEDURE [dbo].[AddJob]
    @Title VARCHAR(50),
    @Company VARCHAR(100),
    @Department VARCHAR(100),
    @ManagerName VARCHAR(70),
    @Address VARCHAR(100),
    @URL VARCHAR(120),
    @ContactId INT
AS
BEGIN
    INSERT INTO Job (Title, Company, Department, [Manager's Name], Address, URL, ContactId)
    VALUES (@Title, @Company, @Department, @ManagerName, @Address, @URL, @ContactId);
END
GO
/****** Object:  StoredProcedure [dbo].[AddMultipleContacts]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Adding multiple contacts procedure (this is where I added all of my contacts information)>
-- =============================================
-- Adding our contacts here
CREATE PROCEDURE [dbo].[AddMultipleContacts]
AS
BEGIN
    DECLARE @NewID INT;
EXEC AddContact
    @Title = NULL,
    @FirstName = 'Michael',
    @MiddleName = NULL,
    @LastName = 'Rourke',
    @Suffix = NULL,
    @DoB = '2003-06-16',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Ashley',
    @MiddleName = 'r',
    @LastName = 'Peleg',
    @Suffix = NULL,
    @DoB = '1997-08-21',
    @Gender = 2,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Anthony',
    @MiddleName = NULL,
    @LastName = 'Gjivovich',
    @Suffix = NULL,
    @DoB = '2004-03-30',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Daniel',
    @MiddleName = NULL,
    @LastName = 'Ramos',
    @Suffix = NULL,
    @DoB = '2004-07-23',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Sean',
    @MiddleName = NULL,
    @LastName = 'Combs',
    @Suffix = NULL,
    @DoB = '1969-11-04',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Andres',
    @MiddleName = NULL,
    @LastName = 'Rodriguez',
    @Suffix = NULL,
    @DoB = '1999-04-20',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Aaron',
    @MiddleName = NULL,
    @LastName = 'Amalraj',
    @Suffix = NULL,
    @DoB = '2003-02-11',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Gerry',
    @MiddleName = NULL,
    @LastName = 'Basso',
    @Suffix = NULL,
    @DoB = '2004-10-16',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Rejos',
    @MiddleName = NULL,
    @LastName = 'Neopaney',
    @Suffix = NULL,
    @DoB = '2003-07-10',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Marwan',
    @MiddleName = NULL,
    @LastName = 'Shouery',
    @Suffix = NULL,
    @DoB = '1970-03-01',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

EXEC AddContact
    @Title = NULL,
    @FirstName = 'Darius',
    @MiddleName = NULL,
    @LastName = 'Bingleton',
    @Suffix = NULL,
    @DoB = '2004-10-16',
    @Gender = 1,
    @Alias = NULL,
    @NewContactId = @NewID OUTPUT;

END;
GO
/****** Object:  StoredProcedure [dbo].[AddNote]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025,,>
-- Description:	<Description: adding a note storied procedure>
-- =============================================
CREATE PROCEDURE [dbo].[AddNote]
    @ContactId INT,
    @Title VARCHAR(300),
    @NoteText VARCHAR(300),
    @MoreDetails VARCHAR(300)
AS
BEGIN
    INSERT INTO Notes ([Note(s)], Title, [More Details], ContactId)
    VALUES (@NoteText, @Title, @MoreDetails, @ContactId);
END
GO
/****** Object:  StoredProcedure [dbo].[AddPersonal]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description>
-- =============================================
CREATE PROCEDURE [dbo].[AddPersonal]
    @ContactId INT,
    @PersonalID INT,
    @SpouseName VARCHAR(50),
    @AnniversaryDate DATE
AS
BEGIN
    INSERT INTO Personal
        ([Spouse's name], [Anniversary Date], PersonalID, ContactId)
    VALUES
        (@SpouseName, @AnniversaryDate, @PersonalID, @ContactId);
END;
GO
/****** Object:  StoredProcedure [dbo].[AddPhoneNumber]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Aaron Amalraj>
-- Create date: <4/24/2025,,>
-- Description:	<Description,Adding a phone number checking if a valid phone numberID is inputted,>
-- =============================================
CREATE PROCEDURE [dbo].[AddPhoneNumber]
    @ContactId INT,
    @PhoneNumber VARCHAR(18),
    @PhoneTypeID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Optional: validate the PhoneTypeID exists
    IF NOT EXISTS (
        SELECT 1 FROM PhoneType WHERE PhoneTypeID = @PhoneTypeID
    )
    BEGIN
        RAISERROR('Invalid PhoneTypeID. Entry not inserted.', 16, 1);
        RETURN;
    END

    -- Insert the new phone record
    INSERT INTO Phone (ContactID, Phone#, PhoneType)
    VALUES (@ContactId, @PhoneNumber, @PhoneTypeID);
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteAddress]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Aaron Amalraj>
-- Create date: <Create Date 4/24/2025,,>
-- Description:	<storied procedure for delete address>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAddress]
    @AddressID INT
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Step 1: Check if the address exists
    ------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1 FROM Address WHERE AddressID = @AddressID
    )
    BEGIN
        PRINT 'Error: AddressID does not exist.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 2: Delete the address
    ------------------------------------------------------------
    DELETE FROM Address WHERE AddressID = @AddressID;

    PRINT 'Address deleted successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteContact]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<storied procedure for delete contact>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteContact]
    @ContactId INT
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Step 1: Check if Contact exists
    ------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Contact WHERE ContactId = @ContactId
    )
    BEGIN
        PRINT 'Error: ContactId does not exist.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 2: Delete dependent records
    ------------------------------------------------------------
    DELETE FROM Phone WHERE ContactId = @ContactId;
    DELETE FROM Email WHERE ContactId = @ContactId;
    DELETE FROM Address WHERE ContactId = @ContactId;
    DELETE FROM PreferredContact WHERE ContactId = @ContactId;
    DELETE FROM Address WHERE ContactId = @ContactId;
	DELETE From Personal WHERE ContactId = @ContactId
	DELETE FROM Job WHERE ContactId = @ContactId
	DELETE FROM Notes WHERE ContactId = @ContactId
    ------------------------------------------------------------
    -- Step 3: Delete the contact
    ------------------------------------------------------------
    DELETE FROM dbo.Contact WHERE ContactId = @ContactId;

    PRINT 'Contact and related records deleted successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmail]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: storied procedure for delete email>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteEmail]
    @EmailID INT
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Step 1: Check if the email exists
    ------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1 FROM Email WHERE EmailID = @EmailID
    )
    BEGIN
        PRINT 'Error: EmailID does not exist.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 2: Delete the email
    ------------------------------------------------------------
    DELETE FROM Email WHERE EmailID = @EmailID;

    PRINT 'Email deleted successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteJob]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: *to delete a job in the storied procedure>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteJob]
    @JobID INT
AS
BEGIN
    DELETE FROM Job
    WHERE JobID = @JobID;
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteNote]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: A procedure that deletes a note by noteID>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteNote]
    @NotesID INT
AS
BEGIN
    DELETE FROM Notes
    WHERE NotesID = @NotesID;
END
GO
/****** Object:  StoredProcedure [dbo].[DeletePersonal]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeletePersonal]
    @ContactId INT
AS
BEGIN
    DELETE FROM Personal
    WHERE ContactId = @ContactId;
END;

GO
/****** Object:  StoredProcedure [dbo].[DeletePhoneNumber]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: Procedure for delete phone number>
-- =============================================
CREATE PROCEDURE [dbo].[DeletePhoneNumber]
    @PhoneID INT
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Step 1: Check if the phone record exists
    ------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1 FROM Phone WHERE PhoneID = @PhoneID
    )
    BEGIN
        PRINT 'Error: PhoneID does not exist.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 2: Delete the phone number
    ------------------------------------------------------------
    DELETE FROM Phone WHERE PhoneID = @PhoneID;

    PRINT 'Phone number deleted successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[DeletePreferredContact]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <Create Date: 5/6/2025>
-- Description:	<Description: Delete Preferred Contact storied procedure>
-- =============================================
CREATE PROCEDURE [dbo].[DeletePreferredContact]
    @ContactId INT
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Step 1: Check if the contact has a preferred method
    ------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1 FROM PreferredContact WHERE ContactId = @ContactId
    )
    BEGIN
        PRINT 'Error: No preferred contact method found for this ContactId.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 2: Delete the preferred method
    ------------------------------------------------------------
    DELETE FROM PreferredContact WHERE ContactId = @ContactId;

    PRINT 'Preferred contact method deleted successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[EditAddress]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:     Aaron Amalraj
-- Create date: 4/22/2025
-- Description: Updates an address for a given ContactId and AddressID
-- =============================================
CREATE PROCEDURE [dbo].[EditAddress] 
    @ContactId INT,         -- ID of the contact to whom the address belongs
    @Street VARCHAR(100),      -- Updated street address (fixed-length char)
    @City VARCHAR(100),        -- Updated city (fixed-length char)
    @State VARCHAR(50),       -- Updated state (fixed-length char)
    @ZipCode VARCHAR(10),     -- Updated ZIP code (fixed-length char)
    @AddressID INT,         -- Unique identifier for the address to be updated
    @AddressTypeID INT      -- Updated type of address (e.g., home, work)
AS 
BEGIN
    -- Prevents extra result sets from interfering with SELECTs
    SET NOCOUNT ON;

    -- Check if the contact exists in the Contact table
    IF EXISTS (SELECT 1 FROM Contact WHERE ContactId = @ContactId)
    BEGIN
        -- Check if the specific address exists for the given ContactId and AddressID
        IF EXISTS (SELECT 1 FROM Address WHERE ContactId = @ContactId AND AddressID = @AddressID)
        BEGIN
            -- Perform the update of the Address record
            UPDATE Address
            SET 
                Street = @Street,
                City = @City,
                State = @State,
                ZipCode = @ZipCode,
                AddressTypeID = @AddressTypeID
            WHERE 
                ContactId = @ContactId AND AddressID = @AddressID;

            -- Return the updated address row as confirmation
            SELECT * FROM Address WHERE ContactId = @ContactId AND AddressID = @AddressID;
        END
        ELSE
        BEGIN
            -- If no matching address is found for the contact, return an error message
            SELECT 
                'Error: AddressID ' + CAST(@AddressID AS VARCHAR) + 
                ' does not exist for ContactID ' + CAST(@ContactId AS VARCHAR) AS Error;
        END
    END
    ELSE
    BEGIN
        -- If no matching contact is found, return an error message
        SELECT 
            'Error: ContactID ' + CAST(@ContactId AS VARCHAR) + 
            ' does not exist.' AS Error;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[EditContact]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: Editing Contact-storied procedure>
-- =============================================
CREATE PROCEDURE [dbo].[EditContact]
    @ContactId INT,                             -- Required: primary key to locate the contact
    @Title VARCHAR(50) = NULL,                  -- Optional
    @FirstName VARCHAR(255) = NULL,             -- Optional
    @MiddleName VARCHAR(255) = NULL,            -- Optional
    @LastName VARCHAR(255) = NULL,              -- Optional
    @Suffix VARCHAR(50) = NULL,                 -- Optional
    @DoB DATE = NULL,                           -- Optional
    @Gender INT = NULL,                         -- Optional
    @Alias VARCHAR(255) = NULL                  -- Optional
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Step 1: Ensure the Contact exists
    ------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Contact WHERE ContactId = @ContactId
    )
    BEGIN
        PRINT 'Error: ContactId does not exist.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 2: Validate that Gender exists (if provided)
    ------------------------------------------------------------
    IF @Gender IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM dbo.GenderType WHERE GenderTypeID = @Gender
    )
    BEGIN
        PRINT 'Error: Invalid GenderTypeID.';
        RETURN;
    END

    ------------------------------------------------------------
    -- Step 3: Build dynamic UPDATE statement
    ------------------------------------------------------------
    DECLARE @SQL NVARCHAR(MAX) = 'UPDATE dbo.Contact SET ';
    DECLARE @SetClause NVARCHAR(MAX) = '';
    DECLARE @ParamDefs NVARCHAR(MAX) = '';
    
    -- Use COALESCE pattern only if a parameter is not NULL or not empty
    IF @FirstName IS NOT NULL
    BEGIN
        SET @SetClause += 'FirstName = @FirstName, ';
        SET @ParamDefs += '@FirstName VARCHAR(255), ';
    END

    IF @LastName IS NOT NULL
    BEGIN
        SET @SetClause += 'LastName = @LastName, ';
        SET @ParamDefs += '@LastName VARCHAR(255), ';
    END

    IF @DoB IS NOT NULL
    BEGIN
        SET @SetClause += 'DoB = @DoB, ';
        SET @ParamDefs += '@DoB DATE, ';
    END

    IF @Gender IS NOT NULL
    BEGIN
        SET @SetClause += 'Gender = @Gender, ';
        SET @ParamDefs += '@Gender INT, ';
    END

    IF @Title IS NOT NULL
    BEGIN
        SET @SetClause += 'Title = @Title, ';
        SET @ParamDefs += '@Title VARCHAR(50), ';
    END

    IF @MiddleName IS NOT NULL
    BEGIN
        SET @SetClause += 'MiddleName = @MiddleName, ';
        SET @ParamDefs += '@MiddleName VARCHAR(255), ';
    END

    IF @Suffix IS NOT NULL
    BEGIN
        SET @SetClause += 'Suffix = @Suffix, ';
        SET @ParamDefs += '@Suffix VARCHAR(50), ';
    END

    IF @Alias IS NOT NULL
    BEGIN
        SET @SetClause += 'Alias = @Alias, ';
        SET @ParamDefs += '@Alias VARCHAR(255), ';
    END

    -- Remove last comma and space from @SetClause
    SET @SetClause = LEFT(@SetClause, LEN(@SetClause) - 2);

    -- Finalize SQL with WHERE clause
    SET @SQL += @SetClause + ' WHERE ContactId = @ContactId';
    SET @ParamDefs += '@ContactId INT';

    ------------------------------------------------------------
    -- Step 4: Execute dynamic SQL
    ------------------------------------------------------------
    EXEC sp_executesql @SQL,
        @ParamDefs,
        @ContactId = @ContactId,
        @Title = @Title,
        @FirstName = @FirstName,
        @MiddleName = @MiddleName,
        @LastName = @LastName,
        @Suffix = @Suffix,
        @DoB = @DoB,
        @Gender = @Gender,
        @Alias = @Alias;

    PRINT 'Contact updated successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[EditContactPreferredMethod]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <4/24/2025>
-- Description:	<Description: >
-- =============================================
CREATE PROCEDURE [dbo].[EditContactPreferredMethod]
    @ContactId INT,
    @NewPreferredContactID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Ensure the contact exists
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Contact WHERE ContactId = @ContactId
    )
    BEGIN
        PRINT 'Error: Contact does not exist.';
        RETURN;
    END

    -- Step 2: Ensure the new preferred method exists
    IF NOT EXISTS (
        SELECT 1 FROM PreferredContactMethod WHERE PreferredContactID = @NewPreferredContactID
    )
    BEGIN
        PRINT 'Error: Invalid PreferredContactID.';
        RETURN;
    END

    -- Step 3: Ensure the contact already has a preferred method to update
    IF NOT EXISTS (
        SELECT 1 FROM PreferredContact WHERE ContactId = @ContactId
    )
    BEGIN
        PRINT 'Error: This contact does not yet have a preferred contact method.';
        RETURN;
    END

    -- Step 4: Perform the update
    UPDATE PreferredContact
    SET PreferredContact = @NewPreferredContactID
    WHERE ContactId = @ContactId;

    PRINT 'Preferred contact method updated successfully.';
END;
GO
/****** Object:  StoredProcedure [dbo].[EditEmail]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:     Aaron Amalraj
-- Create date: 4/22/2025
-- Description: Updates an existing email address for a given EmailID
-- =============================================
CREATE PROCEDURE [dbo].[EditEmail]
    @EmailID INT,             -- ID of the email to be updated
    @EmailTypeID INT,         -- New email type (e.g., work, personal)
    @Email NVARCHAR(100)      -- New email address
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the EmailID exists
    IF EXISTS (SELECT 1 FROM Email WHERE EmailID = @EmailID)
    BEGIN
        -- Perform the update
        UPDATE Email
        SET 
            EmailTypeID = @EmailTypeID,
            Email = @Email
        WHERE 
            EmailID = @EmailID;

        -- Return the updated row
        SELECT * FROM Email WHERE EmailID = @EmailID;
    END
    ELSE
    BEGIN
        -- Return an error message if EmailID is not found
        SELECT 'Error: EmailID ' + CAST(@EmailID AS VARCHAR) + ' does not exist.' AS Error;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[EditJob_Optional]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: a storied procedure to edit a job, and change fields optionally by utilizing the COALESCE function
-- =============================================
CREATE PROCEDURE [dbo].[EditJob_Optional]
    @JobID INT,
    @Title VARCHAR(50) = NULL,
    @Company VARCHAR(100) = NULL,
    @Department VARCHAR(100) = NULL,
    @ManagerName VARCHAR(70) = NULL,
    @Address VARCHAR(100) = NULL,
    @URL VARCHAR(120) = NULL,
    @ContactId INT = NULL
AS
BEGIN
    UPDATE Job
    SET 
        Title = COALESCE(@Title, Title),
        Company = COALESCE(@Company, Company),
        Department = COALESCE(@Department, Department),
        [Manager's Name] = COALESCE(@ManagerName, [Manager's Name]),
        Address = COALESCE(@Address, Address),
        URL = COALESCE(@URL, URL),
        ContactId = COALESCE(@ContactId, ContactId)
    WHERE JobID = @JobID;
END
GO
/****** Object:  StoredProcedure [dbo].[EditNote_Optional]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: Edit Notes storied procedure, can edit certain fields, and put other fields as null>
-- =============================================
CREATE PROCEDURE [dbo].[EditNote_Optional]
    @NotesID INT,
    @Title VARCHAR(300) = NULL,
    @NoteText VARCHAR(300) = NULL,
    @MoreDetails VARCHAR(300) = NULL
AS
BEGIN
    UPDATE Notes
    SET 
		--COALESCE(x, y) → uses x if it's NOT NULL, otherwise keeps existing y.
		--So if you pass NULL for any input, it won’t change that column!
        Title = COALESCE(@Title, Title),
        [Note(s)] = COALESCE(@NoteText, [Note(s)]),
        [More Details] = COALESCE(@MoreDetails, [More Details])
    WHERE NotesID = @NotesID;
END
GO
/****** Object:  StoredProcedure [dbo].[EditPersonal]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: edit personal>
-- =============================================
CREATE PROCEDURE [dbo].[EditPersonal]
    @ContactId INT,
    @PersonalID INT,
    @SpouseName VARCHAR(50),
    @AnniversaryDate DATE
AS
BEGIN
    UPDATE Personal
    SET 
        [Spouse's name] = @SpouseName,
        [Anniversary Date] = @AnniversaryDate
    WHERE 
        ContactId = @ContactId;
END;
GO
/****** Object:  StoredProcedure [dbo].[EditPhoneNumber]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Aaron Amalraj>
-- Create date: <4/24/2025,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditPhoneNumber]
    @PhoneID INT,
    @NewPhoneNumber VARCHAR(18) = NULL,
    @NewPhoneTypeID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate the PhoneID exists
    IF NOT EXISTS (
        SELECT 1 FROM Phone WHERE PhoneID = @PhoneID
    )
    BEGIN
        RAISERROR('Invalid PhoneID. No phone record found.', 16, 1);
        RETURN;
    END

    -- Optional: Validate new PhoneTypeID if provided
    IF @NewPhoneTypeID IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM PhoneType WHERE PhoneTypeID = @NewPhoneTypeID
    )
    BEGIN
        RAISERROR('Invalid PhoneTypeID. Update aborted.', 16, 1);
        RETURN;
    END

    -- Update only the values provided (leave others unchanged)
    UPDATE Phone
    SET 
        [Phone#] = COALESCE(@NewPhoneNumber, [Phone#]),
        PhoneType = COALESCE(@NewPhoneTypeID, PhoneType)
    WHERE PhoneID = @PhoneID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetFullContactInfoFromViews]    Script Date: 5/6/2025 6:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Aaron Amalraj>
-- Create date: <5/6/2025>
-- Description:	<Description: View that provides full contact info>
-- =============================================
CREATE PROCEDURE [dbo].[GetFullContactInfoFromViews]
    @ContactId INT = NULL,               -- Optional: ContactId (preferred if known)
    @FirstName VARCHAR(255) = NULL,      -- Optional: FirstName (used if ContactId not provided)
    @LastName VARCHAR(255) = NULL        -- Optional: LastName (used if ContactId not provided)
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------------------
    -- STEP 1: Resolve ContactId if only FirstName + LastName are provided
    -- This allows flexibility to look up by name instead of ID
    ------------------------------------------------------------------------
    IF @ContactId IS NULL AND @FirstName IS NOT NULL AND @LastName IS NOT NULL
    BEGIN
        SELECT TOP 1 @ContactId = ContactId
        FROM dbo.Contact
        WHERE FirstName = @FirstName AND LastName = @LastName;
    END

    ------------------------------------------------------------------------
    -- STEP 2: Validate that a ContactId was found or provided
    -- If not, print an error and exit early
    ------------------------------------------------------------------------
    IF @ContactId IS NULL
    BEGIN
        PRINT 'Error: No valid ContactId found.';
        RETURN;
    END

    ------------------------------------------------------------------------
    -- STEP 3: Show basic Contact information
    -- This pulls directly from the Contact table
    ------------------------------------------------------------------------
	PRINT '--- Contact Info ---';
	SELECT 
		c.ContactId,
		c.FirstName,
		c.MiddleName,
		c.LastName,
		c.DoB,
		gt.GenderType AS Gender,
		c.Alias,
		c.Title,
		c.Suffix
	FROM dbo.Contact c
	INNER JOIN dbo.GenderType gt ON c.Gender = gt.GenderTypeID
	WHERE c.ContactId = @ContactId;


    ------------------------------------------------------------------------
    -- STEP 4: Show Email information
    -- This comes from your view: dbo.EmailView
    ------------------------------------------------------------------------
    PRINT '--- Email Info ---';
    SELECT * 
    FROM dbo.EmailView 
    WHERE ContactId = @ContactId;

    ------------------------------------------------------------------------
    -- STEP 5: Show Phone number information
    -- This comes from your view: dbo.PhoneView
    ------------------------------------------------------------------------
    PRINT '--- Phone Info ---';
    SELECT * 
    FROM dbo.PhoneView 
    WHERE ContactId = @ContactId;

    ------------------------------------------------------------------------
    -- STEP 6: Show Address information
    -- This comes from your view: dbo.ViewAddress
    ------------------------------------------------------------------------
    PRINT '--- Address Info ---';
    SELECT * 
    FROM dbo.ViewAddress 
    WHERE ContactId = @ContactId;

    ------------------------------------------------------------------------
    -- STEP 7: Show Preferred Contact Method
    -- This comes from your view: dbo.PreferredContactView
    ------------------------------------------------------------------------
    PRINT '--- Preferred Contact Method ---';
    SELECT * 
    FROM dbo.PreferredContactView 
    WHERE ContactId = @ContactId;

	 -- STEP 8: Show Age
    -- This comes from your view: dbo.AgeContactView
    ------------------------------------------------------------------------
    PRINT '--- Age Info ---';
    SELECT * 
    FROM dbo.AgeContactView
    WHERE ContactId = @ContactId;

	-- STEP 9: Show Job View
    -- This comes from your view: dbo.JobsView
    ------------------------------------------------------------------------
    PRINT '--- Job Info ---';
    SELECT * 
    FROM dbo.JobsView
    WHERE ContactId = @ContactId;
	
	-- STEP 10: Show notes view
    -- This comes from your view: dbo.notesview
    ------------------------------------------------------------------------
	PRINT '--- Notes Info ---';
    SELECT * 
    FROM dbo.notesview
    WHERE ContactId = @ContactId;

	-- STEP 11: Show personal view
    -- This comes from your view: dbo.PersonalView
	PRINT '--- Personal Info ---';
    SELECT * 
    FROM dbo.PersonalView
    WHERE ContactId = @ContactId;
    ------------------------------------------------------------------------
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Contact"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AgeContactView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AgeContactView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "e"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "et"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 152
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 9
               Left = 615
               Bottom = 206
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmailView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmailView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 206
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 295
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "n"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 206
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'notesview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'notesview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 295
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 9
               Left = 352
               Bottom = 206
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PersonalView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PersonalView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pt"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 152
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 9
               Left = 615
               Bottom = 206
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PhoneView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PhoneView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pc"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 179
               Right = 312
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 9
               Left = 369
               Bottom = 206
               Right = 591
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pcm"
            Begin Extent = 
               Top = 9
               Left = 648
               Bottom = 152
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PreferredContactView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PreferredContactView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 282
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 9
               Left = 339
               Bottom = 206
               Right = 561
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 9
               Left = 618
               Bottom = 152
               Right = 843
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "st"
            Begin Extent = 
               Top = 9
               Left = 900
               Bottom = 152
               Right = 1122
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1200
         Table = 1170
         Output = 1370
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAddress'
GO
USE [master]
GO
ALTER DATABASE [Aaron'sContacts] SET  READ_WRITE 
GO
