USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Log_documentation]    Script Date: 19/04/06 08:17:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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


