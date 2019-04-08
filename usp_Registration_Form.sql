USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Registration_Form]    Script Date: 19/04/07 01:54:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur for the registration form

Example Executing the stored procedur:

EXEC [usp_Registration_Form] 
			@Username			='togi',
			@Password			='sfSDF8sfs',
			@Firstname			='yogev',
			@Lastname			='cohen',
			@Address			='atlite',
			@Country			='israel',
			@Email_Address		='yogev@crtv.co.il',
			@Gender				='male',
			@Birth_Date			='11/09/1986'
*/

CREATE OR ALTER proc [dbo].[usp_Registration_Form]
			@Username			nvarchar (10),
			@Password			nvarchar (10),
			@Firstname			nvarchar (20),
			@Lastname			nvarchar (20),
			@Address			nvarchar (20),
			@Country			nvarchar (20),
			@Email_Address		nvarchar (20),
			@Gender				nvarchar (10),
			@Birth_Date			date
AS
BEGIN
	declare @Alternate_Username nvarchar (10) 
	declare @Bonus				int
	declare @Password_Check		int
	declare @Age				int

	set		@Bonus			  = (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Welcome bonus')
	set		@Age			  = (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Age limit')

	exec	usp_Password_Check @Username = @Username, @Password = @Password, @Indicator = @Password_Check output

/*
Check if the player's username exists in the system
*/

		IF EXISTS (select Username from utbl_Players where Username = @Username)
			begin
				while (@Alternate_Username = (select Username from utbl_Players where Username = @Alternate_Username))
				begin
					set	@Alternate_Username = @Username + cast((SELECT FLOOR(RAND()*(1000-0+1)+0)) as nvarchar)
				end
				select 'Username already exists, please choose a new username. Here is an alternate suggestion for the username you chose: ' + @Alternate_Username
				exec usp_Log_documentation @Username = @Username, @Message = 'Username already exists, please choose a new username.'
			end

/*
	Check whether the password is valid
*/
	
		ELSE IF (@Password_Check = 1)
				begin 
					select 'Password is invalid, please enter a valid password'
					exec usp_Log_documentation @Username = @Username, @Message = 'Password is invalid, please enter a valid password'
				end

/*
	Check if the email address is valid
*/

		ELSE IF (@Email_Address NOT LIKE '%@%.%')
				begin
					select 'The email address you entered is not valid'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered is not valid'
				end
/*
	Check whether the email address is already in the system
*/

		ELSE IF EXISTS (select [Email_Address] from [MSSQL_TemporalHistoryFor_965578478] where [Email_Address] = @Email_Address)
				begin
					select 'The email address you entered already exists in the system, please enter a new email address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address you entered already exists in the system, please enter a new email address'
				end


		ELSE IF EXISTS (select Email_Address from utbl_Players where Email_Address = @Email_Address)
				begin 
					select 'The email address already exists in the system, please enter another address'
					exec usp_Log_documentation @Username = @Username, @Message = 'The email address already exists in the system, please enter another address'
				end

/*
	Check whether the player's age meets the conditions for registering
*/

		ELSE IF ((select iif(datediff(dd, datediff(dd,getdate(), DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, GETDATE()) +1), 0)))),
				datediff(dd,@Birth_Date, DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, @Birth_Date) +1), 0))))) < 0, 
				datediff(yy,@Birth_Date,getdate())-1, datediff(yy,@Birth_Date,getdate()))) <@Age)
				begin
					select 'Registration to the site is not allowed for players under the age of ' + @Age
					exec usp_Log_documentation @Username = @Username, @Message = 'Registration was declined due to the age of registration'
				end

/*
	Create a new player according to all the parameters that the stored procedure has received
*/

		ELSE 
				begin
					insert into utbl_Players (Username,Password,First_Name,Last_Name,Address,Country,Email_Address,Gender,Birth_Date)
					values (@Username,@Password,@Firstname,@Lastname,@Address,@Country,@Email_Address,@Gender,@Birth_Date)

					insert into utbl_Money_Transactions (Username,Type,Amount)
					values (@Username,'Bonus', @Bonus)

					select 'Welcome to Casino Royale, the registration was successful. By joining the site you will received $10 bonus'

					exec usp_Log_documentation @Username = @Username, @Message = 'registration was successful'
				end
END
GO


