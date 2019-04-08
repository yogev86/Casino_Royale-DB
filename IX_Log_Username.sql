USE [Casino_Royale]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_Log_Username]    Script Date: 19/04/06 04:23:30 PM ******/
CREATE NONCLUSTERED INDEX [IX_Log_Username] ON [dbo].[utbl_Log_documentation]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

