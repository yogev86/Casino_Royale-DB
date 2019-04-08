USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Players]    Script Date: 19/04/06 08:25:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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
	[SysStartTime]		[datetime2](0)		GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime]		[datetime2](0)		GENERATED ALWAYS AS ROW END NOT NULL,
	[Manager_Game_ID]	[int] NULL,
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


