USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Cash_Out]    Script Date: 19/04/07 12:03:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur in case a player wants to 
cash out money ftom the casino

Example Executing the stored procedur:

EXEC [usp_Cash_Out] 
				@Cash_Out_Amount	='Yogev',
				@Address			='Raanana
*/


CREATE OR ALTER proc [dbo].[usp_Cash_Out]
				@user				nvarchar (10),
	    		@Cash_Out_Amount	money,
				@Address			nvarchar (100)
AS
	BEGIN
--		declare @user				nvarchar (10) 
		declare @sum				money  

--		set		@user				= (select SUSER_SNAME())
		set		@sum				= (select sum(Amount) from utbl_Money_Transactions 
										 where Username = @user group by Username)

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

			ELSE if ((select [Logged] from [dbo].[utbl_Players] where [Username] = @user) = 0)
				begin
					select 'A player must be logged in to Cash Out'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to Cash Out'
				end


			ELSE if (@Cash_Out_Amount > @sum)
				begin	
					select 'Cash out amount can not be more then the current bankroll amount'
					exec usp_Log_documentation @Username = @user, @Message = 'Cash out amount can not be more then the current bankroll amount'
				end

			ELSE
				begin	
					insert into utbl_Money_Transactions 
					values (@user, 'Cash out', -@Cash_Out_Amount, getdate()) 
		
					update utbl_Players
					set Activity = 1, Activity_Time = getdate()  
					where Username = @user 

					exec usp_Log_documentation @Username = @user, @Message = 'Cash out was successful'
				end
	END
GO


