USE [Casino_Royale]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_randbetween]    Script Date: 19/04/08 08:08:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a function that accepts two parameters as numbers and returns a random number between them

Example Executing the function:

SELECT [udf_randbetween] (5,1)
*/


CREATE OR ALTER FUNCTION [dbo].[udf_randbetween] (@bottom int, @top int)
returns int
as
begin
  return (select cast(round((@top-@bottom)* RandomNumber +@bottom,0) as int) from uv_RandomNumber)
end
GO
