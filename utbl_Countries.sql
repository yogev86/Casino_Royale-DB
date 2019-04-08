USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Countries]    Script Date: 19/04/06 07:49:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create table of Countries in the tadabase
*/

DROP TABLE IF EXISTS [dbo].[utbl_Countries]
GO

CREATE TABLE [dbo].[utbl_Countries](
	[Country_ID]		[int]		   NOT NULL,
	[Country_Name]		[nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Country_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


