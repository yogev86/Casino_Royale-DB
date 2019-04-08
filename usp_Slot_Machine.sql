USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Slot_Machine]    Script Date: 19/04/07 01:43:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur that simulates the game slot machine

Example Executing the stored procedur:

EXEC [usp_Slot_Machine] 
				@Username		='Yogev'
				@Bet_Amount		=200	
*/

CREATE OR ALTER PROC [dbo].[usp_Slot_Machine] 
				@Username		nvarchar (10),
				@Bet_Amount		money
AS
	BEGIN
		declare @wheel_1		int
		declare @wheel_2		int 
		declare @wheel_3		int 
--		declare @user			nvarchar (10) 
		declare @Round			int
		declare @sum			int 


		set		@wheel_1		= (SELECT FLOOR(RAND()*(7-1)+1))
		set		@wheel_2		= (SELECT FLOOR(RAND()*(7-1)+1))
		set		@wheel_3		= (SELECT FLOOR(RAND()*(7-1)+1))
--		set		@user			= (select SUSER_SNAME()) 
		set		@Round			= (select top 1 [Round] from [utbl_Games_History] where [Game_ID] = 1
								   order by [Date] desc)
		set		@sum			= (select sum(Amount) from utbl_Money_Transactions 
								   where Username = @Username group by Username)

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

			ELSE IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @Username) = 0)
				begin
					select 'A player must be logged in to play Slot_Machine'
					exec usp_Log_documentation @Username = @Username, @Message = 'A player must be logged in to play Slot_Machine'
				end	

/*
	Check if the bet amount is not greater than the player's current amount
*/

			ELSE IF (@Bet_Amount > @sum)
				begin
					select 'Bet amount can not be more then the current bankroll amount'

					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @Username 

					exec usp_Log_documentation @Username = @Username, @Message = 'Bet amount can not be more then the current bankroll amount'
				end

/*
	The beginning of the game, check if the three wheels come out the same shape
*/

			ELSE
				begin
					 IF (@wheel_1 = @wheel_2 and @wheel_2 = @wheel_3)
						begin
							insert into utbl_Money_Transactions (Username,[Type],Amount)
							values (@Username, 'Win Slot Machine',@Bet_Amount) 
							
							IF (@Round is null)
								begin
									set @Round = 0
								end

							update utbl_Players
							set Activity = 1, Activity_Time = getdate(), Game_Play = 'Slot Machine'  
							where Username = @Username

							insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
							values (1,'Slot Machine', @Bet_Amount, @Round +1, 1, @Username)

							select 'The player won by playing Slot Machine'							
							exec usp_Log_documentation @Username = @Username, @Message = 'The player won by playing Slot Machine'
						end

					else
						begin
							insert into utbl_Money_Transactions (Username,[Type],Amount)
							values (@Username, 'Loss Slot Machine',-@Bet_Amount)

							IF (@Round is null)
								begin
									set @Round = 0
								end

							update utbl_Players
							set Activity = 1, Activity_Time = getdate(), Game_Play = 'Slot Machine'  
							where Username = @Username

							insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
							values (1,'Slot Machine', @Bet_Amount, @Round +1, 0, @Username)

							select 'The player lost by playing Slot Machine'
							exec usp_Log_documentation @Username = @Username, @Message = 'The player lost by playing Slot Machine'
									
						end
				end
END
GO


