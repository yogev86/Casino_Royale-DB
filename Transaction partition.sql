USE [msdb]
GO

/****** Object:  Job [Transaction partition]    Script Date: 19/04/08 11:54:11 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 19/04/08 11:54:11 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Transaction partition', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Alter partiton]    Script Date: 19/04/08 11:54:11 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Alter partiton', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [master]
GO

declare @date				 date 
declare @File_group			 nvarchar (max)  
declare @Exec_Filegroup		 nvarchar (max)  
declare @Exec_Alter			 nvarchar (max)


set	    @date				 = getdate()
set		@File_group			 = ''[Fg_''+ cast(@date as nvarchar (max)) +'']''
set		@Exec_Filegroup		 = ''ALTER DATABASE [Casino_Royale] ADD FILEGROUP '' + @File_group + 
								
								''  ALTER DATABASE [Casino_Royale] 
								ADD FILE ( 
											NAME = N''''Data_File_'' + cast(@date as nvarchar (max)) +'''''',  
											FILENAME = N''''C:\Casino_Royale\Data\Data_File_'' + cast(@date as nvarchar (max)) + ''.ndf''''''+'', 
											SIZE = 8192KB , 
											FILEGROWTH = 65536KB 
										  ) 
								TO FILEGROUP '' + @File_group

set		@Exec_Alter			 = ''ALTER PARTITION FUNCTION Every_day_fun ()  
								SPLIT RANGE ('''''' + cast(@date as nvarchar (max)) + '''''')

								ALTER PARTITION SCHEME Every_day_Scheme  
								NEXT USED '' + @File_group


	exec (@Exec_Filegroup)

USE Casino_Royale

	exec (@Exec_Alter)
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Partition time', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190405, 
		@active_end_date=99991231, 
		@active_start_time=3000, 
		@active_end_time=235959, 
		@schedule_uid=N'be35ce89-8cac-4c94-b6fe-c3a1c23c59aa'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


