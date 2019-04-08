USE [master]
GO

/*
	Create a program to monitor DML operations
*/

/****** Object:  Audit [Audit DML]    Script Date: 19/04/08 08:26:04 AM ******/
CREATE SERVER AUDIT [Audit DML]
TO SECURITY_LOG
WITH
(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE
	,AUDIT_GUID = 'fa85d98a-4d7b-4284-95d4-be1962706a23'
)
ALTER SERVER AUDIT [Audit DML] WITH (STATE = OFF)
GO

USE [Casino_Royale]
GO

CREATE DATABASE AUDIT SPECIFICATION [Casino_Royale DML Audi tSpecification]
FOR SERVER AUDIT [Audit DML]
ADD (DELETE ON OBJECT::[dbo].[MSSQL_TemporalHistoryFor_965578478] BY [App_User]),
ADD (INSERT ON OBJECT::[dbo].[MSSQL_TemporalHistoryFor_965578478] BY [App_User]),
ADD (UPDATE ON OBJECT::[dbo].[MSSQL_TemporalHistoryFor_965578478] BY [App_User])
WITH (STATE = ON)
GO
