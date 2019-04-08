USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Feedbacks]    Script Date: 19/04/06 07:58:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a table to enter and record players comments 
if they decide to use the option to enter a comment
*/

DROP TABLE IF EXISTS  [dbo].[utbl_Feedbacks]
GO

CREATE TABLE [dbo].[utbl_Feedbacks](
	[Username]		[nvarchar](10)		 NOT NULL,
	[Comment]		[nvarchar](max)		 NOT NULL,
	[date]			[datetime]			 NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[utbl_Feedbacks] ADD  DEFAULT (getdate()) FOR [date]
GO

ALTER TABLE [dbo].[utbl_Feedbacks]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[utbl_Players] ([Username])
GO


