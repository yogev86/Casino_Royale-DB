USE [Casino_Royale]
GO

/****** Object:  Index [IX_Games_Win]    Script Date: 19/04/06 04:23:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Games_Win] ON [dbo].[utbl_Games_History]
(
	[Win] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

