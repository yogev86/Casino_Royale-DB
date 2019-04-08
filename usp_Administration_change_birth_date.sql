USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Administration_change_birth_date]    Script Date: 19/04/06 08:48:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedure in case a player wants to 
change the birth date entered in the registration form

Example Executing the stored procedur:

EXEC [usp_Administration_change_birth_date] 
				@Username		='Yogev',
				@New_Birth_date	='11.09.1986'
			
*/

CREATE OR ALTER proc [dbo].[usp_Administration_change_birth_date]
				@Username		nvarchar (10),
				@New_Birth_date	date
AS
	BEGIN
		declare	@Age			int

		set		@Age			= (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Age limit') 

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
						select 'A player must be logged in to change the birth date'
						exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to change the birth date'
					end


/*
	Check whether the new age birth date meets the database conditions
*/
				ELSE IF ((select iif(datediff(dd, datediff(dd,getdate(), DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, GETDATE()) +1), 0)))),
						 datediff(dd,@New_Birth_date, DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, @New_Birth_date) +1), 0))))) < 0, 
						 datediff(yy,@New_Birth_date,getdate())-1, datediff(yy,@New_Birth_date,getdate()))) <@Age)
						begin
							select 'Players can not be under the age of ' + @Age
							exec usp_Log_documentation @Username = @Username, @Message = 'Registration was declined due to the age of registration'
						end

/* 
	Update the new birth date in the database
*/
				ELSE 
						update [dbo].[utbl_Players]
						set [Birth_Date] = @New_Birth_date
						where  [Username]= @Username

						select 'The birth date changed successfully'
						exec usp_Log_documentation @Username = @Username, @Message = 'The birth date changed successfully'
			END
	END
GO


