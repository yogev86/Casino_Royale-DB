USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Games_History]    Script Date: 19/04/06 08:06:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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


