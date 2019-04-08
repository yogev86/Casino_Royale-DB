USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Administration_change_address]    Script Date: 19/04/06 08:45:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur in case a player wants to 
change the address entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_address] 
			@Username		='Yogev',
			@New_Address	='Raanana',
			@New_Country	='Israel'
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_address]
			@Username		nvarchar (10),
			@New_Address	nvarchar (100),
			@New_Country	nvarchar (20)
as
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
							select 'A player must be logged in to change the address'
							exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the address'
						end


		ELSE
						begin
							update [dbo].[utbl_Players]
							set [Address] = @New_Address, [Country] = @New_Country
							where  [Username]= @Username

							select 'The Address and country changed successfully'
							exec usp_Log_documentation @Username = @Username, @Message = 'The Address and country changed successfully'

						end
	END
GO


