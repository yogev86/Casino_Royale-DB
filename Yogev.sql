USE [msdb]
GO

/****** Object:  Operator [Yogev]    Script Date: 19/04/08 11:58:50 AM ******/
EXEC msdb.dbo.sp_add_operator @name=N'Yogev', 
		@enabled=1, 
		@weekday_pager_start_time=0, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=110000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=0, 
		@sunday_pager_end_time=180000, 
		@pager_days=127, 
		@email_address=N'yogevc86@gmail.com', 
		@category_name=N'[Uncategorized]'
GO


