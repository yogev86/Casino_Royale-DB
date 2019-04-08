USE [Casino_Royale]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_Players_Password]    Script Date: 19/04/06 04:24:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_Players_Password] ON [dbo].[utbl_Players]
(
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

