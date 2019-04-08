USE Casino_Royale
GO


CREATE SCHEMA RLS_SCHEMA;  
GO  

CREATE OR ALTER FUNCTION RLS_SCHEMA.udf_security_predicate(@Manager_Game_ID int)  
    RETURNS TABLE  
    WITH SCHEMABINDING  
AS  
    RETURN SELECT 1 AS fn_securitypredicate_result  
    WHERE  
        DATABASE_PRINCIPAL_ID() = DATABASE_PRINCIPAL_ID('App_User')    
        AND CAST(SESSION_CONTEXT(N'UserId') AS int) = @Manager_Game_ID;   
GO  


CREATE USER App_User WITHOUT LOGIN;   
GRANT SELECT ON utbl_Games_Managers TO App_User  
  
DENY UPDATE ON [utbl_Players]([Manager_Game_ID]) TO App_User


CREATE SECURITY POLICY RLS_SCHEMA.Player_Filter  
    ADD FILTER PREDICATE RLS_SCHEMA.udf_security_predicate(Manager_Game_ID)   
        ON [dbo].[utbl_Players],  
    ADD BLOCK PREDICATE RLS_SCHEMA.udf_security_predicate(Manager_Game_ID)   
        ON [dbo].[utbl_Players] AFTER INSERT   
    WITH (STATE = ON);  

--===============================================================================================
--Now we can filtering by selecting 
--from the players table after setting different Manager_Game_IDs in SESSION_CONTEXT. 
--In practice, the application is responsible for setting the current user ID in SESSION_CONTEXT 
--after opening a connection.
--===============================================================================================
