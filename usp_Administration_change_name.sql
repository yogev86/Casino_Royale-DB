USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Administration_change_name]    Script Date: 19/04/06 08:57:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedure in case a player wants to 
change the names entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_name] 
			@Username		='Yogi',
			@New_Firstname	='Yogev',
			@New_Lastname	='Cohen'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_name]
			@Username		 nvarchar (10),
			@New_Firstname	 nvarchar (20),
			@New_Lastname	 nvarchar (20)
AS
	BEGIN

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
							select 'A player must be logged in to change the names'
							exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the names'
						end

/*
	Updating the first and last names in the database
*/

		ELSE
						begin
							update [dbo].[utbl_Players]
							set [First_Name] = @New_Firstname, [Last_Name] = @New_Lastname
							where  [Username]= @Username

							select 'The First name and last name changed successfully'
							exec usp_Log_documentation @Username = @Username, @Message = 'The First name and last name changed successfully'
						end
	END
GO


