USE [master]
GO

/****** Object:  Database [Casino_Royale]    Script Date: 19/04/08 08:32:53 AM ******/

/* Create databases for casino data */



DROP DATABASE IF EXISTS [Casino_Royale]
GO

declare @Path varchar(100)
set @Path = 'C:\Casino_Royale\Data'
EXEC master.dbo.xp_create_subdir @Path

set @Path = 'C:\Casino_Royale\Backup'
EXEC master.dbo.xp_create_subdir @Path

set @Path = 'C:\Casino_Royale\Log'
EXEC master.dbo.xp_create_subdir @Path


CREATE DATABASE [Casino_Royale]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Casino_Royale', FILENAME = N'C:\Casino_Royale\Data\Casino_Royale.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [Fg_2019-04-04] 
( NAME = N'Data_File_2019-04-04', FILENAME = N'C:\Casino_Royale\Data\Data_File_2019-04-04.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [Fg_2019-04-05] 
( NAME = N'Data_File_2019-04-05', FILENAME = N'C:\Casino_Royale\Data\Data_File_2019-04-05.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Casino_Royale_log', FILENAME = N'C:\Casino_Royale\Data\Casino_Royale_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Casino_Royale] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Casino_Royale].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Casino_Royale] SET ANSI_NULL_DEFAULT ON 
GO

ALTER DATABASE [Casino_Royale] SET ANSI_NULLS ON 
GO

ALTER DATABASE [Casino_Royale] SET ANSI_PADDING ON 
GO

ALTER DATABASE [Casino_Royale] SET ANSI_WARNINGS ON 
GO

ALTER DATABASE [Casino_Royale] SET ARITHABORT ON 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Casino_Royale] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Casino_Royale] SET CURSOR_DEFAULT  LOCAL 
GO

ALTER DATABASE [Casino_Royale] SET CONCAT_NULL_YIELDS_NULL ON 
GO

ALTER DATABASE [Casino_Royale] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Casino_Royale] SET QUOTED_IDENTIFIER ON 
GO

ALTER DATABASE [Casino_Royale] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Casino_Royale] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Casino_Royale] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Casino_Royale] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Casino_Royale] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Casino_Royale] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Casino_Royale] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Casino_Royale] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Casino_Royale] SET RECOVERY FULL 
GO

ALTER DATABASE [Casino_Royale] SET  MULTI_USER 
GO

ALTER DATABASE [Casino_Royale] SET PAGE_VERIFY NONE  
GO

ALTER DATABASE [Casino_Royale] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Casino_Royale] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Casino_Royale] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [Casino_Royale] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Casino_Royale] SET QUERY_STORE = OFF
GO

ALTER DATABASE [Casino_Royale] SET  READ_WRITE 
GO


/***** End database creation *****/

--==============================================================================================================
--==============================================================================================================

/***** Change the database setting to allow sending mail from the database *****/

USE Casino_Royale
GO 

sp_CONFIGURE 'show advanced', 1
GO
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1
GO
RECONFIGURE
GO

--==============================================================================================================
--==============================================================================================================

/***** Create database tables *****/

USE [Casino_Royale]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[utbl_Countries] ******/

/*
Create table of Countries in the database
*/

DROP TABLE IF EXISTS [dbo].[utbl_Countries]
GO

CREATE TABLE [dbo].[utbl_Countries](
	[Country_ID]		[int]		   NOT NULL identity,
	[Country_Name]		[nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Country_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[utbl_Games] ******/

/*
Create a table for the casino's games list
*/

DROP TABLE IF EXISTS  [dbo].[utbl_Games]
GO

CREATE TABLE [dbo].[utbl_Games](
	[Game_ID]	[int]		   NOT NULL,
	[Game_Name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Game_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[utbl_Deck_Of_Cards] ******/

/*
Create a table that simulates a deck of cards for playing blackjack
*/

DROP TABLE IF EXISTS [dbo].[utbl_Deck_Of_Cards]
GO

CREATE TABLE [dbo].[utbl_Deck_Of_Cards](
	[Card_ID] [int] NOT NULL,
	[Card_Symbol] [nvarchar](10) NOT NULL,
	[num] [int]  NULL,
	[Selected] [int] NULL default (0)
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[utbl_Definitions] ******/

/*
Create a table of variables that can be changed as needed in the table 
and do not modify the code of the database
*/

DROP TABLE IF EXISTS [dbo].[utbl_Definitions]
GO

CREATE TABLE [dbo].[utbl_Definitions](
	[Type]		 [nvarchar](max)	NULL,
	[Value]		 [int]				NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/****** Object:  Table [dbo].[utbl_Genders] ******/

/*
Create a table to enter the different gender of the players
*/

DROP TABLE IF EXISTS [dbo].[utbl_Genders]
GO

CREATE TABLE [dbo].[utbl_Genders](
	[Gander_ID] [int] NOT NULL identity,
	[Gander_Type] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Gander_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[utbl_Games_Managers] ******/

/*
Create a table of game managers 
along with the hire date of the managers 
*/

DROP TABLE IF EXISTS  [dbo].[utbl_Games_Managers]
GO

CREATE TABLE [dbo].[utbl_Games_Managers](
	[Manager_ID] [int] IDENTITY(1,1) NOT NULL,
	[Manager_Name] [nvarchar](20) NOT NULL,
	[Manager_Game_ID] [int] NOT NULL,
	[Manager_Game_Type] [nvarchar](50) NOT NULL,
	[Hire Date] [datetime] NULL
PRIMARY KEY CLUSTERED 
(
	[Manager_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[utbl_Games_Managers]  WITH CHECK ADD FOREIGN KEY([Manager_Game_ID])
REFERENCES [dbo].[utbl_Games] ([Game_ID])
GO



/****** Object:  Table [dbo].[utbl_Players] ******/

/*
Create a table to enter players data into the database
*/

DROP TABLE IF EXISTS [dbo].[utbl_Players]
GO

CREATE TABLE [dbo].[utbl_Players](
	[Username]			[nvarchar](10)		NOT NULL,
	[Password]			[nvarchar](10)		MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[First_Name]		[nvarchar](20)		MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[Last_Name]			[nvarchar](20)		MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[Address]			[nvarchar](100)		MASKED WITH (FUNCTION = 'default()') NULL,
	[Country]			[nvarchar](20)		NOT NULL,
	[Email_Address]		[nvarchar](100)		MASKED WITH (FUNCTION = 'email()') NOT NULL,
	[Gender]			[nvarchar](10)		NULL,
	[Gender_ID]			int					NULL FOREIGN KEY REFERENCES [dbo].[utbl_Genders]([Gander_ID]),
	[Birth_Date]		[date]				NOT NULL,
	[Credit_Card_Num]	[nvarchar](16)		MASKED WITH (FUNCTION = 'partial(0, "xxxx-xxxx-xxxx", 4)') NULL,
	[Expiry_Date]		[date]				NULL,
	[Blocked]			[int]				NOT NULL,
	[Logged]			[int]				NOT NULL,
	[Last_Login_Time]	[datetime]			NULL,
	[Game_Play]			[int]				NULL,
	[Activity]			[int]				NULL,
	[Activity_Time]		[datetime]			NULL,
	[Last_logout]		[datetime]			NULL,
	[NO_Activity_Time]						AS (datediff(month,[Activity_Time],getdate())),
	[Login_attempts]	[int]				NULL,
	[Manager_Game_ID]	[int]				NULL,
	[SysStartTime]		[datetime2](0)		GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime]		[datetime2](0)		GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[MSSQL_TemporalHistoryFor_965578478] )
)
GO

ALTER TABLE [dbo].[utbl_Players] ADD  DEFAULT ((0)) FOR [Blocked]
GO

ALTER TABLE [dbo].[utbl_Players] ADD  DEFAULT ((0)) FOR [Logged]
GO

ALTER TABLE [dbo].[utbl_Players] ADD  DEFAULT ((0)) FOR [Login_attempts]
GO

ALTER TABLE [dbo].[utbl_Players] ADD  CONSTRAINT [DF_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO

ALTER TABLE [dbo].[utbl_Players] ADD  CONSTRAINT [DF_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD FOREIGN KEY([Manager_Game_ID])
REFERENCES [dbo].[utbl_Games_Managers] ([Manager_ID])
GO

ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD CHECK  ((len([Credit_Card_Num])=(16)))
GO


/****** Object:  Table [dbo].[utbl_Previous_Passwords] ******/

/*
Create a table to record old player passwords
*/

DROP TABLE IF EXISTS [dbo].[utbl_Previous_Passwords]
GO

CREATE TABLE [dbo].[utbl_Previous_Passwords](
	[Username] [nvarchar](10) NOT NULL,
	[Password] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[utbl_Previous_Passwords]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO


/****** Object:  Table [dbo].[utbl_Money_Transactions] ******/

/*
Create a table to record the money transactions 
that occur in the database
*/

DROP TABLE IF EXISTS [dbo].[utbl_Money_Transactions]
GO

CREATE TABLE [dbo].[utbl_Money_Transactions](
	[Transaction_ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](10) NOT NULL,
	[Type] [nvarchar](10) NOT NULL,
	[Amount] [money] NOT NULL,
	[Date] [datetime] NOT NULL
)
GO

ALTER TABLE [dbo].[utbl_Money_Transactions] ADD  DEFAULT (getdate()) FOR [Date]
GO

ALTER TABLE [dbo].[utbl_Money_Transactions]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO

ALTER TABLE [dbo].[utbl_Money_Transactions]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO


/****** Object:  Table [dbo].[utbl_Log_documentation] ******/

/*
Create a table to record the log of the database 
when there are actions of players in the data base
*/

DROP TABLE IF EXISTS [dbo].[utbl_Log_documentation]
GO

CREATE TABLE [dbo].[utbl_Log_documentation](
	[Username] [nvarchar](10) NOT NULL,
	[message] [nvarchar](max) NOT NULL,
	[date] [datetime] NULL,
	[Log_ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Log_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[utbl_Log_documentation] ADD  DEFAULT (getdate()) FOR [date]
GO

ALTER TABLE [dbo].[utbl_Log_documentation]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO


/****** Object:  Table [dbo].[utbl_Games_History] ******/

/*
Create a table to record the game history of the casino players
*/

DROP TABLE IF EXISTS  [dbo].[utbl_Games_History]
GO

CREATE TABLE [dbo].[utbl_Games_History](
	[Game_ID] [int] NOT NULL,
	[Game_Name] [nvarchar](50) NOT NULL,
	[Bet_Amount] [money] NOT NULL,
	[Round] [int] NOT NULL,
	[Win] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Username] [nvarchar](10) NOT NULL,
	[History_ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[History_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[utbl_Games_History] ADD  CONSTRAINT [Round_0]  DEFAULT ((0)) FOR [Round]
GO

ALTER TABLE [dbo].[utbl_Games_History] ADD  DEFAULT (getdate()) FOR [Date]
GO

ALTER TABLE [dbo].[utbl_Games_History]  WITH CHECK ADD FOREIGN KEY([Game_ID])
REFERENCES [dbo].[utbl_Games] ([Game_ID])
GO

ALTER TABLE [dbo].[utbl_Games_History]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO

ALTER TABLE [dbo].[utbl_Games_History]  WITH CHECK ADD CHECK  (([Win]=(0) OR [win]=(1)))
GO



/****** Object:  Table [dbo].[utbl_Feedbacks] ******/

/*
Create a table to enter and record players comments 
if they decide to use the option to enter a comment
*/

DROP TABLE IF EXISTS  [dbo].[utbl_Feedbacks]
GO

CREATE TABLE [dbo].[utbl_Feedbacks](
	[Username]		[nvarchar](10)		 NOT NULL,
	[Comment]		[nvarchar](max)		 NOT NULL,
	[date]			[datetime]			 NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[utbl_Feedbacks] ADD  DEFAULT (getdate()) FOR [date]
GO

ALTER TABLE [dbo].[utbl_Feedbacks]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO



/****** Object:  Table [Analysis].[utbl_Money_Transactions] ******/

/*
Create table in different schema to relocate transactions from [dbo].[utbl_Money_Transactions]
*/

CREATE SCHEMA Analysis
GO

DROP TABLE IF EXISTS [Analysis].[utbl_Money_Transactions]
GO


CREATE TABLE [Analysis].[utbl_Money_Transactions](
	[Transaction_ID]	[int]			IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Username]			[nvarchar](10)	NOT NULL,
	[Type]				[nvarchar](10)  NOT NULL,
	[Amount]			[money]			NOT NULL,
	[Date]				[datetime]		NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Transaction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Analysis].[utbl_Money_Transactions]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO

/***** End tables creation*****/


--==============================================================================================================
--==============================================================================================================


/***** Input data into dictionary tables *****/

USE Casino_Royale
GO

/***** Insert Countries into [utbl_Countries] table *****/

insert into [dbo].[utbl_Countries] ([Country_Name])
values ('Israel'),('England'),('France'),('Washington'),('Spain')


/***** Insert cards number and cards symbols into [utbl_Deck_Of_Cards] table *****/

insert into [dbo].[utbl_Deck_Of_Cards] ([Card_ID],[Card_Symbol])
values (1,'clubs'),(1,'diamonds'),(1,'hearts'),(1,'spades'),
	   (2,'clubs'),(2,'diamonds'),(2,'hearts'),(2,'spades'), 
	   (3,'clubs'),(3,'diamonds'),(3,'hearts'),(3,'spades'), 
	   (4,'clubs'),(4,'diamonds'),(4,'hearts'),(4,'spades'), 
	   (5,'clubs'),(5,'diamonds'),(5,'hearts'),(5,'spades'), 
	   (6,'clubs'),(6,'diamonds'),(6,'hearts'),(6,'spades'), 
	   (7,'clubs'),(7,'diamonds'),(7,'hearts'),(7,'spades'), 
	   (8,'clubs'),(8,'diamonds'),(8,'hearts'),(8,'spades'), 
	   (9,'clubs'),(9,'diamonds'),(9,'hearts'),(9,'spades'), 
	   (10,'clubs'),(10,'diamonds'),(10,'hearts'),(10,'spades'), 
	   (11,'clubs'),(11,'diamonds'),(11,'hearts'),(11,'spades'), 
	   (12,'clubs'),(12,'diamonds'),(12,'hearts'),(12,'spades'), 
	   (13,'clubs'),(13,'diamonds'),(13,'hearts'),(13,'spades') 



/***** Insert database definitions into [utbl_Definitions] table *****/

insert into [dbo].[utbl_Definitions]
values ('Failed login', 5),
	   ('Password length', 5),
	   ('Inactivity', 5),
	   ('Welcome bonus', 10),
	   ('Age limit', 19),
	   ('Daily bonus', 50),
	   ('Login sum', 100),
	   ('Daily bet amount', 1000),
	   ('Deposit amount', 1000)


/***** Insert types of games into [utbl_Games] table *****/

insert into [dbo].[utbl_Games]
values (1, 'Slot Machine'),
	   (2, 'blackjack')


/***** Insert games managers into [utbl_Games_Managers] table *****/

insert into [dbo].[utbl_Games_Managers]
values ('Moshe', 1, 'Slot Machine'),
	   ('Yaniv', 2, 'blackjack')


	   s
/***** Insert types of genders into [utbl_Genders] table *****/

insert into [dbo].[utbl_Genders]
values ('Man'),
	   ('Woman'),
	   ('Transgender')


--==============================================================================================================
--==============================================================================================================


/***** Creating necessary indexes *****/

USE [Casino_Royale]
GO

/****** Object:  Index [IX_Definitions] ******/
CREATE CLUSTERED INDEX [IX_Definitions] ON [dbo].[utbl_Definitions]
(
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Every_day_index] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Every_day_index] ON [dbo].[utbl_Money_Transactions]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


/****** Object:  Index [IX_Feedbacks] ******/
CREATE CLUSTERED INDEX [IX_Feedbacks] ON [dbo].[utbl_Feedbacks]
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Games_ID] ******/
CREATE NONCLUSTERED INDEX [IX_Games_ID] ON [dbo].[utbl_Games_History]
(
	[Game_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Games_Username] ******/
CREATE NONCLUSTERED INDEX [IX_Games_Username] ON [dbo].[utbl_Games_History]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Games_Win] ******/
CREATE NONCLUSTERED INDEX [IX_Games_Win] ON [dbo].[utbl_Games_History]
(
	[Win] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Log_Username] ******/
CREATE NONCLUSTERED INDEX [IX_Log_Username] ON [dbo].[utbl_Log_documentation]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Money_Transactions_ID] ******/
CREATE NONCLUSTERED INDEX [IX_Money_Transactions_ID] ON [dbo].[utbl_Money_Transactions]
(
	[Transaction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


/****** Object:  Index [IX_Money_Transactions_Username] ******/
CREATE NONCLUSTERED INDEX [IX_Money_Transactions_Username] ON [dbo].[utbl_Money_Transactions]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


/****** Object:  Index [IX_Players_Activity] ******/
CREATE NONCLUSTERED INDEX [IX_Players_Activity] ON [dbo].[utbl_Players]
(
	[Activity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Players_Logged] ******/
CREATE NONCLUSTERED INDEX [IX_Players_Logged] ON [dbo].[utbl_Players]
(
	[Logged] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Players_Password] ******/
CREATE NONCLUSTERED INDEX [IX_Players_Password] ON [dbo].[utbl_Players]
(
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Previous_Passwords] ******/
CREATE CLUSTERED INDEX [IX_Previous_Passwords] ON [dbo].[utbl_Previous_Passwords]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/***** End of creating necessary indexes ******/

--==============================================================================================================
--==============================================================================================================

/***** Create a process to monitor DML operations *****/

USE [master]
GO

/****** Object:  Audit [Audit DML] ******/

CREATE SERVER AUDIT [Audit DML]
TO SECURITY_LOG
WITH
(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE
	,AUDIT_GUID = 'fa85d98a-4d7b-4284-95d4-be1962706a23'
)
ALTER SERVER AUDIT [Audit DML] WITH (STATE = OFF)
GO

USE [Casino_Royale]
GO

CREATE DATABASE AUDIT SPECIFICATION [Casino_Royale DML Audi tSpecification]
FOR SERVER AUDIT [Audit DML]
ADD (DELETE ON OBJECT::[dbo].[MSSQL_TemporalHistoryFor_965578478] BY [App_User]),
ADD (INSERT ON OBJECT::[dbo].[MSSQL_TemporalHistoryFor_965578478] BY [App_User]),
ADD (UPDATE ON OBJECT::[dbo].[MSSQL_TemporalHistoryFor_965578478] BY [App_User])
WITH (STATE = ON)
GO

--==============================================================================================================
--==============================================================================================================

/***** Creating Operators *****/

USE [msdb]
GO

/****** Object:  Operator [Dudi] ******/
EXEC msdb.dbo.sp_add_operator @name=N'Dudi', 
		@enabled=1, 
		@weekday_pager_start_time=180000, 
		@weekday_pager_end_time=235900, 
		@saturday_pager_start_time=180000, 
		@saturday_pager_end_time=115900, 
		@sunday_pager_start_time=180000, 
		@sunday_pager_end_time=115900, 
		@pager_days=127, 
		@email_address=N'dudielg@gmail.com', 
		@category_name=N'[Uncategorized]'
GO

/****** Object:  Operator [Yogev] ******/
EXEC msdb.dbo.sp_add_operator @name=N'Yogev', 
		@enabled=1, 
		@weekday_pager_start_time=0, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=110000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=0, 
		@sunday_pager_end_time=180000, 
		@pager_days=127, 
		@email_address=N'yogevc86@gmail.com', 
		@category_name=N'[Uncategorized]'
GO

--==============================================================================================================
--==============================================================================================================


/***** Create a Policy-Based Management Policy *****/

USE master
GO


/* Check Functions names */

Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'Functions names_ObjectSet_1', @facet=N'UserDefinedFunction', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'Functions names_ObjectSet_1', @type_skeleton=N'Server/Database/UserDefinedFunction', @type=N'FUNCTION', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/UserDefinedFunction', @level_name=N'UserDefinedFunction', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'Casino_Royale DB', @target_set_level_id=0


GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'Functions names', @condition_name=N'Check functions names', @policy_category=N'', @description=N'', @help_text=N'', @help_link=N'', @schedule_uid=N'04c375cc-19ce-43c9-9fb9-94abaa55aee3', @execution_mode=4, @is_enabled=True, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'Functions names_ObjectSet_1'
Select @policy_id


GO

/* Check stored procedure names */

Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'Prefix names_ObjectSet', @facet=N'StoredProcedure', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'Prefix names_ObjectSet', @type_skeleton=N'Server/Database/StoredProcedure', @type=N'PROCEDURE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/StoredProcedure', @level_name=N'StoredProcedure', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'Casino_Royale DB', @target_set_level_id=0


GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'Prefix sp names', @condition_name=N'Check prefix sp names', @policy_category=N'', @description=N'', @help_text=N'', @help_link=N'', @schedule_uid=N'04c375cc-19ce-43c9-9fb9-94abaa55aee3', @execution_mode=4, @is_enabled=True, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'Prefix names_ObjectSet'
Select @policy_id


GO

/* Check tables names */

Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'Tables names_ObjectSet_1', @facet=N'Table', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'Tables names_ObjectSet_1', @type_skeleton=N'Server/Database/Table', @type=N'TABLE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/Table', @level_name=N'Table', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'Casino_Royale DB', @target_set_level_id=0


GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'Tables names', @condition_name=N'Check tables names', @policy_category=N'', @description=N'', @help_text=N'', @help_link=N'', @schedule_uid=N'04c375cc-19ce-43c9-9fb9-94abaa55aee3', @execution_mode=4, @is_enabled=True, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'Tables names_ObjectSet_1'
Select @policy_id


GO

--==============================================================================================================
--==============================================================================================================


/***** Creating stored procedurs *****/

USE [Casino_Royale]
GO


/****** Object:  StoredProcedure [dbo].[usp_Log_documentation] ******/

/*
Create a procedure that records the actions of the players in the database,
this procedure is in any other database procedure and is run as needed automatically

Example Executing the stored procedur:

EXEC [dbo].[usp_Log_documentation]
			@@Username			='Yogev'
			@Message			='A player must be logged in to send feedback
*/

CREATE OR ALTER proc [dbo].[usp_Log_documentation]
			@Username			nvarchar (10),
			@Message			nvarchar (max)

AS
	BEGIN
		
/*
	Enter the event in a database log table
*/

		insert into [dbo].[utbl_Log_documentation]
		values (@Username, @Message, getdate())

	END
GO


/****** Object:  StoredProcedure [dbo].[usp_Password_Check] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur that checks the password according to the conditions of the database

Example Executing the stored procedur:

EXEC [usp_Password_Check]
				@Username		='Yogev',
				@Password		='sdfSDFD1',
				@Indicator      = 0
*/

CREATE OR ALTER proc [dbo].[usp_Password_Check]
				@Username  nvarchar (10),
				@Password  nvarchar (10),
				@Indicator int OUTPUT  
AS

	BEGIN
		
		declare @clr	   nvarchar (1)

		set	    @Indicator = 0
		set     @clr	   = (select [dbo].[passwordCheck] (@Password)) 

/*
	Check if the password contains at least one lowercase letter, one uppercase letter, one numeric digit
*/

			IF (@Password NOT LIKE '%[abcdefghijklmnopqrstuvwxyz]%' COLLATE Latin1_General_CS_AI AND 
				@Password NOT LIKE '%[ABCDEFGHIJKLMNOPQRSTUVWXYZ]%' COLLATE Latin1_General_CS_AI AND 
				@Password NOT LIKE '%[0123456789]%')
					
					begin
						select 'The password must contain at least one capital letter, one small letter and one digit'				
						set @Indicator = 1	
						exec usp_Log_documentation @Username = @Username, @Message = 'The password must contain at least one capital letter, one small letter and one digit'
					end

/*
	Check if the password is under the requested length or is similar to a username
*/

			ELSE IF (len(@Password) < (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Password length') OR
					 @Password = @Username)
					
					begin
						select 'The password must be at least 5 characters and not similar to username'
						set @Indicator = 1	
						exec usp_Log_documentation @Username = @Username, @Message = 'The password must be at least 5 characters and not similar to username'
					end

/*
	Check that the password does not contain the word password in any variation
*/

			ELSE IF (((SELECT CASE WHEN BINARY_CHECKSUM(@Password) = BINARY_CHECKSUM(LOWER(@Password)) 
					 THEN 0 
					 ELSE 1 
					 END) = 1 OR
					 (SELECT CASE WHEN BINARY_CHECKSUM(@Password) = BINARY_CHECKSUM(LOWER(@Password)) 
					 THEN 0 
					 ELSE 1 
					 END) =0) AND
					 (@Password LIKE '%password[0123456789]%' OR
			   		  @Password LIKE '%Pass[0123456789]word%' OR
					  @Password LIKE '%[0123456789]Password%'))
					 
					 begin
						select 'The password can not be the word "password" in any combination'
						set @Indicator = 1
						exec usp_Log_documentation @Username = @Username, @Message = 'The password can not be the word "password" in any combination'
					 end

/*
	Checking against the developer's DLL Does the password meet the requirement
*/

			ELSE IF (@clr = 0)
					begin 
						select 'The password is not valid'
						set @Indicator = 1
						exec usp_Log_documentation @Username = @Username, @Message = 'The password is not valid'
					end

END
GO


/****** Object:  StoredProcedure [dbo].[usp_Administration_change_address] ******/

/*
Create a stored procedur in case a player wants to 
change the address entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_address] 
			@Username		='Yogev',
			@New_Address	='Raanana',
			@New_Country	='Israel'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_address]
			@Username		nvarchar (10),
			@New_Address	nvarchar (100),
			@New_Country	nvarchar (20)
as
	BEGIN

/*
Check if the player's username exists in the system
*/				

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
						begin 
							select 'The username you entered does not exist within the system, please enter an existing username'
							exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'				
						end

/* 
	Check whether a player is logged in or not 
*/			
		ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
						begin
							select 'A player must be logged in to change the address'
							exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the address'
						end


		ELSE
						begin
							update [dbo].[utbl_Players]
							set [Address] = @New_Address, [Country] = @New_Country
							where  [Username]= @Username

							select 'The Address and country changed successfully'
							exec usp_Log_documentation @Username = @Username, @Message = 'The Address and country changed successfully'

						end
	END
GO


/****** Object:  StoredProcedure [dbo].[usp_Administration_change_birth_date] ******/

/*
Create a stored procedure in case a player wants to 
change the birth date entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_birth_date] 
				@Username		='Yogev',
				@New_Birth_date	='11.09.1986'
			
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_birth_date]
				@Username		nvarchar (10),
				@New_Birth_date	date
AS
	BEGIN
		declare	@Age			int

		set		@Age			= (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Age limit') 

			BEGIN

/*
Check if the player's username exists in the system
*/				
				IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
						begin 
							select 'The username you entered does not exist within the system, please enter an existing username'
							exec usp_Log_documentation @Username = @Username, @Message =  'The username you entered does not exist within the system'			
						end

/* 
	Check whether a player is logged in or not 
*/			
				ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
					begin
						select 'A player must be logged in to change the birth date'
						exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the birth date'
					end


/*
	Check whether the new age birth date meets the database conditions
*/
				ELSE IF ((select iif(datediff(dd, datediff(dd,getdate(), DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, GETDATE()) +1), 0)))),
						 datediff(dd,@New_Birth_date, DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, @New_Birth_date) +1), 0))))) < 0, 
						 datediff(yy,@New_Birth_date,getdate())-1, datediff(yy,@New_Birth_date,getdate()))) <@Age)
						begin
							select 'Players can not be under the age of ' + @Age
							exec usp_Log_documentation @Username = @Username, @Message = 'Registration was declined due to the age of registration'
						end

/* 
	Update the new birth date in the database
*/
				ELSE 
						update [dbo].[utbl_Players]
						set [Birth_Date] = @New_Birth_date
						where  [Username]= @Username

						select 'The birth date changed successfully'
						exec usp_Log_documentation @Username = @Username, @Message = 'The birth date changed successfully'
			END
	END
GO



/****** Object:  StoredProcedure [dbo].[usp_Administration_change_email] ******/

/*
Create a stored procedure in case a player wants to 
change the email address entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_email] 
			@Username				='Yogev',
			@New_Email_Address		='yogevc86@gmail.com'
			
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_email]
			@Username				nvarchar (10),
			@New_Email_Address		nvarchar (100)
AS
	BEGIN

/*
Check if the player's username exists in the system
*/				

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @Username, @Message =  'The username you entered does not exist within the system'			
				end

/* 
	Check whether a player is logged in or not 
*/			

		ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
				begin
					select 'A player must be logged in to change the email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the email address'
				end

/* 
Check whether the new email address meets the requirements of the database
*/

		ELSE IF (@New_Email_Address NOT LIKE '%@%.%')
				begin
					select 'The email address you entered is not valid, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered is not valid'
				end

/*
	Check if the email address already exists in the database
*/

		ELSE IF EXISTS (select Email_Address from utbl_Players where Email_Address = @New_Email_Address)
				begin 
					select 'The email address you entered already exists in the system, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered already exists in the system'
				end

		ELSE IF EXISTS (select [Email_Address] from [MSSQL_TemporalHistoryFor_965578478] where [Email_Address] = @New_Email_Address)
				begin
					select 'The email address you entered already exists in the system, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered already exists in the system'
				end

/*
	If the email address is valid, the database is updated
*/

		ELSE			
				begin
					update [dbo].[utbl_Players]
					set [Email_Address] = @New_Email_Address
					where  [Username]= @Username

					select 'The email address changed successfully'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address changed successfully'
				end
	END
GO


/****** Object:  StoredProcedure [dbo].[usp_Administration_change_gender] ******/

/*
Create a stored procedure in case a player wants to 
change the gender entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_gender] 
		@Username		= 'Yogev', 
		@New_Gender		= 'Female'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_gender]
		@Username		nvarchar (10),
		@New_Gender		nvarchar (10)
AS
	BEGIN

/*
Check if the player's username exists in the system
*/				

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @Username, @Message =  'The username you entered does not exist within the system'			
				end

/* 
	Check whether a player is logged in or not 
*/			

		ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
				begin
					select 'A player must be logged in to change the gender'
					exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the gender'
				end

/*
	If the gender is valid, the database is updated
*/

		ELSE	update [dbo].[utbl_Players]
				set		[Gender]	= @New_Gender
				where	[Username]	= @Username

				select 'The gender changed successfully'
				exec usp_Log_documentation @Username = @Username, @Message = 'The gender changed successfully'
	END
GO



/****** Object:  StoredProcedure [dbo].[usp_Administration_change_name] ******/

/*
Create a stored procedure in case a player wants to 
change the names entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_name] 
			@Username		='Yogi',
			@New_Firstname	='Yogev',
			@New_Lastname	='Cohen'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_name]
			@Username		 nvarchar (10),
			@New_Firstname	 nvarchar (20),
			@New_Lastname	 nvarchar (20)
AS
	BEGIN

/*
Check if the player's username exists in the system
*/				

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
						begin 
							select 'The username you entered does not exist within the system, please enter an existing username'
							exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'
						end

/* 
	Check whether a player is logged in or not 
*/			

		ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
						begin
							select 'A player must be logged in to change the names'
							exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the names'
						end

/*
	Updating the first and last names in the database
*/

		ELSE
						begin
							update [dbo].[utbl_Players]
							set [First_Name] = @New_Firstname, [Last_Name] = @New_Lastname
							where  [Username]= @Username

							select 'The First name and last name changed successfully'
							exec usp_Log_documentation @Username = @Username, @Message = 'The First name and last name changed successfully'
						end
	END
GO



/****** Object:  StoredProcedure [dbo].[usp_Administration_change_password] ******/

/*
Create a stored procedure in case a player wants to 
change the password entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_password] 
			@Username					='Yogi',
			@New_Password				='DJNdkdn8'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_password]
			@Username					nvarchar (10),
			@New_Password				nvarchar (10)
AS
	BEGIN
			declare @Password_Check		int

/*
Check the new password in another procedure and get an output parameter
*/
		
			exec	usp_Password_Check @Username = @Username, @Password = @New_Password, @Indicator = @Password_Check output

/*
Check if the player's username exists in the system
*/				

				IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
						begin 
							select 'The username you entered does not exist within the system, please enter an existing username'
							exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'
						end

/* 
	Check whether a player is logged in or not 
*/			

				ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
						begin
							select 'A player must be logged in to change the password'
							exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the password'
						end

/*
Check if the new password is invalid
*/

				ELSE IF (@Password_Check =1)
						begin
							exec usp_Log_documentation @Username = @Username, @Message = 'The password is invalid'
						end

/*
	Update the new password in the database
*/

				ELSE 
						 begin 
							 update [dbo].[utbl_Players]
							 set [Password] = @New_Password
							 where [Username] = @Username

							 select 'Password changed successfully'
							 exec usp_Log_documentation @Username = @Username, @Message = 'Password changed successfully'
						 end
	END		
GO



/****** Object:  StoredProcedure [dbo].[usp_blackjack] ******/

/*
Create a stored procedure that creates the blackjack game

Example Executing the stored procedur:

EXEC [usp_blackjack] 
			@user					='Yogi',
			@Bet_Amount				=50,
			@Number_Of_Cards		=3
*/

CREATE OR ALTER proc [dbo].[usp_blackjack]
				@user				nvarchar (10),
				@Bet_Amount			money, 
				@Number_Of_Cards	int
AS
	BEGIN

		declare @counter_Player		int 
		declare @Dealer_sum		    int
		declare @b					int 
		declare @c					int  
--		declare @user				nvarchar (10) 
		declare @sum				int
		declare @Round				int

		set	    @counter_Player		= 0
		set	    @Dealer_sum			= 0
		set     @b					= 0
		set		@c					= 0 
--		set		@user				= (select SUSER_SNAME())
		set		@sum				= (select sum(Amount) from utbl_Money_Transactions 
										where Username = @user group by Username)
		set		@Round				= (select top 1 [Round] from [utbl_Games_History] where [Game_ID] = 2
										order by [Date] desc)


/* 
	Check whether a player is logged in or not 
*/			
			IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @user) = 0)
				begin
					select 'A player must be logged in to play'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to play'
				end

/* 
	Check if the bet amount is higher than the player's total money 
*/			
			ELSE IF (@Bet_Amount > @sum)
				begin
					select 'Bet amount can not be more then the current bankroll amount'
	
					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @user 

					exec usp_Log_documentation @Username = @user, @Message = 'Bet amount can not be more then the current bankroll amount'
				end

/* 
   Creating a temporary table of a deck of cards 
   Selecting a random number of cards according to the player's choice 
*/		
			ELSE
				begin
					create table #Deck_Of_Cards(
					Card_ID int not null,
					Card_Symbol nvarchar (10) not null,
					num int  not null,
					Selected int not null default (0))

					insert into #Deck_Of_Cards (Card_ID, Card_Symbol, num)
					select Card_ID, Card_Symbol, ROW_NUMBER() OVER(ORDER BY [Card_ID]) as num
					from utbl_Deck_Of_Cards	
			
					while (@counter_Player < @Number_Of_Cards)
						begin
							set @b = (SELECT TOP 1 num FROM #Deck_Of_Cards where Selected = 0 ORDER BY NEWID())
							set @c = @c + (select Card_ID from #Deck_Of_Cards where num = @b and Selected = 0)
							update #Deck_Of_Cards set Selected = 1 where num = @b
							set @counter_Player = @counter_Player + 1
						end

/* 
	The beginning of the game, 
	check if the player's cards amount is greater than 21
*/
					if (@c > 21)
						begin
							select 'Player loses'

							insert into utbl_Money_Transactions (Username,Type,Amount)
							values (@user, 'Loss blackjack',-@Bet_Amount)

							update utbl_Players
							set Activity = 1, Activity_Time = getdate(), Game_Play = 'blackjack'  
							where Username = @user

							IF (@Round is null)
								begin
									set @Round = 0
								end

							insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
							values (2,'blackjack', @Bet_Amount, @Round +1, 0, @user)

							exec usp_Log_documentation @Username = @user, @Message = 'The player lost by playing Blackjack'

						end

/* 
	The dealer pulls cards, and then checks to see if the player's cards 
	amount equal to or greater than the dealer's cardinal amount
*/
					else
						while (@c >= @Dealer_sum)
							begin
								set @b = (SELECT TOP 1 num FROM #Deck_Of_Cards where Selected = 0 ORDER BY NEWID())
								set @Dealer_sum = @Dealer_sum + (select Card_ID from #Deck_Of_Cards where num = @b and Selected = 0)
								update #Deck_Of_Cards set Selected = 1 where num = @b
							end

						if (@Dealer_sum >= @c and @Dealer_sum <22)
							begin
								print 'Player loses'

								insert into utbl_Money_Transactions (Username,Type,Amount)
								values (@user, 'Loss blackjack',-@Bet_Amount)

								update utbl_Players
								set Activity = 1, Activity_Time = getdate(), Game_Play = 'blackjack'  
								where Username = @user

								IF (@Round is null)
									begin
										set @Round = 0
									end

								insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
								values (2,'blackjack', @Bet_Amount, @Round +1, 0, @user)

								exec usp_Log_documentation @Username = @user, @Message = 'The player lost by playing Blackjack'

							end
				
						else if (@Dealer_sum >= @c and @Dealer_sum > 22)
							begin
								print 'Player Win'
						
								insert into utbl_Money_Transactions (Username,Type,Amount)
								values (@user, 'Win blackjack',@Bet_Amount) 

								update utbl_Players
								set Activity = 1, Activity_Time = getdate(), Game_Play = 'blackjack'  
								where Username = @user
					
								IF (@Round is null)
									begin
										set @Round = 0
									end

								insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
								values (2,'blackjack', @Bet_Amount, @Round +1, 1, @user)

								exec usp_Log_documentation @Username = @user, @Message = 'The player won by playing Blackjack'

							end
				END
	END
GO



/****** Object:  StoredProcedure [dbo].[usp_Cash_Out] ******/

/*
Create a stored procedur in case a player wants to 
cash out money ftom the casino

Example Executing the stored procedur:

EXEC [usp_Cash_Out] 
				@Cash_Out_Amount	='Yogev',
				@Address			='Raanana
*/


CREATE OR ALTER proc [dbo].[usp_Cash_Out]
				@user				nvarchar (10),
	    		@Cash_Out_Amount	money,
				@Address			nvarchar (100)
AS
	BEGIN
--		declare @user				nvarchar (10) 
		declare @sum				money  

--		set		@user				= (select SUSER_SNAME())
		set		@sum				= (select sum(Amount) from utbl_Money_Transactions 
										 where Username = @user group by Username)

/*
Check if the player's username exists in the system
*/				

			IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @user)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @user, @Message = 'The username you entered does not exist within the system'				
				end

/* 
	Check whether a player is logged in or not 
*/			

			ELSE if ((select [Logged] from [dbo].[utbl_Players] where [Username] = @user) = 0)
				begin
					select 'A player must be logged in to Cash Out'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to Cash Out'
				end


			ELSE if (@Cash_Out_Amount > @sum)
				begin	
					select 'Cash out amount can not be more then the current bankroll amount'
					exec usp_Log_documentation @Username = @user, @Message = 'Cash out amount can not be more then the current bankroll amount'
				end

			ELSE
				begin	
					insert into utbl_Money_Transactions 
					values (@user, 'Cash out', -@Cash_Out_Amount, getdate()) 
		
					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @user 

					exec usp_Log_documentation @Username = @user, @Message = 'Cash out was successful'
				end
	END
GO


/****** Object:  StoredProcedure [dbo].[usp_Deposit] ******/

/*
Create a stored procedur in case a player wants to deposit money into the casino

Example Executing the stored procedur:

EXEC [usp_Deposit] 
			@user				='Yogev'
			@Deposit_Amount		=50,
			@Credit_Card_Number =2535235489651235,
			@Expiry_Month		='8',
			@Expiry_Year		='21'
*/

CREATE OR ALTER proc [dbo].[usp_Deposit] 
			@user				nvarchar (10),
			@Deposit_Amount		money,
			@Credit_Card_Number bigint,
			@Expiry_Month		int,
			@Expiry_Year		int
AS
	BEGIN
--		declare @user			    nvarchar (10) 
		declare @Authorized_deposit int

--		set		@user = (select SUSER_SNAME())
		set     @Authorized_deposit = (select [Value] from [dbo].[utbl_Definitions] 
									   where  [Type] = 'Deposit amount')

/*
Check if the player's username exists in the system
*/				

			IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @user)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @user, @Message = 'The username you entered does not exist within the system'				
				end

/* 
	Check whether a player is logged in or not 
*/			

			ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @user) = 0)
				begin
					select 'A player must be logged in to Deposit'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to Deposit'
				end	

/*
	Check whether the amount of the deposit exceeds the amount allowed for deposit
*/
	
			ELSE IF (@Deposit_Amount > @Authorized_deposit)
				begin
					select 'Deposit amount can not be more then ' + @Authorized_deposit
					exec usp_Log_documentation @Username = @user, @Message = 'deposit is not possible due to the deposit amount'
				end

/*
	Check if your credit card number and expiry date are valid
*/

			ELSE IF (len(@Credit_Card_Number) <> 16 or @Expiry_Month <= MONTH (getdate()) or @Expiry_Year < year (getdate()))
					begin
						select 'One or more of the data you entered is not valid, please re-enter correct data'
						exec usp_Log_documentation @Username = @user, @Message = 'One or more of the data you entered is not valid, please re-enter correct data'
					end
			
/*
	Updating the new credit data in the database
*/

			ELSE
					begin	
						insert into utbl_Money_Transactions 
						values (@user, 'Deposit', @Deposit_Amount, getdate()) 

						update utbl_Players
						set Activity = 1, Activity_Time = getdate()  
						where Username = @user
					
						exec usp_Log_documentation @Username = @user, @Message = 'Deposit was successful '
					end
	END
GO



/****** Object:  StoredProcedure [dbo].[usp_Feedback] ******/

/*
Create a stored procedur in case a player wants to send 
feedback to the casino

Example Executing the stored procedur:

EXEC [usp_Feedback] 
			@user				='Yogev'
			@Feedback			='The casino is nice',
*/

CREATE OR ALTER proc [dbo].[usp_Feedback]
			@user				nvarchar (10),
			@Feedback			nvarchar (max)
AS
	BEGIN
--		declare @user			nvarchar (10) 
	
--		set		@user			= (select SUSER_SNAME())

/*
Check if the player's username exists in the system
*/				

			IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @user)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @user, @Message = 'The username you entered does not exist within the system'				
				end

/* 
	Check whether a player is logged in or not 
*/			

			ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @user) = 0)
				begin
					select 'A player must be logged in to end feedback'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to end feedback'
				end	

/*
	Enter the player's message in the database
*/

			ELSE
					insert into utbl_Feedbacks (Username, Comment)
					values (@user , @Feedback)

					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @user 

					exec usp_Log_documentation @Username = @user, @Message = 'Feedback sent successfully'
	END
GO



/****** Object:  StoredProcedure [dbo].[usp_Login] ******/

/*
Create a stored procedur in case a player wants to login 
into the casino

Example Executing the stored procedur:

EXEC [usp_Login] 
			@Username				='Yogev'
			@Password				='vsvSF454e',
*/

CREATE OR ALTER proc [dbo].[usp_Login]
			@Username	   nvarchar (10),
			@Password	   nvarchar (10)
as
BEGIN
	declare @Blocked	   int
	declare @logIn		   int
	declare @Email_Address nvarchar (100)

	set		@Blocked	   = (select [Value] from [utbl_Definitions] where [Type] = 'Failed login')
	set		@logIn		   = (select [Value] from [utbl_Definitions] where [Type] = 'Login sum')
	set     @Email_Address = (select [Email_Address] from [utbl_Players] where [Username] = @Username)

/*
Check if the player's username exists in the system
*/	

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
				begin
					select 'The username you entered does not exist in the system'
					exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist in the system'
				end

/*
	Check that the player is not blocked in the system
*/

		ELSE IF ((select [Login_attempts] from [utbl_Players] where [Username] = @Username) = @Blocked)
				begin
					update [utbl_Players]
					set  [Blocked] = 1

					select 'The username you entered is blocked due to many login attempts'
					exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered is blocked due to many login attempts'
				end

/*
	Count the number of times a player entered an incorrect password for the same username
*/
			 			
		ELSE IF (@Password != (select [Password] from [utbl_Players] where Username = @Username))
				begin
					update [utbl_Players] 
					set [Login_attempts] = [Login_attempts] + 1
					where [Username] = @Username

					select 'The password you entered does not match for this username'
					exec usp_Log_documentation @Username = @Username, @Message = 'The password you entered does not match for this username'
				end

/*
	Player login to the system
*/

		ELSE IF (@Password = (select [Password] from [utbl_Players] where Username = @Username) AND
				(select [Logged] from [utbl_Players] where [Username] = @Username) = 0)
				begin
					update [utbl_Players] 
					set [Login_attempts] = 0 , [Logged] = 1, [Last_Login_Time] = getdate()
					where [Username] = @Username

					declare @F nvarchar (20) = (select [First_Name] from [utbl_Players] where Username = @Username)
					declare @L nvarchar (20) = (select [Last_Name]  from [utbl_Players] where Username = @Username)

					select 'Welcome ' + @F + ' ' + @L + '.' ' Start playing'

					exec usp_Log_documentation @Username = @Username, @Message = 'Welcome'

/*
	Email the administrator if the number of players currently connected is 100
*/

					IF ((select sum([Logged]) from [utbl_Players]) > @logIn)
						begin
							exec msdb.dbo.sp_send_dbmail 
							@profile_name = [Casino_Royale profile],
							@recipients = @Email_Address,
							@subject = 'Number of players connected',
							@body = 'There are currently more than 100 players online'							
						end

				 end

/*
	A message a player receives if they try to connect when they are already connected
*/

		ELSE 
				select 'You already logged in'
				exec usp_Log_documentation @Username = @Username, @Message = 'You already logged in'
END
GO



/****** Object:  StoredProcedure [dbo].[usp_Logout] ******/

/*
Create a stored procedur in case a player wants to logout 
from the casino

Example Executing the stored procedur:

EXEC [usp_Logout] 
    		 @Username		='Yogev'
*/

CREATE OR ALTER proc [dbo].[usp_Logout]
			 @Username		nvarchar (10) 

AS
	BEGIN

/*
Check if the player's username exists in the system
*/				

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
			begin 
				select 'The username you entered does not exist within the system, please enter an existing username'
				exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'				
			end

/* 
	Check whether a player is logged in or not 
*/	

		ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
			begin
				select 'A player must be logged in to be able to Logout'
				exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to be able to Logout'
			end	

/*
	Updating the database that the player has logged out
*/
	
		ELSE
			begin
					
				update utbl_Players
				set Logged = 0, Last_logout = getdate(), Activity = 0
				where Username = @Username 
				
				exec usp_Log_documentation @Username = @Username, @Message = 'The player has logged out'
			end

	END
GO



/****** Object:  StoredProcedure [dbo].[usp_Registration_Form] ******/

/*
Create a stored procedur for the registration form

Example Executing the stored procedur:

EXEC [usp_Registration_Form] 
			@Username			='togi',
			@Password			='sfSDF8sfs',
			@Firstname			='yogev',
			@Lastname			='cohen',
			@Address			='atlite',
			@Country			='israel',
			@Email_Address		='yogev@crtv.co.il',
			@Gender				='male',
			@Birth_Date			='11/09/1986'
*/

CREATE OR ALTER proc [dbo].[usp_Registration_Form]
			@Username			nvarchar (10),
			@Password			nvarchar (10),
			@Firstname			nvarchar (20),
			@Lastname			nvarchar (20),
			@Address			nvarchar (20),
			@Country			nvarchar (20),
			@Email_Address		nvarchar (20),
			@Gender				nvarchar (10),
			@Birth_Date			date
AS
BEGIN
	declare @Alternate_Username nvarchar (10) 
	declare @Bonus				int
	declare @Password_Check		int
	declare @Age				int

	set		@Bonus			  = (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Welcome bonus')
	set		@Age			  = (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Age limit')

	exec	usp_Password_Check @Username = @Username, @Password = @Password, @Indicator = @Password_Check output

/*
Check if the player's username exists in the system
*/

		IF EXISTS (select Username from utbl_Players where Username = @Username)
			begin
				while (@Alternate_Username = (select Username from utbl_Players where Username = @Alternate_Username))
				begin
					set	@Alternate_Username = @Username + cast((SELECT FLOOR(RAND()*(1000-0+1)+0)) as nvarchar)
				end
				select 'Username already exists, please choose a new username. Here is an alternate suggestion for the username you chose: ' + @Alternate_Username
				exec usp_Log_documentation @Username = @Username, @Message = 'Username already exists, please choose a new username.'
			end

/*
	Check whether the password is valid
*/
	
		ELSE IF (@Password_Check = 1)
				begin 
					select 'Password is invalid, please enter a valid password'
					exec usp_Log_documentation @Username = @Username, @Message = 'Password is invalid, please enter a valid password'
				end

/*
	Check if the email address is valid
*/

		ELSE IF (@Email_Address NOT LIKE '%@%.%')
				begin
					select 'The email address you entered is not valid'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered is not valid'
				end
/*
	Check whether the email address is already in the system
*/

		ELSE IF EXISTS (select [Email_Address] from [MSSQL_TemporalHistoryFor_965578478] where [Email_Address] = @Email_Address)
				begin
					select 'The email address you entered already exists in the system, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered already exists in the system, please enter a new email address'
				end


		ELSE IF EXISTS (select Email_Address from utbl_Players where Email_Address = @Email_Address)
				begin 
					select 'The email address already exists in the system, please enter another address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address already exists in the system, please enter another address'
				end

/*
	Check whether the player's age meets the conditions for registering
*/

		ELSE IF ((select iif(datediff(dd, datediff(dd,getdate(), DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, GETDATE()) +1), 0)))),
				datediff(dd,@Birth_Date, DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, @Birth_Date) +1), 0))))) < 0, 
				datediff(yy,@Birth_Date,getdate())-1, datediff(yy,@Birth_Date,getdate()))) <@Age)
				begin
					select 'Registration to the site is not allowed for players under the age of ' + @Age
					exec usp_Log_documentation @Username = @Username, @Message = 'Registration was declined due to the age of registration'
				end

/*
	Create a new player according to all the parameters that the stored procedure has received
*/

		ELSE 
				begin
					insert into utbl_Players (Username,Password,First_Name,Last_Name,Address,Country,Email_Address,Gender,Birth_Date)
					values (@Username,@Password,@Firstname,@Lastname,@Address,@Country,@Email_Address,@Gender,@Birth_Date)

					insert into utbl_Money_Transactions (Username,Type,Amount)
					values (@Username,'Bonus', @Bonus)

					select 'Welcome to Casino Royale, the registration was successful. By joining the site you will received $10 bonus'

					exec usp_Log_documentation @Username = @Username, @Message = 'registration was successful'
				end
END
GO



/****** Object:  StoredProcedure [dbo].[usp_Slot_Machine] ******/

/*
Create a stored procedur that simulates the game slot machine

Example Executing the stored procedur:

EXEC [usp_Slot_Machine] 
				@Username		='Yogev'
				@Bet_Amount		=200	
*/

CREATE OR ALTER PROC [dbo].[usp_Slot_Machine] 
				@Username		nvarchar (10),
				@Bet_Amount		money
AS
	BEGIN
		declare @wheel_1		int
		declare @wheel_2		int 
		declare @wheel_3		int 
--		declare @user			nvarchar (10) 
		declare @Round			int
		declare @sum			int 


		set		@wheel_1		= (SELECT FLOOR(RAND()*(7-1)+1))
		set		@wheel_2		= (SELECT FLOOR(RAND()*(7-1)+1))
		set		@wheel_3		= (SELECT FLOOR(RAND()*(7-1)+1))
--		set		@user			= (select SUSER_SNAME()) 
		set		@Round			= (select top 1 [Round] from [utbl_Games_History] where [Game_ID] = 1
								   order by [Date] desc)
		set		@sum			= (select sum(Amount) from utbl_Money_Transactions 
								   where Username = @Username group by Username)

/*
Check if the player's username exists in the system
*/				

			IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'				
				end


/*
	Check if the player is connected
*/

			ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
				begin
					select 'A player must be logged in to play Slot_Machine'
					exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to play Slot_Machine'
				end	

/*
	Check if the bet amount is not greater than the player's current amount
*/

			ELSE IF (@Bet_Amount > @sum)
				begin
					select 'Bet amount can not be more then the current bankroll amount'

					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @Username 

					exec usp_Log_documentation @Username = @Username, @Message = 'Bet amount can not be more then the current bankroll amount'
				end

/*
	The beginning of the game, check if the three wheels come out the same shape
*/

			ELSE
				begin
					 IF (@wheel_1 = @wheel_2 and @wheel_2 = @wheel_3)
						begin
							insert into utbl_Money_Transactions (Username,[Type],Amount)
							values (@Username, 'Win Slot Machine',@Bet_Amount) 
							
							IF (@Round is null)
								begin
									set @Round = 0
								end

							update utbl_Players
							set Activity = 1, Activity_Time = getdate(), Game_Play = 'Slot Machine'  
							where Username = @Username

							insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
							values (1,'Slot Machine', @Bet_Amount, @Round +1, 1, @Username)

							select 'The player won by playing Slot Machine'							
							exec usp_Log_documentation @Username = @Username, @Message = 'The player won by playing Slot Machine'
						end

					else
						begin
							insert into utbl_Money_Transactions (Username,[Type],Amount)
							values (@Username, 'Loss Slot Machine',-@Bet_Amount)

							IF (@Round is null)
								begin
									set @Round = 0
								end

							update utbl_Players
							set Activity = 1, Activity_Time = getdate(), Game_Play = 'Slot Machine'  
							where Username = @Username

							insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
							values (1,'Slot Machine', @Bet_Amount, @Round +1, 0, @Username)

							select 'The player lost by playing Slot Machine'
							exec usp_Log_documentation @Username = @Username, @Message = 'The player lost by playing Slot Machine'
									
						end
				end
END
GO



/****** Object:  StoredProcedure [dbo].[usp_Unblock_Player] ******/

/*
Create a stored procedur if a player appeals to management to unblock the Username

Example Executing the stored procedur:

EXEC [usp_Unblock_Playe] 
				@Username		='Yogev'
*/

CREATE OR ALTER proc [dbo].[usp_Unblock_Player]
				@Username		nvarchar (10)
AS
	BEGIN
		declare @New_Password	nvarchar(10)
		declare @Email_Address	nvarchar(100) 

/*
	Use function to create a new strong password
*/
		set		@New_Password	= (SELECT [dbo].[udf_Generate_Password]())
		set		@Email_Address	= (select [Email_Address] from [utbl_Players] where [Username] = @Username)

/*
Check if the player's username exists in the system
*/				

				IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
					begin 
						select 'The username you entered does not exist within the system, please enter an existing username'
						exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'				
					end
/*
	Check if the player is connected
*/

				ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 1)
					begin
						select 'The player is connected'
						exec usp_Log_documentation @Username = @Username, @Message = 'The player is connected'
					end	

/*
	Update the player's new password in the database and send the new password to the player's email
*/

				ELSE
					begin	
						update [utbl_Players]
						set [Blocked] = 0, [Password] = @New_Password , [Login_attempts] = 0
						where [Username] = @Username

						exec msdb.dbo.sp_send_dbmail 
						@profile_name = [Casino_Royale profile],
						@recipients = @Email_Address,
						@subject = 'New password for Casino Royale',
						@body = 'Your password has changed based on your request. Your new password is in this email',
						@query = 'select [Password] from [utbl_Players] where [Username] = (SELECT TOP (1) [Username] FROM [dbo].[MSSQL_TemporalHistoryFor_965578478] order by [SysEndTime] desc)'
				
						exec usp_Log_documentation @Username = @Username, @Message = 'The player is no longer blocked and the new password has been sent to the player email'
					end
	END
GO

/***** End of creating stored procedurs *****/

--==============================================================================================================
--==============================================================================================================


/***** Create functions *****/

USE [Casino_Royale]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[udf_Generate_Password] ******/

/*
Create a function that creates a strong password


Example Executing the function:

SELECT [dbo].[udf_Generate_Password]()

*/

CREATE OR ALTER FUNCTION [dbo].[udf_Generate_Password] ()
RETURNS nvarchar(10)
AS
	BEGIN
	  DECLARE @randInt int;
	  DECLARE @NewCharacter varchar(1) 
	  DECLARE @NewPassword varchar(10) 
 
	  SET @NewPassword=''

		  --5 random characters
		  WHILE (LEN(@NewPassword) <5)
		  BEGIN
			select @randInt=[dbo].[udf_randbetween](48,122)
			--      0-9           < = > ? @ A-Z [ \ ]                   a-z      
			IF @randInt<=57 OR (@randInt>=65 AND @randInt<=90) OR (@randInt>=97 AND @randInt<=122)
			Begin
			  select @NewCharacter=CHAR(@randInt)
			  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)
			END
		  END

		  --Ensure a lowercase
		  select @NewCharacter=CHAR([dbo].[udf_randbetween](97,122))
		  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)
  
		  --Ensure an upper case
		  select @NewCharacter=CHAR([dbo].[udf_randbetween](65,90))
		  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)
  
		  --Ensure a number
		  select @NewCharacter=CHAR([dbo].[udf_randbetween](48,57))
		  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)

		  RETURN(@NewPassword);
	END;
GO



/****** Object:  UserDefinedFunction [dbo].[udf_randbetween] ******/

/*
Create a function that accepts two parameters as numbers and returns a random number between them

Example Executing the function:

SELECT [udf_randbetween] (5,1)
*/


CREATE OR ALTER FUNCTION [dbo].[udf_randbetween] (@bottom int, @top int)
returns int
as
begin
  return (select cast(round((@top-@bottom)* RandomNumber +@bottom,0) as int) from uv_RandomNumber)
end
GO


/***** End creating functions *****/

--==============================================================================================================
--==============================================================================================================


/***** Create jobs *****/

USE [msdb]
GO

/****** Object:  Job [5 minuts activity] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'5 minuts activity', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Search for Player] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Search for Player', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE Casino_Royale
GO
		
update [dbo].[utbl_Players]
set [Logged] = 0, [Last_logout] = getdate()
where [Username] in (select [Username] from [dbo].[utbl_Players]     where [NO_Activity_Time] > 
					(select [Value]	   from [dbo].[utbl_Definitions] where [Type] = ''Inactivity''))', 
		@database_name=N'Casino_Royale', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'CollectorSchedule_Every_1min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190327, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'd3565d38-4ebd-4d0f-874e-3dd1977bfd22'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Analysis table] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Analysis table', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [data transfer] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'data transfer', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE Casino_Royale
GO

TRUNCATE TABLE [Analysis].[utbl_Money_Transactions] 
GO

INSERT INTO  [Analysis].[utbl_Money_Transactions] ([Username], [Type], [Amount],[Date])
SELECT [Username], [Type], [Amount],[Date]
FROM [dbo].[utbl_Money_Transactions]
WHERE [Date] between DATEADD(hh, -24, getdate()) and getdate()
GO
', 
		@database_name=N'Casino_Royale', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Once a day', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190403, 
		@active_end_date=99991231, 
		@active_start_time=233000, 
		@active_end_time=235959, 
		@schedule_uid=N'1dd4c389-3483-4d72-9302-51f9e09520c7'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [Bonus 50] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Bonus 50', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Bonus_50 insert] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Bonus_50 insert', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'Declare @Username		  varchar (10)
Declare @Daily_bet_amount int
Declare @Bonus			  int

set		@Daily_bet_amount = (select [Value] from [dbo].[utbl_Definitions] where [Type] = ''Daily bet amount'')
set		@Bonus			  = (select [Value] from [dbo].[utbl_Definitions] where [Type] = ''Daily bonus'')

Declare Bonus_50  cursor for 
	
	SELECT [Username]
	FROM [utbl_Money_Transactions]
	where ([Type] = ''Win'' or [Type] = ''Loss'') and [Date] between DATEADD(hh, -24, getdate()) and getdate()
	group by [Username]
	having sum(abs([Amount])) > @Daily_bet_amount

open Bonus_50
Fetch next from Bonus_50 into @Username
while @@FETCH_STATUS=0
			
	begin 
		insert into [utbl_Money_Transactions] ([Username], [Type], [Amount])
		values (@Username, ''Bonus'', @Bonus)
		Fetch next from Bonus_50 into @Username
	end 

close Bonus_50
Deallocate Bonus_50', 
		@database_name=N'Casino_Royale', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Bonus 50', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190330, 
		@active_end_date=99991231, 
		@active_start_time=235500, 
		@active_end_time=235959, 
		@schedule_uid=N'7b4f3191-bd7c-4b25-98a1-55aac667a4aa'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [Check Database Integrity] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Check Database Integrity', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Subplan_1] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Subplan_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\"Maintenance Plans\Check Database Integrity\"" /SERVER "\".\"" /CHECKPOINTING OFF /SET "\"\Package\Subplan_1.Disable\"";false /REPORTING E', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Check Database Integrity', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190406, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'd53779f7-b524-4893-b1f1-30b1cd3430e3'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [Check for backups] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Check for backups', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Backup search] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Backup search', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'IF NOT EXISTS (SELECT database_name,backup_start_date, backup_finish_date, type
				FROM msdb..backupset BS
				where database_name = ''Casino_Royale'' AND
				backup_finish_date between DATEADD(hh, -24, getdate()) and getdate()
				order by backup_finish_date desc)

				exec msdb.dbo.sp_send_dbmail 
				@profile_name = [Casino_Royale profile],
				@recipients =''yogevc86@gmail.com'',
				@subject = ''Casino_Royale - Backups issues'',
				@body = ''There was no backup to the Casino_Royale database in the last 24 hours''				
', 
		@database_name=N'Casino_Royale', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Backup check', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190330, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'3fe658b6-8f8d-4fdc-95dc-dd0dde490126'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [Diff backup] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Diff backup', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create diff backup] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create diff backup', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE Casino_Royale
TO DISK = N''C:\Casino_Royale\Backup\Casino_Royale.bak'' 
WITH DIFFERENTIAL, CHECKSUM
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 60 min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=60, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190327, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=230000, 
		@schedule_uid=N'8cda95d3-5fb7-40ca-ad3b-3e8cac4bf090'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Full backup] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Full backup', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [create full backup]  ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'create full backup', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE Casino_Royale
TO  DISK = N''C:\Casino_Royale\Backup\Casino_Royale.bak''
WITH CHECKSUM', 
		@database_name=N'Casino_Royale', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Full backup schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190327, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'1fb3e822-ae7d-4a36-8049-2db460575950'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [No logins] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'No logins', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Check logins] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check logins', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use Casino_Royale
GO

IF NOT EXISTS (select [Username], [Last_Login_Time] from [utbl_Players]
				where [Last_Login_Time] between DATEADD(mi, -10, getdate()) and getdate())
				
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = [Casino_Royale profile],
				@recipients =''yogevc86@gmail.com'',
				@subject = ''Casino_Royale - Logins issues'',
				@body = ''There were no Logins to the Casino_Royale system in the last 10 minutes''
', 
		@database_name=N'Casino_Royale', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Logins check', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190331, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'c7fe9a0d-a998-470b-99e0-dadb6b601fcc'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Rebuilding indexes] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Rebuilding indexes', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Subplan_1] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Subplan_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\"Maintenance Plans\Rebuilding indexes\"" /SERVER "\".\"" /CHECKPOINTING OFF /SET "\"\Package\Subplan_1.Disable\"";false /REPORTING E', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Rebuilding indexes', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190406, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'16d467e0-7ca0-4fc5-87f0-714ef9b25b2f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [Reorganize Index] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Reorganize Index', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Subplan_1] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Subplan_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\"Maintenance Plans\Reorganize Index\"" /SERVER "\".\"" /CHECKPOINTING OFF /SET "\"\Package\Subplan_1.Disable\"";false /REPORTING E', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Reorganize Index', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190406, 
		@active_end_date=99991231, 
		@active_start_time=30000, 
		@active_end_time=235959, 
		@schedule_uid=N'a8ae8044-d487-4618-8d1b-e813306b0b4f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [syspolicy_check_schedule_04C375CC-19CE-43C9-9FB9-94ABAA55AEE3] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'syspolicy_check_schedule_04C375CC-19CE-43C9-9FB9-94ABAA55AEE3', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verify that automation is enabled.] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verify that automation is enabled.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=2, 
		@on_fail_action=1, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'IF (msdb.dbo.fn_syspolicy_is_automation_enabled() != 1)
        BEGIN
            RAISERROR(34022, 16, 1)
        END', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Evaluate policies.] ******/
declare @server nvarchar (100)
set		@server = (select @@SERVERNAME)

select N'''ss'+ @server 

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Evaluate policies.', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command='dir SQLSERVER:\SQLPolicy\' + @server + '\default\Policies | where { $_.ScheduleUid -eq "04C375CC-19CE-43C9-9FB9-94ABAA55AEE3" } |  where { $_.Enabled -eq 1} | where {$_.AutomatedPolicyEvaluationMode -eq 4} | Invoke-PolicyEvaluation -AdHocPolicyEvaluationMode 2 -TargetServerName' + @server + '', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'SP check', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190331, 
		@active_end_date=99991231, 
		@active_start_time=120000, 
		@active_end_time=235959, 
		@schedule_uid=N'04c375cc-19ce-43c9-9fb9-94abaa55aee3'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Transaction log backup] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Transaction log backup', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create Transaction log backup] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Transaction log backup', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP LOG [Casino_Royale] TO  DISK = N''C:\Casino_Royale\Backup\Casino_Royale.trn'' 
WITH CHECKSUM
GO', 
		@database_name=N'Casino_Royale', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'1 min log', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190327, 
		@active_end_date=99991231, 
		@active_start_time=1, 
		@active_end_time=235959, 
		@schedule_uid=N'23470d1a-b33e-477a-9835-040029d40e4e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [Transaction partition] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Transaction partition', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Alter partiton] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Alter partiton', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [master]
GO

declare @date				 date 
declare @File_group			 nvarchar (max)  
declare @Exec_Filegroup		 nvarchar (max)  
declare @Exec_Alter			 nvarchar (max)


set	    @date				 = getdate()
set		@File_group			 = ''[Fg_''+ cast(@date as nvarchar (max)) +'']''
set		@Exec_Filegroup		 = ''ALTER DATABASE [Casino_Royale] ADD FILEGROUP '' + @File_group + 
								
								''  ALTER DATABASE [Casino_Royale] 
								ADD FILE ( 
											NAME = N''''Data_File_'' + cast(@date as nvarchar (max)) +'''''',  
											FILENAME = N''''C:\Casino_Royale\Data\Data_File_'' + cast(@date as nvarchar (max)) + ''.ndf''''''+'', 
											SIZE = 8192KB , 
											FILEGROWTH = 65536KB 
										  ) 
								TO FILEGROUP '' + @File_group

set		@Exec_Alter			 = ''ALTER PARTITION FUNCTION Every_day_fun ()  
								SPLIT RANGE ('''''' + cast(@date as nvarchar (max)) + '''''')

								ALTER PARTITION SCHEME Every_day_Scheme  
								NEXT USED '' + @File_group


	exec (@Exec_Filegroup)

USE Casino_Royale

	exec (@Exec_Alter)
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Partition time', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190405, 
		@active_end_date=99991231, 
		@active_start_time=3000, 
		@active_end_time=235959, 
		@schedule_uid=N'be35ce89-8cac-4c94-b6fe-c3a1c23c59aa'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



/****** Object:  Job [Update Statistics] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Update Statistics', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Subplan_1] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Subplan_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\"Maintenance Plans\Update Statistics\"" /SERVER "\".\"" /CHECKPOINTING OFF /SET "\"\Package\Subplan_1.Disable\"";false /REPORTING E', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Update Statistics', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190406, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959, 
		@schedule_uid=N'd4150961-125a-4a0b-b6f7-678ff5ac0420'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/***** End of creating jobs *****/

--==============================================================================================================
--==============================================================================================================


/***** Create RLS *****/


USE Casino_Royale
GO


CREATE SCHEMA RLS_SCHEMA;  
GO  

CREATE OR ALTER FUNCTION RLS_SCHEMA.udf_security_predicate(@Manager_Game_ID int)  
    RETURNS TABLE  
    WITH SCHEMABINDING  
AS  
    RETURN SELECT 1 AS fn_securitypredicate_result  
    WHERE  
        DATABASE_PRINCIPAL_ID() = DATABASE_PRINCIPAL_ID('App_User')    
        AND CAST(SESSION_CONTEXT(N'UserId') AS int) = @Manager_Game_ID;   
GO  


CREATE USER App_User WITHOUT LOGIN;   
GRANT SELECT ON utbl_Games_Managers TO App_User  
  
DENY UPDATE ON [utbl_Players]([Manager_Game_ID]) TO App_User


CREATE SECURITY POLICY RLS_SCHEMA.Player_Filter  
    ADD FILTER PREDICATE RLS_SCHEMA.udf_security_predicate(Manager_Game_ID)   
        ON [dbo].[utbl_Players],  
    ADD BLOCK PREDICATE RLS_SCHEMA.udf_security_predicate(Manager_Game_ID)   
        ON [dbo].[utbl_Players] AFTER INSERT   
    WITH (STATE = ON);  

--===============================================================================================
--Now we can filtering by selecting 
--from the players table after setting different Manager_Game_IDs in SESSION_CONTEXT. 
--In practice, the application is responsible for setting the current user ID in SESSION_CONTEXT 
--after opening a connection.
--===============================================================================================

--==============================================================================================================
--==============================================================================================================


/***** Create a Database Mail account and profile *****/

USE Casino_Royale
GO

-- Create a Database Mail account  
EXECUTE msdb.dbo.sysmail_add_account_sp  
    @account_name = 'Casino_Royale account',  
    @email_address = 'yogevc86@gmail.com',  
    @replyto_address = 'yogevc86@gmail.com',  
    @display_name = 'yogevc86@gmail.com',  
    @mailserver_name = 'smtp.gmail.com' ,
	@port = 465 ,
	@enable_ssl = 1  
  
-- Create a Database Mail profile   
EXECUTE msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'Casino_Royale profile' 
  
-- Add the account to the profile  
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'Casino_Royale profile',  
    @account_name = 'Casino_Royale account',  
    @sequence_number =1 ;  
  
-- Grant access to the profile to all users in the msdb database   
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
    @profile_name = 'Casino_Royale profile',  
    @principal_name = 'public',  
    @is_default = 1  


--==============================================================================================================
--==============================================================================================================

/***** Create partition function and scheme *****/

USE Casino_Royale
GO

CREATE PARTITION FUNCTION Every_day_fun (datetime)  
    AS RANGE LEFT FOR VALUES ('2019-04-05')

CREATE PARTITION SCHEME Every_day_Scheme
    AS PARTITION Every_day_fun  
    TO ([Fg_2019-04-04], [Fg_2019-04-05])


CREATE UNIQUE CLUSTERED INDEX IX_Every_day_index 
ON [dbo].[utbl_Money_Transactions]([Date]) ON Every_day_Scheme([Date])

--==============================================================================================================
--==============================================================================================================

/***** Definition of CLR *****/

USE Casino_Royale
GO

EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO

EXEC sp_configure 'clr strict security', 0
GO
RECONFIGURE
GO

sp_configure 'clr enable', 1
GO
RECONFIGURE
GO


/****** Object:  SqlAssembly [Casino] ******/
CREATE ASSEMBLY [Casino]
FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C0103005245A75C0000000000000000E00022200B0130000006000000060000000000007A250000002000000040000000000010002000000002000004000000000000000600000000000000008000000002000000000000030060850000100000100000000010000010000000000000100000000000000000000000282500004F00000000400000A002000000000000000000000000000000000000006000000C000000F02300001C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E7465787400000080050000002000000006000000020000000000000000000000000000200000602E72737263000000A0020000004000000004000000080000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000000C000000000000000000000000000040000042000000000000000000000000000000005C25000000000000480000000200050078200000780300000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133001001000000001000011007201000070280500000A0A2B00062A2202280600000A002A00000042534A4201000100000000000C00000076342E302E33303331390000000005006C00000030010000237E00009C0100006001000023537472696E677300000000FC020000080000002355530004030000100000002347554944000000140300006400000023426C6F620000000000000002000001471502000900000000FA013300160000010000000700000002000000020000000100000006000000040000000100000001000000020000000000A70001000000000006005100F40006007100F40006002800E1000F001401000006004D01B2000A003C00C0000A008F0023010000000001000000000001000100010010003801000015000100010050200000000096009900240001006C20000000008618DB0006000200000001001F000900DB0001001100DB0006001900DB000A003100DB0006003900540115002900DB000600200023005C002E000B002B002E00130034002E001B0053001000048000000000000000000000000000000000B90000000400000000000000000000001B001600000000000400000000000000000000001B000A00000000000000003C4D6F64756C653E0053797374656D2E44617461006D73636F726C69620070617373776F72640044656275676761626C654174747269627574650053716C46756E6374696F6E41747472696275746500436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C6974794174747269627574650053716C537472696E670070617373776F7264436865636B00436173696E6F2E646C6C0053797374656D00436173696E6F004D6963726F736F66742E53716C5365727665722E536572766572002E63746F720053797374656D2E446961676E6F73746963730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300446562756767696E674D6F6465730053797374656D2E446174612E53716C54797065730055736572446566696E656446756E6374696F6E73004F626A656374006F705F496D706C696369740000033100000000005F21A309F5639A449FD69CF93A7840D200042001010803200001052001011111040701111D050001111D0E08B77A5C561934E089060001111D111D0801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F7773010801000701000000000401000000000000000000005145A75C00000000020000001C0100000C2400000C060000525344537D121E07719B6248B95E8465BED9233D01000000433A5C55736572735C596F6765765C736F757263655C7265706F735C436173696E6F5C436173696E6F5C6F626A5C44656275675C436173696E6F2E7064620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005025000000000000000000006A2500000020000000000000000000000000000000000000000000005C250000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF2500200010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000440200000000000000000000440234000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000000000000000000000000000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B004A4010000010053007400720069006E006700460069006C00650049006E0066006F0000008001000001003000300030003000300034006200300000002C0002000100460069006C0065004400650073006300720069007000740069006F006E000000000020000000300008000100460069006C006500560065007200730069006F006E000000000030002E0030002E0030002E003000000036000B00010049006E007400650072006E0061006C004E0061006D006500000043006100730069006E006F002E0064006C006C00000000002800020001004C006500670061006C0043006F0070007900720069006700680074000000200000003E000B0001004F0072006900670069006E0061006C00460069006C0065006E0061006D006500000043006100730069006E006F002E0064006C006C0000000000340008000100500072006F006400750063007400560065007200730069006F006E00000030002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000030002E0030002E0030002E00300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C0000007C3500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
WITH PERMISSION_SET = SAFE
GO

ALTER ASSEMBLY [Casino]
ADD FILE FROM 0x4D6963726F736F667420432F432B2B204D534620372E30300D0A1A4453000000000200000200000017000000740000000000000014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3800E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0BCA3101380000000010000000100000000000000E00FFFF04000000FFFF03000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA3101380000000010000000100000000000000F00FFFF04000000FFFF0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000942E31015145A75C010000007D121E07719B6248B95E8465BED9233D00000000000000000100000001000000000000000000000000000000DC51330100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA310138000000001000000010000000000000FFFFFFFF04000000FFFF030000000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA310138000000001000000010000000000000FFFFFFFF04000000FFFF030000000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F862513FC607D311905300C04FA302A1C4454B99E9E6D211903F00C04FA302A10B9D865A1166D311BD2A0000F80849BDEC1618FF5EAA104D87F76F49638334601400000000000000F978D8C4CEF72AF5BCFAA6207713205F8A06B36A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FEEFFEEF010000007800000000433A5C55736572735C596F6765765C736F757263655C7265706F735C436173696E6F5C436173696E6F5C70617373776F7264436865636B2E63730000633A5C75736572735C796F6765765C736F757263655C7265706F735C636173696E6F5C636173696E6F5C70617373776F7264636865636B2E637300040000003C00000000000000010000003D0000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001BE230018000000026196E54A8EBD40101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000020000000100000002000000000000003D000000280000001BE23001E20F309B5C000000010000003C0000003D0000006500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000036002A11000000000C010000000000001000000000000000000000000100000600000000010000000070617373776F7264436865636B00001600031104000000CC0000001000000000000000010000000A0024115553797374656D00120024115553797374656D2E44617461000000001A0024115553797374656D2E446174612E53716C436C69656E7400001A0024115553797374656D2E446174612E53716C54797065730000001E002411554D6963726F736F66742E53716C5365727665722E53657276657200020006003A000404C93FEAC6B359D649BC250902BBABB460000000004D0044003200000004020000040000000C00000001000500040600020C0000001601000002000600F20000003C000000000000000100010010000000000000000300000030000000000000000B000080010000000D0000800E0000000E000080050006000900140005000600F400000008000000010000000000000008000000000000001C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF1A092FF1100000000C0200001D000000010000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001A0025110000000004000000010070617373776F7264436865636B001600291100000000040000000100303630303030303100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000FFFFFFFF1A092FF10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF77093101010000000B00108E0C0084690D00060060000000200000002C00000048000000000000000000000016000000190000000000EEC00000000000000000FFFF000000000000FFFFFFFF00000000FFFF0000000000000000000000000A001001000000000000540000000100000000000000000000000000000055736572446566696E656446756E6374696F6E730037314141414545380000002DBA2EF101000000000000001000000000000000000000000000000000000000020002000D01000000000100FFFFFFFF00000000100000000802000000000000FFFFFFFF00000000FFFFFFFF010001000000010000000000433A5C55736572735C596F6765765C736F757263655C7265706F735C436173696E6F5C436173696E6F5C70617373776F7264436865636B2E63730000FEEFFEEF010000000100000000010000000000000000000000FFFFFFFFFFFFFFFFFFFF0900FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000942E31015145A75C010000007D121E07719B6248B95E8465BED9233D680000002F4C696E6B496E666F002F6E616D6573002F7372632F686561646572626C6F636B002F7372632F66696C65732F633A5C75736572735C796F6765765C736F757263655C7265706F735C636173696E6F5C636173696E6F5C70617373776F7264636865636B2E6373000400000006000000010000001E00000000000000110000000700000022000000080000000A00000006000000000000000500000000000000DC513301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E00000020000000C4000000380000006301000038000000000000009C000000800000005C00000028000000700100002C0200002C0000003400000003000000120000000600000011000000070000000A0000000B00000008000000090000000C0000000D0000000E000000100000000F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
AS N'Casino.pdb'
GO


/****** Object:  UserDefinedFunction [dbo].[passwordCheck] ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE OR ALTER FUNCTION [dbo].[passwordCheck]  (@password [nvarchar](max))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Casino].[UserDefinedFunctions].[passwordCheck]
GO

--==============================================================================================================
--==============================================================================================================


/***** Create a transaction replication with all its components *****/



USE [master]
GO

/****** Object:  Database [Casino_Royale_Replication] ******/

/***** Create database for Casino_Royale database replication *****/


DROP DATABASE IF EXISTS [Casino_Royale_Replication]
GO

declare @Path varchar(100)
set @Path = 'C:\Casino_Royale_Replication\Data'
EXEC master.dbo.xp_create_subdir @Path

set @Path = 'C:\Casino_Royale_Replication\Backup'
EXEC master.dbo.xp_create_subdir @Path

set @Path = 'C:\Casino_Royale_Replication\Log'
EXEC master.dbo.xp_create_subdir @Path


CREATE DATABASE [Casino_Royale_Replication]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Casino_Royale_Replication', FILENAME = N'C:\Casino_Royale_Replication\Data\Casino_Royale_Replication.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Casino_Royale_Replication_log', FILENAME = N'C:\Casino_Royale_Replication\Data\Casino_Royale_Replication_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Casino_Royale_Replication] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Casino_Royale_Replication].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Casino_Royale_Replication] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET ARITHABORT OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Casino_Royale_Replication] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Casino_Royale_Replication] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET  ENABLE_BROKER 
GO

ALTER DATABASE [Casino_Royale_Replication] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Casino_Royale_Replication] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET RECOVERY FULL 
GO

ALTER DATABASE [Casino_Royale_Replication] SET  MULTI_USER 
GO

ALTER DATABASE [Casino_Royale_Replication] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Casino_Royale_Replication] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Casino_Royale_Replication] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Casino_Royale_Replication] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Casino_Royale_Replication] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Casino_Royale_Replication] SET QUERY_STORE = OFF
GO

ALTER DATABASE [Casino_Royale_Replication] SET  READ_WRITE 
GO


/***** End of database creation *****/

--==============================================================================================================
--==============================================================================================================


/***** Create tables in replication database *****/


USE [Casino_Royale_Replication]
GO

/****** Object:  Table [Analysis].[utbl_Money_Transactions] ******/

CREATE SCHEMA Analysis
GO

DROP TABLE IF EXISTS [Analysis].[utbl_Money_Transactions]
GO

CREATE TABLE [Analysis].[utbl_Money_Transactions](
	[Transaction_ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Username] [nvarchar](10) NOT NULL,
	[Type] [nvarchar](10) NOT NULL,
	[Amount] [money] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK__utbl_Mon__9A8D56257D5785E8] PRIMARY KEY CLUSTERED 
(
	[Transaction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[utbl_Games_History] ******/

DROP TABLE IF EXISTS [dbo].[utbl_Games_History]
GO

CREATE TABLE [dbo].[utbl_Games_History](
	[Game_ID] [int] NOT NULL,
	[Game_Name] [nvarchar](50) NOT NULL,
	[Bet_Amount] [money] NOT NULL,
	[Round] [int] NOT NULL,
	[Win] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Username] [nvarchar](10) NOT NULL,
	[History_ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
 CONSTRAINT [PK__utbl_Gam__A6BABA37D60F7051] PRIMARY KEY CLUSTERED 
(
	[History_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[utbl_Log_documentation] ******/

DROP TABLE IF EXISTS  [dbo].[utbl_Log_documentation]
GO

CREATE TABLE [dbo].[utbl_Log_documentation](
	[Username] [nvarchar](10) NOT NULL,
	[message] [nvarchar](max) NOT NULL,
	[date] [datetime] NULL,
	[Log_ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
 CONSTRAINT [PK__utbl_Log__2D26E7AEF73DB9B3] PRIMARY KEY CLUSTERED 
(
	[Log_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


--==============================================================================================================
--==============================================================================================================


/****** Scripting replication configuration ******/
/****** Please Note: For security reasons, all password parameters were scripted with either NULL or an empty string ******/

/****** Begin: Script to be run at Publisher ******/

/****** Installing the server as a Distributor. Script Date: ******/
USE master
GO

declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

exec sp_adddistributor @distributor = @server, @password = N'', @from_scripting = 1
GO

-- Adding the agent profiles
-- Updating the agent profile defaults
exec sp_MSupdate_agenttype_default @profile_id = 1
GO
exec sp_MSupdate_agenttype_default @profile_id = 2
GO
exec sp_MSupdate_agenttype_default @profile_id = 4
GO
exec sp_MSupdate_agenttype_default @profile_id = 6
GO
exec sp_MSupdate_agenttype_default @profile_id = 11
GO

-- Adding the distribution databases
USE master
exec sp_adddistributiondb @database = N'distribution_Casino', @data_folder = N'C:\Casino_Royale\Data', @data_file = N'distribution_Casino.MDF', @data_file_size = 13, @log_folder = N'C:\Casino_Royale\Data', @log_file = N'distribution_Casino.LDF', @log_file_size = 9, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @deletebatchsize_xact = 5000, @deletebatchsize_cmd = 2000, @security_mode = 1, @from_scripting = 1
GO

------ Script Date: Replication agents checkup ------
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Checkup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Checkup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Replication agents checkup')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Replication agents checkup', @enabled = 1, @description = N'Detects replication agents that are not logging history actively.', @start_step_id = 1, @category_name = N'REPL-Checkup', @owner_login_name = N'sa', @notify_level_eventlog = 2, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'sys.sp_replication_agent_checkup @heartbeat_interval = 10', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @database_name = N'master', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 10, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20190408, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name =  @server 
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Replication monitoring refresher for distribution_Casino. ------
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Alert Response') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Alert Response'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Replication monitoring refresher for distribution_Casino.')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Replication monitoring refresher for distribution_Casino.', @enabled = 0, @description = N'Replication monitoring refresher for distribution_Casino.', @start_step_id = 1, @category_name = N'REPL-Alert Response', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'exec dbo.sp_replmonitorrefreshjob  ', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = @server , @database_name = N'distribution_Casino', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20190408, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = @server
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Reinitialize subscriptions having data validation failures ------
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Alert Response') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Alert Response'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Reinitialize subscriptions having data validation failures')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Reinitialize subscriptions having data validation failures', @enabled = 1, @description = N'Reinitializes all subscriptions that have data validation failures.', @start_step_id = 1, @category_name = N'REPL-Alert Response', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'exec sys.sp_MSreinit_failed_subscriptions @failure_level = 1', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = @server, @database_name = N'master', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = @server
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Agent history clean up: distribution_Casino ------
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-History Cleanup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-History Cleanup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Agent history clean up: distribution_Casino')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Agent history clean up: distribution_Casino', @enabled = 1, @description = N'Removes replication agent history from the distribution database.', @start_step_id = 1, @category_name = N'REPL-History Cleanup', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'EXEC dbo.sp_MShistory_cleanup @history_retention = 48', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = @server, @database_name = N'distribution_Casino', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 10, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20190408, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = @server
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Agent history clean up: distribution_Casino_Royale ------
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-History Cleanup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-History Cleanup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Agent history clean up: distribution_Casino_Royale')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Agent history clean up: distribution_Casino_Royale', @enabled = 0, @description = N'Removes replication agent history from the distribution database.', @start_step_id = 1, @category_name = N'REPL-History Cleanup', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'EXEC dbo.sp_MShistory_cleanup @history_retention = 48', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = @server, @database_name = N'Casino_Royale', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 10, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20190202, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = @server
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Distribution clean up: distribution_Casino ------
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution Cleanup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution Cleanup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Distribution clean up: distribution_Casino')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Distribution clean up: distribution_Casino', @enabled = 0, @description = N'Removes replicated transactions from the distribution database.', @start_step_id = 1, @category_name = N'REPL-Distribution Cleanup', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'EXEC dbo.sp_MSdistribution_cleanup @min_distretention = 0, @max_distretention = 72', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = @server, @database_name = N'distribution_Casino', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 10, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20190408, @active_end_date = 99991231, @active_start_time = 500, @active_end_time = 459
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = @server
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

-- Adding the distribution publishers
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

exec sp_adddistpublisher @publisher = @server, @distribution_db = N'distribution_Casino', @security_mode = 1, @working_directory = N'C:\Casino_Royale\Data', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER'
GO

------ Script Date: Expired subscription clean up ------
declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Subscription Cleanup') < 1 
  execute msdb.dbo.sp_add_category @name = N'REPL-Subscription Cleanup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Expired subscription clean up')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Expired subscription clean up', @enabled = 1, @description = N'Detects and removes expired subscriptions from published databases or distribution databases.', @start_step_id = 1, @category_name = N'REPL-Subscription Cleanup', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'EXEC sys.sp_expired_subscription_cleanup', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = @server, @database_name = N'master', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 1, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20190408, @active_end_date = 99991231, @active_start_time = 10000, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = @server
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO


/****** End: Script to be run at Publisher ******/


-- Enabling the replication database
USE master
exec sp_replicationdboption @dbname = N'Casino_Royale', @optname = N'publish', @value = N'true'
GO
exec [Casino_Royale].sys.sp_addlogreader_agent @publisher_security_mode = 1, @job_name = N'server-Casino_Royale-1', @job_login = null, @job_password = null
GO
exec [Casino_Royale].sys.sp_addqreader_agent @job_name = null, @frompublisher = 1, @job_login = null, @job_password = null
GO


/***** Create Publication *****/ 

USE [Casino_Royale]
GO

declare @server nvarchar (100)  
set		@server	= (select @@SERVERNAME)

exec sp_replicationdboption @dbname = N'Casino_Royale', @optname = N'publish', @value = N'true'
GO
-- Adding the transactional publication
use [Casino_Royale]
exec sp_addpublication @publication = N'Casino Royale publication', @description = N'Transactional publication of database ''Casino_Royale'' from Publisher ''' + @server +  '''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'Casino Royale publication', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1


use [Casino_Royale]
exec sp_addarticle @publication = N'Casino Royale publication', @article = N'utbl_Games_History', @source_owner = N'dbo', @source_object = N'utbl_Games_History', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'utbl_Games_History', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboutbl_Games_History', @del_cmd = N'CALL sp_MSdel_dboutbl_Games_History', @upd_cmd = N'SCALL sp_MSupd_dboutbl_Games_History'
GO




use [Casino_Royale]
exec sp_addarticle @publication = N'Casino Royale publication', @article = N'utbl_Log_documentation', @source_owner = N'dbo', @source_object = N'utbl_Log_documentation', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'utbl_Log_documentation', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboutbl_Log_documentation', @del_cmd = N'CALL sp_MSdel_dboutbl_Log_documentation', @upd_cmd = N'SCALL sp_MSupd_dboutbl_Log_documentation'
GO




use [Casino_Royale]
exec sp_addarticle @publication = N'Casino Royale publication', @article = N'utbl_Money_Transactions', @source_owner = N'Analysis', @source_object = N'utbl_Money_Transactions', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'utbl_Money_Transactions', @destination_owner = N'Analysis', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_Analysisutbl_Money_Transactions', @del_cmd = N'CALL sp_MSdel_Analysisutbl_Money_Transactions', @upd_cmd = N'SCALL sp_MSupd_Analysisutbl_Money_Transactions'
GO


/***** Create subscription *****/

use [Casino_Royale]

declare @server nvarchar (100) 
set		@server =  'N''' + (select @@SERVERNAME)

exec sp_addsubscription @publication = N'Casino Royale publication', @subscriber = @server , @destination_db = N'Casino_Royale_Replication', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'Casino Royale publication', @subscriber = @server, @subscriber_db = N'Casino_Royale_Replication', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 20190406, @active_end_date = 99991231, @enabled_for_syncmgr = N'False', @dts_package_location = N'Distributor'
GO


/***** Replication jobs *****/

USE [msdb]
GO

/****** Object:  Job [Agent history clean up: distribution_Casino] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-History Cleanup] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-History Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-History Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Agent history clean up: distribution_Casino', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Removes replication agent history from the distribution database.', 
		@category_name=N'REPL-History Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_MShistory_cleanup @history_retention = 48', 
		@server= @server, 
		@database_name=N'distribution_Casino', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190408, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'f5580bb5-d8a3-4839-a4ff-e202d459177d'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Distribution clean up: distribution_Casino] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Distribution Cleanup] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Distribution Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Distribution Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Distribution clean up: distribution_Casino', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Removes replicated transactions from the distribution database.', 
		@category_name=N'REPL-Distribution Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 19/04/08 11:35:23 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_MSdistribution_cleanup @min_distretention = 0, @max_distretention = 72', 
		@server= @server, 
		@database_name=N'distribution_Casino', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190408, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=459, 
		@schedule_uid=N'7ba75679-0b4d-4f08-889a-9bad13bfe37c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Expired subscription clean up]  ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Subscription Cleanup] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Subscription Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Subscription Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
DECLARE @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Expired subscription clean up', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Detects and removes expired subscriptions from published databases or distribution databases.', 
		@category_name=N'REPL-Subscription Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.] ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sys.sp_expired_subscription_cleanup', 
		@server= @server, 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=1, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190408, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'0bfa00fa-69d6-4176-8930-2c49309f8c1a'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Reinitialize subscriptions having data validation failures] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Alert Response] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Alert Response' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Alert Response'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @server nvarchar (100)
DECLARE @jobId BINARY(16)

set		@server = 'N''' + (select @@SERVERNAME) + ''''

EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Reinitialize subscriptions having data validation failures', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Reinitializes all subscriptions that have data validation failures.', 
		@category_name=N'REPL-Alert Response', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 19/04/08 11:38:12 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec sys.sp_MSreinit_failed_subscriptions @failure_level = 1', 
		@server= @server, 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Replication agents checkup] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Checkup] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Checkup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Checkup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Replication agents checkup', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Detects replication agents that are not logging history actively.', 
		@category_name=N'REPL-Checkup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 19/04/08 11:43:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'sys.sp_replication_agent_checkup @heartbeat_interval = 10', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190408, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'a01368d0-fc9c-4057-84f3-628aee4906ee'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/****** Object:  Job [Replication monitoring refresher for distribution_Casino.] ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Alert Response]    Script Date: 19/04/08 11:44:24 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Alert Response' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Alert Response'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Replication monitoring refresher for distribution_Casino.', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Replication monitoring refresher for distribution_Casino', 
		@category_name=N'REPL-Alert Response', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 19/04/08 11:44:24 AM ******/

declare @server nvarchar (100)
set		@server = 'N''' + (select @@SERVERNAME) + ''''

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=2147483647, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.sp_replmonitorrefreshjob  ', 
		@server= @server, 
		@database_name=N'distribution_Casino', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=64, 
		@freq_interval=0, 
		@freq_subday_type=0, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190408, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'fbaa1fe2-5b8a-49b1-b273-057f1ba63baa'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


/***** End transaction replication creation *****/

--==============================================================================================================
--==============================================================================================================


/***** END OF CREATION OF DATABASES FOR FINAL CASINO PROJECT *****/