USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Games]    Script Date: 19/04/06 08:01:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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


