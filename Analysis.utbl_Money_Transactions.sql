USE [Casino_Royale]
GO

/****** Object:  Table [Analysis].[utbl_Money_Transactions]    Script Date: 19/04/06 07:41:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



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


