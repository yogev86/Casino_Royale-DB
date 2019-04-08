USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Previous_Passwords]    Script Date: 19/04/06 08:23:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a table to record old player passwords
*/

DROP TABLE IF EXISTS [dbo].[utbl_Previous_Passwords]
GO

CREATE TABLE [dbo].[utbl_Previous_Passwords](
	[Username] [nvarchar](10) NOT NULL,
	[Password] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[utbl_Previous_Passwords]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO


