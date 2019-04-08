USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Administration_change_email]    Script Date: 19/04/06 08:50:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedure in case a player wants to 
change the email address entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_email] 
			@Username				='Yogev',
			@New_Email_Address		='yogevc86@gmail.com'
			
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_email]
			@Username				nvarchar (10),
			@New_Email_Address		nvarchar (100)
AS
	BEGIN

/*
Check if the player's username exists in the system
*/				

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @Username, @Message =  'The username you entered does not exist within the system'			
				end

/* 
	Check whether a player is logged in or not 
*/			

		ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
				begin
					select 'A player must be logged in to change the email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the email address'
				end

/* 
Check whether the new email address meets the requirements of the database
*/

		ELSE IF (@New_Email_Address NOT LIKE '%@%.%')
				begin
					select 'The email address you entered is not valid, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered is not valid'
				end

/*
	Check if the email address already exists in the database
*/

		ELSE IF EXISTS (select Email_Address from utbl_Players where Email_Address = @New_Email_Address)
				begin 
					select 'The email address you entered already exists in the system, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered already exists in the system'
				end

		ELSE IF EXISTS (select [Email_Address] from [MSSQL_TemporalHistoryFor_965578478] where [Email_Address] = @New_Email_Address)
				begin
					select 'The email address you entered already exists in the system, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered already exists in the system'
				end

/*
	If the email address is valid, the database is updated
*/

		ELSE			
				begin
					update [dbo].[utbl_Players]
					set [Email_Address] = @New_Email_Address
					where  [Username]= @Username

					select 'The email address changed successfully'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address changed successfully'
				end
	END
GO


