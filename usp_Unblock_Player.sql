USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Unblock_Player]    Script Date: 19/04/07 12:59:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur if a player appeals to management to unblock the Username

Example Executing the stored procedur:

EXEC [usp_Unblock_Playe] 
				@Username		='Yogev'
*/

CREATE OR ALTER proc [dbo].[usp_Unblock_Player]
				@Username		nvarchar (10)
AS
	BEGIN
		declare @New_Password	nvarchar(10)
		declare @Email_Address	nvarchar(100) 

/*
	Use function to create a new strong password
*/
		set		@New_Password	= (SELECT [dbo].[udf_Generate_Password]())
		set		@Email_Address	= (select [Email_Address] from [utbl_Players] where [Username] = @Username)

/*
Check if the player's username exists in the system
*/				

				IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
					begin 
						select 'The username you entered does not exist within the system, please enter an existing username'
						exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'				
					end
/*
	Check if the player is connected
*/

				ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 1)
					begin
						select 'The player is connected'
						exec usp_Log_documentation @Username = @Username, @Message = 'The player is connected'
					end	

/*
	Update the player's new password in the database and send the new password to the player's email
*/

				ELSE
					begin	
						update [utbl_Players]
						set [Blocked] = 0, [Password] = @New_Password , [Login_attempts] = 0
						where [Username] = @Username

						exec msdb.dbo.sp_send_dbmail 
						@profile_name = [Casino_Royale profile],
						@recipients = @Email_Address,
						@subject = 'New password for Casino Royale',
						@body = 'Your password has changed based on your request. Your new password is in this email',
						@query = 'select [Password] from [utbl_Players] where [Username] = (SELECT TOP (1) [Username] FROM [dbo].[MSSQL_TemporalHistoryFor_965578478] order by [SysEndTime] desc)'
				
						exec usp_Log_documentation @Username = @Username, @Message = 'The player is no longer blocked and the new password has been sent to the player email'
					end
	END
GO


