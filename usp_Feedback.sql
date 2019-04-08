USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Feedback]    Script Date: 19/04/07 12:23:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur in case a player wants to send 
feedback to the casino

Example Executing the stored procedur:

EXEC [usp_Feedback] 
			@user				='Yogev'
			@Feedback			='The casino is nice',
*/

CREATE OR ALTER proc [dbo].[usp_Feedback]
			@user				nvarchar (10),
			@Feedback			nvarchar (max)
AS
	BEGIN
--		declare @user			nvarchar (10) 
	
--		set		@user			= (select SUSER_SNAME())

/*
Check if the player's username exists in the system
*/				

			IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @user)
				begin 
					select 'The username you entered does not exist within the system, please enter an existing username'
					exec usp_Log_documentation @Username = @user, @Message = 'The username you entered does not exist within the system'				
				end

/* 
	Check whether a player is logged in or not 
*/			

			ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @user) = 0)
				begin
					select 'A player must be logged in to end feedback'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to end feedback'
				end	

/*
	Enter the player's message in the database
*/

			ELSE
					insert into utbl_Feedbacks (Username, Comment)
					values (@user , @Feedback)

					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @user 

					exec usp_Log_documentation @Username = @user, @Message = 'Feedback sent successfully'
	END
GO


