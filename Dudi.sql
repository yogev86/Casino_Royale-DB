USE [msdb]
GO

/****** Object:  Operator [Dudi]    Script Date: 19/04/08 11:58:22 AM ******/
EXEC msdb.dbo.sp_add_operator @name=N'Dudi', 
		@enabled=1, 
		@weekday_pager_start_time=180000, 
		@weekday_pager_end_time=235900, 
		@saturday_pager_start_time=180000, 
		@saturday_pager_end_time=115900, 
		@sunday_pager_start_time=180000, 
		@sunday_pager_end_time=115900, 
		@pager_days=127, 
		@email_address=N'dudielg@gmail.com', 
		@category_name=N'[Uncategorized]'
GO


