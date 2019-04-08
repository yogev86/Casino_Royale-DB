USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Genders]    Script Date: 19/04/06 08:15:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a table to enter the different gender of the players
*/

DROP TABLE IF EXISTS [dbo].[utbl_Genders]
GO

CREATE TABLE [dbo].[utbl_Genders](
	[Gander_ID] [int] NOT NULL,
	[Gander_Type] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Gander_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


