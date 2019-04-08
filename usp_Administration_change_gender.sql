USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Administration_change_gender]    Script Date: 19/04/06 08:33:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedure in case a player wants to 
change the gender entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_gender] 
		@Username		= 'Yogev', 
		@New_Gender		= 'Female'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_gender]
		@Username		nvarchar (10),
		@New_Gender		nvarchar (10)
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
					select 'A player must be logged in to change the gender'
					exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the gender'
				end

/*
	If the gender is valid, the database is updated
*/

		ELSE	update [dbo].[utbl_Players]
				set		[Gender]	= @New_Gender
				where	[Username]	= @Username

				select 'The gender changed successfully'
				exec usp_Log_documentation @Username = @Username, @Message = 'The gender changed successfully'
	END
GO


