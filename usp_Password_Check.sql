USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Password_Check]    Script Date: 19/04/07 01:26:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a stored procedur that checks the password according to the conditions of the database

Example Executing the stored procedur:

EXEC [usp_Password_Check]
				@Username		='Yogev',
				@Password		='sdfSDFD1',
				@Indicator      = 0
*/

CREATE OR ALTER proc [dbo].[usp_Password_Check]
				@Username  nvarchar (10),
				@Password  nvarchar (10),
				@Indicator int OUTPUT  
AS

	BEGIN
		
		declare @clr	   nvarchar (1)

		set	    @Indicator = 0
		set     @clr	   = (select [dbo].[passwordCheck] (@Password)) 

/*
	Check if the password contains at least one lowercase letter, one uppercase letter, one numeric digit
*/

			IF (@Password NOT LIKE '%[abcdefghijklmnopqrstuvwxyz]%' COLLATE Latin1_General_CS_AI AND 
				@Password NOT LIKE '%[ABCDEFGHIJKLMNOPQRSTUVWXYZ]%' COLLATE Latin1_General_CS_AI AND 
				@Password NOT LIKE '%[0123456789]%')
					
					begin
						select 'The password must contain at least one capital letter, one small letter and one digit'				
						set @Indicator = 1	
						exec usp_Log_documentation @Username = @Username, @Message = 'The password must contain at least one capital letter, one small letter and one digit'
					end

/*
	Check if the password is under the requested length or is similar to a username
*/

			ELSE IF (len(@Password) < (select [Value] from [dbo].[utbl_Definitions] where [Type] = 'Password length') OR
					 @Password = @Username)
					
					begin
						select 'The password must be at least 5 characters and not similar to username'
						set @Indicator = 1	
						exec usp_Log_documentation @Username = @Username, @Message = 'The password must be at least 5 characters and not similar to username'
					end

/*
	Check that the password does not contain the word password in any variation
*/

			ELSE IF (((SELECT CASE WHEN BINARY_CHECKSUM(@Password) = BINARY_CHECKSUM(LOWER(@Password)) 
					 THEN 0 
					 ELSE 1 
					 END) = 1 OR
					 (SELECT CASE WHEN BINARY_CHECKSUM(@Password) = BINARY_CHECKSUM(LOWER(@Password)) 
					 THEN 0 
					 ELSE 1 
					 END) =0) AND
					 (@Password LIKE '%password[0123456789]%' OR
			   		  @Password LIKE '%Pass[0123456789]word%' OR
					  @Password LIKE '%[0123456789]Password%'))
					 
					 begin
						select 'The password can not be the word "password" in any combination'
						set @Indicator = 1
						exec usp_Log_documentation @Username = @Username, @Message = 'The password can not be the word "password" in any combination'
					 end

/*
	Checking against the developer's DLL Does the password meet the requirement
*/

			ELSE IF (@clr = 0)
					begin 
						select 'The password is not valid'
						set @Indicator = 1
						exec usp_Log_documentation @Username = @Username, @Message = 'The password is not valid'
					end

END
GO


