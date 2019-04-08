USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Definitions]    Script Date: 19/04/06 07:55:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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


