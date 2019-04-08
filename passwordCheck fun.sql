USE [Casino_Royale]
GO

/****** Object:  UserDefinedFunction [dbo].[passwordCheck]    Script Date: 19/04/07 02:09:53 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE OR ALTER FUNCTION [dbo].[passwordCheck]  (@password [nvarchar](max))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Casino].[UserDefinedFunctions].[passwordCheck]
GO


