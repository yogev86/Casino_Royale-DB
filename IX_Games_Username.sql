USE [Casino_Royale]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_Games_Username]    Script Date: 19/04/06 04:22:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Games_Username] ON [dbo].[utbl_Games_History]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

