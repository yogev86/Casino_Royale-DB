USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Logout]    Script Date: 19/04/07 01:16:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur in case a player wants to logout 
from the casino

Example Executing the stored procedur:

EXEC [usp_Logout] 
    		 @Username		='Yogev'
*/

CREATE OR ALTER proc [dbo].[usp_Logout]
			 @Username		nvarchar (10) 

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
				select 'A player must be logged in to be able to Logout'
				exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to be able to Logout'
			end	

/*
	Updating the database that the player has logged out
*/
	
		ELSE
			begin
					
				update utbl_Players
				set Logged = 0, Last_logout = getdate(), Activity = 0
				where Username = @Username 
				
				exec usp_Log_documentation @Username = @Username, @Message = 'The player has logged out'
			end

	END
GO


