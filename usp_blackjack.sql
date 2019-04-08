USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_blackjack]    Script Date: 19/04/06 09:02:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedure that creates the blackjack game

Example Executing the stored procedur:

EXEC [usp_blackjack] 
			@user					='Yogi',
			@Bet_Amount				=50,
			@Number_Of_Cards		=3
*/

CREATE OR ALTER proc [dbo].[usp_blackjack]
				@user				nvarchar (10),
				@Bet_Amount			money, 
				@Number_Of_Cards	int
AS
	BEGIN

		declare @counter_Player		int 
		declare @Dealer_sum		    int
		declare @b					int 
		declare @c					int  
--		declare @user				nvarchar (10) 
		declare @sum				int
		declare @Round				int

		set	    @counter_Player		= 0
		set	    @Dealer_sum			= 0
		set     @b					= 0
		set		@c					= 0 
--		set		@user				= (select SUSER_SNAME())
		set		@sum				= (select sum(Amount) from utbl_Money_Transactions 
										where Username = @user group by Username)
		set		@Round				= (select top 1 [Round] from [utbl_Games_History] where [Game_ID] = 2
										order by [Date] desc)


/* 
	Check whether a player is logged in or not 
*/			
			IF ((select [Logged] from [dbo].[utbl_Players] where [Username] = @user) = 0)
				begin
					select 'A player must be logged in to play'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to play'
				end

/* 
	Check if the bet amount is higher than the player's total money 
*/			
			ELSE IF (@Bet_Amount > @sum)
				begin
					select 'Bet amount can not be more then the current bankroll amount'
	
					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @user 

					exec usp_Log_documentation @Username = @user, @Message = 'Bet amount can not be more then the current bankroll amount'
				end

/* 
   Creating a temporary table of a deck of cards 
   Selecting a random number of cards according to the player's choice 
*/		
			ELSE
				begin
					create table #Deck_Of_Cards(
					Card_ID int not null,
					Card_Symbol nvarchar (10) not null,
					num int  not null,
					Selected int not null default (0))

					insert into #Deck_Of_Cards (Card_ID, Card_Symbol, num)
					select Card_ID, Card_Symbol, ROW_NUMBER() OVER(ORDER BY [Card_ID]) as num
					from utbl_Deck_Of_Cards	
			
					while (@counter_Player < @Number_Of_Cards)
						begin
							set @b = (SELECT TOP 1 num FROM #Deck_Of_Cards where Selected = 0 ORDER BY NEWID())
							set @c = @c + (select Card_ID from #Deck_Of_Cards where num = @b and Selected = 0)
							update #Deck_Of_Cards set Selected = 1 where num = @b
							set @counter_Player = @counter_Player + 1
						end

/* 
	The beginning of the game, 
	check if the player's cards amount is greater than 21
*/
					if (@c > 21)
						begin
							select 'Player loses'

							insert into utbl_Money_Transactions (Username,Type,Amount)
							values (@user, 'Loss blackjack',-@Bet_Amount)

							update utbl_Players
							set Activity = 1, Activity_Time = getdate(), Game_Play = 'blackjack'  
							where Username = @user

							IF (@Round is null)
								begin
									set @Round = 0
								end

							insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
							values (2,'blackjack', @Bet_Amount, @Round +1, 0, @user)

							exec usp_Log_documentation @Username = @user, @Message = 'The player lost by playing Blackjack'

						end

/* 
	The dealer pulls cards, and then checks to see if the player's cards 
	amount equal to or greater than the dealer's cardinal amount
*/
					else
						while (@c >= @Dealer_sum)
							begin
								set @b = (SELECT TOP 1 num FROM #Deck_Of_Cards where Selected = 0 ORDER BY NEWID())
								set @Dealer_sum = @Dealer_sum + (select Card_ID from #Deck_Of_Cards where num = @b and Selected = 0)
								update #Deck_Of_Cards set Selected = 1 where num = @b
							end

						if (@Dealer_sum >= @c and @Dealer_sum <22)
							begin
								print 'Player loses'

								insert into utbl_Money_Transactions (Username,Type,Amount)
								values (@user, 'Loss blackjack',-@Bet_Amount)

								update utbl_Players
								set Activity = 1, Activity_Time = getdate(), Game_Play = 'blackjack'  
								where Username = @user

								IF (@Round is null)
									begin
										set @Round = 0
									end

								insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
								values (2,'blackjack', @Bet_Amount, @Round +1, 0, @user)

								exec usp_Log_documentation @Username = @user, @Message = 'The player lost by playing Blackjack'

							end
				
						else if (@Dealer_sum >= @c and @Dealer_sum > 22)
							begin
								print 'Player Win'
						
								insert into utbl_Money_Transactions (Username,Type,Amount)
								values (@user, 'Win blackjack',@Bet_Amount) 

								update utbl_Players
								set Activity = 1, Activity_Time = getdate(), Game_Play = 'blackjack'  
								where Username = @user
					
								IF (@Round is null)
									begin
										set @Round = 0
									end

								insert into utbl_Games_History (Game_ID, Game_Name, Bet_Amount, [Round], Win, Username)
								values (2,'blackjack', @Bet_Amount, @Round +1, 1, @user)

								exec usp_Log_documentation @Username = @user, @Message = 'The player won by playing Blackjack'

							end
				END
	END
GO


