USE [Casino_Royale]
GO

/****** Object:  Index [IX_Money_Transactions_ID]    Script Date: 19/04/06 04:24:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Money_Transactions_ID] ON [dbo].[utbl_Money_Transactions]
(
	[Transaction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

