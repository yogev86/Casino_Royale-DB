USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 19/04/07 12:36:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur in case a player wants to login 
into the casino

Example Executing the stored procedur:

EXEC [usp_Login] 
			@Username				='Yogev'
			@Password				='vsvSF454e',
*/

CREATE OR ALTER proc [dbo].[usp_Login]
			@Username	   nvarchar (10),
			@Password	   nvarchar (10)
as
BEGIN
	declare @Blocked	   int
	declare @logIn		   int
	declare @Email_Address nvarchar (100)

	set		@Blocked	   = (select [Value] from [utbl_Definitions] where [Type] = 'Failed login')
	set		@logIn		   = (select [Value] from [utbl_Definitions] where [Type] = 'Login sum')
	set     @Email_Address = (select [Email_Address] from [utbl_Players] where [Username] = @Username)

/*
Check if the player's username exists in the system
*/	

		IF NOT EXISTS (select [Username] from [utbl_Players] where [Username] = @Username)
				begin
					select 'The username you entered does not exist in the system'
					exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered does not exist in the system'
				end

/*
	Check that the player is not blocked in the system
*/

		ELSE IF ((select [Login_attempts] from [utbl_Players] where [Username] = @Username) = @Blocked)
				begin
					update [utbl_Players]
					set  [Blocked] = 1

					select 'The username you entered is blocked due to many login attempts'
					exec usp_Log_documentation @Username = @Username, @Message = 'The username you entered is blocked due to many login attempts'
				end

/*
	Count the number of times a player entered an incorrect password for the same username
*/
			 			
		ELSE IF (@Password != (select [Password] from [utbl_Players] where Username = @Username))
				begin
					update [utbl_Players] 
					set [Login_attempts] = [Login_attempts] + 1
					where [Username] = @Username

					select 'The password you entered does not match for this username'
					exec usp_Log_documentation @Username = @Username, @Message = 'The password you entered does not match for this username'
				end

/*
	Player login to the system
*/

		ELSE IF (@Password = (select [Password] from [utbl_Players] where Username = @Username) AND
				(select [Logged] from [utbl_Players] where [Username] = @Username) = 0)
				begin
					update [utbl_Players] 
					set [Login_attempts] = 0 , [Logged] = 1, [Last_Login_Time] = getdate()
					where [Username] = @Username

					declare @F nvarchar (20) = (select [First_Name] from [utbl_Players] where Username = @Username)
					declare @L nvarchar (20) = (select [Last_Name]  from [utbl_Players] where Username = @Username)

					select 'Welcome ' + @F + ' ' + @L + '.' ' Start playing'

					exec usp_Log_documentation @Username = @Username, @Message = 'Welcome'

/*
	Email the administrator if the number of players currently connected is 100
*/

					IF ((select sum([Logged]) from [utbl_Players]) > @logIn)
						begin
							exec msdb.dbo.sp_send_dbmail 
							@profile_name = [Casino_Royale profile],
							@recipients = @Email_Address,
							@subject = 'Number of players connected',
							@body = 'There are currently more than 100 players online'							
						end

				 end

/*
	A message a player receives if they try to connect when they are already connected
*/

		ELSE 
				select 'You already logged in'
				exec usp_Log_documentation @Username = @Username, @Message = 'You already logged in'
END
GO


