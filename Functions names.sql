Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'Functions names_ObjectSet_1', @facet=N'UserDefinedFunction', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'Functions names_ObjectSet_1', @type_skeleton=N'Server/Database/UserDefinedFunction', @type=N'FUNCTION', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/UserDefinedFunction', @level_name=N'UserDefinedFunction', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'Casino_Royale DB', @target_set_level_id=0


GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'Functions names', @condition_name=N'Check functions names', @policy_category=N'', @description=N'', @help_text=N'', @help_link=N'', @schedule_uid=N'04c375cc-19ce-43c9-9fb9-94abaa55aee3', @execution_mode=4, @is_enabled=True, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'Functions names_ObjectSet_1'
Select @policy_id


GO

