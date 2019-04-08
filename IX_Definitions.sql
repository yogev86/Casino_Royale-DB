USE [Casino_Royale]
GO

/****** Object:  Index [IX_Definitions]    Script Date: 19/04/06 04:21:39 PM ******/
CREATE CLUSTERED INDEX [IX_Definitions] ON [dbo].[utbl_Definitions]
(
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

