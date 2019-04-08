USE [Casino_Royale]
GO

/****** Object:  Index [IX_Players_Activity]    Script Date: 19/04/06 04:25:24 PM ******/
CREATE NONCLUSTERED INDEX [IX_Players_Activity] ON [dbo].[utbl_Players]
(
	[Activity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

