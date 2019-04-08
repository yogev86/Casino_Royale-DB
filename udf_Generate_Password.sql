USE [Casino_Royale]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_Generate_Password]    Script Date: 19/04/07 02:17:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a function that creates a strong password


Example Executing the function:

SELECT [dbo].[udf_Generate_Password]()

*/

CREATE OR ALTER FUNCTION [dbo].[udf_Generate_Password] ()
RETURNS nvarchar(10)
AS
	BEGIN
	  DECLARE @randInt int;
	  DECLARE @NewCharacter varchar(1) 
	  DECLARE @NewPassword varchar(10) 
 
	  SET @NewPassword=''

		  --5 random characters
		  WHILE (LEN(@NewPassword) <5)
		  BEGIN
			select @randInt=[dbo].[udf_randbetween](48,122)
			--      0-9           < = > ? @ A-Z [ \ ]                   a-z      
			IF @randInt<=57 OR (@randInt>=65 AND @randInt<=90) OR (@randInt>=97 AND @randInt<=122)
			Begin
			  select @NewCharacter=CHAR(@randInt)
			  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)
			END
		  END

		  --Ensure a lowercase
		  select @NewCharacter=CHAR([dbo].[udf_randbetween](97,122))
		  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)
  
		  --Ensure an upper case
		  select @NewCharacter=CHAR([dbo].[udf_randbetween](65,90))
		  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)
  
		  --Ensure a number
		  select @NewCharacter=CHAR([dbo].[udf_randbetween](48,57))
		  select @NewPassword=CONCAT(@NewPassword, @NewCharacter)

		  RETURN(@NewPassword);
	END;
GO


