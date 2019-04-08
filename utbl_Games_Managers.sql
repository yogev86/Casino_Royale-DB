USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Games_Managers]    Script Date: 19/04/06 08:09:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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


