USE [Casino_Royale]
GO

/****** Object:  Index [IX_Every_day_index]    Script Date: 19/04/06 04:23:51 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Every_day_index] ON [dbo].[utbl_Money_Transactions]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

