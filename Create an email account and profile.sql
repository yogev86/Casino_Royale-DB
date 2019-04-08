-- Create a Database Mail account  
EXECUTE msdb.dbo.sysmail_add_account_sp  
    @account_name = 'Casino_Royale account',  
    @email_address = 'yogevc86@gmail.com',  
    @replyto_address = 'yogevc86@gmail.com',  
    @display_name = 'yogevc86@gmail.com',  
    @mailserver_name = 'smtp.gmail.com' ,
	@port = 465 ,
	@enable_ssl = 1  
  
-- Create a Database Mail profile   
EXECUTE msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'Casino_Royale profile' 
  
-- Add the account to the profile  
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'Casino_Royale profile',  
    @account_name = 'Casino_Royale account',  
    @sequence_number =1 ;  
  
-- Grant access to the profile to all users in the msdb database   
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
    @profile_name = 'Casino_Royale profile',  
    @principal_name = 'public',  
    @is_default = 1  