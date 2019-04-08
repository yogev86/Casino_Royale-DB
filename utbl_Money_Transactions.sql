USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Money_Transactions]    Script Date: 19/04/06 08:19:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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


