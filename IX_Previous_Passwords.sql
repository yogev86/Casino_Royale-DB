USE [Casino_Royale]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_Previous_Passwords]    Script Date: 19/04/06 04:25:45 PM ******/
CREATE CLUSTERED INDEX [IX_Previous_Passwords] ON [dbo].[utbl_Previous_Passwords]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

