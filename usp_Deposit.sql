USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Deposit]    Script Date: 19/04/07 12:13:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur in case a player wants to deposit money into the casino

Example Executing the stored procedur:

EXEC [usp_Deposit] 
			@user				='Yogev'
			@Deposit_Amount		=50,
			@Credit_Card_Number =2535235489651235,
			@Expiry_Month		='8',
			@Expiry_Year		='21'
*/

CREATE OR ALTER proc [dbo].[usp_Deposit] 
			@user				nvarchar (10),
			@Deposit_Amount		money,
			@Credit_Card_Number bigint,
			@Expiry_Month		int,
			@Expiry_Year		int
AS
	BEGIN
--		declare @user			    nvarchar (10) 
		declare @Authorized_deposit int

--		set		@user = (select SUSER_SNAME())
		set     @Authorized_deposit = (select [Value] from [dbo].[utbl_Definitions] 
									   where  [Type] = 'Deposit amount')

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
					select 'A player must be logged in to Deposit'
					exec usp_Log_documentation @Username = @user, @Message = 'A player must be logged in to Deposit'
				end	

/*
	Check whether the amount of the deposit exceeds the amount allowed for deposit
*/
	
			ELSE IF (@Deposit_Amount > @Authorized_deposit)
				begin
					select 'Deposit amount can not be more then ' + @Authorized_deposit
					exec usp_Log_documentation @Username = @user, @Message = 'deposit is not possible due to the deposit amount'
				end

/*
	Check if your credit card number and expiry date are valid
*/

			ELSE IF (len(@Credit_Card_Number) <> 16 or @Expiry_Month <= MONTH (getdate()) or @Expiry_Year < year (getdate()))
					begin
						select 'One or more of the data you entered is not valid, please re-enter correct data'
						exec usp_Log_documentation @Username = @user, @Message = 'One or more of the data you entered is not valid, please re-enter correct data'
					end
			
/*
	Updating the new credit data in the database
*/

			ELSE
					begin	
						insert into utbl_Money_Transactions 
						values (@user, 'Deposit', @Deposit_Amount, getdate()) 

						update utbl_Players
						set Activity = 1, Activity_Time = getdate()  
						where Username = @user
					
						exec usp_Log_documentation @Username = @user, @Message = 'Deposit was successful '
					end
	END
GO


