USE [Casino_Royale]
GO

/****** Object:  StoredProcedure [dbo].[usp_Log_documentation]    Script Date: 19/04/07 12:29:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Create a procedure that records the actions of the players in the database,
this procedure is in any other database procedure and is run as needed automatically

Example Executing the stored procedur:

EXEC [[usp_Feedback] 
			@@Username			='Yogev'
			@Message			='A player must be logged in to send feedback
*/

CREATE OR ALTER proc [dbo].[usp_Log_documentation]
			@Username			nvarchar (10),
			@Message			nvarchar (max)

AS
	BEGIN
		
/*
	Enter the event in a database log table
*/

		insert into [dbo].[utbl_Log_documentation]
		values (@Username, @Message, getdate())

	END
GO


