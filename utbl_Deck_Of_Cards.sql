USE [Casino_Royale]
GO

/****** Object:  Table [dbo].[utbl_Deck_Of_Cards]    Script Date: 19/04/06 07:52:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a table that simulates a deck of cards for playing blackjack
*/

DROP TABLE IF EXISTS [dbo].[utbl_Deck_Of_Cards]
GO

CREATE TABLE [dbo].[utbl_Deck_Of_Cards](
	[Card_ID]		 [int]				NOT NULL,
	[Card_Symbol]	 [nvarchar](10)		NOT NULL,
	[num]			 [int]				NOT NULL,
	[Selected]		 [int]				NULL,
PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


