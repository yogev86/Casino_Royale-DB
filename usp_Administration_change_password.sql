USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Administration_change_password]    Script Date: 19/04/06 08:59:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedure in case a player wants to 
change the password entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_password] 
			@Username					='Yogi',
			@New_Password				='DJNdkdn8'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_password]
			@Username					nvarchar (10),
			@New_Password				nvarchar (10)
AS
	BEGIN
			declare @Password_Check		int

/*
Check the new password in another procedure and get an output parameter
*/
		
			exec	usp_Password_Check @Username = @Username, @Password = @New_Password, @Indicator = @Password_Check output

/*
Check if the player's username exists in the system
*/				

				IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
						begin 
							select 'The username you entered does not exist within the system, please enter an existing username'
							exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist within the system'
						end

/* 
	Check whether a player is logged in or not 
*/			

				ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
						begin
							select 'A player must be logged in to change the password'
							exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the password'
						end

/*
Check if the new password is invalid
*/

				ELSE IF (@Password_Check =1)
						begin
							exec usp_Log_documentation @Username = @Username, @Message = 'The password is invalid'
						end

/*
	Update the new password in the database
*/

				ELSE 
						 begin 
							 update [dbo].[utbl_Players]
							 set [Password] = @New_Password
							 where [Username] = @Username

							 select 'Password changed successfully'
							 exec usp_Log_documentation @Username = @Username, @Message = 'Password changed successfully'
						 end
	END		
GO


