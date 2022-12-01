--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for Audit.usp_LogDatabaseActivity
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit Tests].[test usp_LogDatabaseActivity]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE
		@message		  NVARCHAR(100) = 'Test Message',
		@rows_affected	  INT			= 999,
		@category		  NVARCHAR(100) = 'Test Category',
		@expected_ret_val INT			= 0,
		@actual_ret_val	  INT;

	-- Mock the Error log table
	EXEC [tSQLt].[FakeTable] @TableName = 'Audit.DatabaseActivityLog', @Identity = 1, @Defaults = 1;

	-- Create expected version for comparison
	CREATE TABLE #expected
	(
		[ActivityLogID]		   INT			 IDENTITY(1, 1) NOT NULL CONSTRAINT [PK_Audit_DatabaseActivityLog] PRIMARY KEY CLUSTERED,
		[ActivityProcessID]	   SMALLINT		 NOT NULL CONSTRAINT [DF_Audit_DatabaseActivityLog_ActivityProcessID] DEFAULT (@@SPID),
		[ActivityUserName]	   NVARCHAR(256) NULL CONSTRAINT [DF_Audit_DatabaseActivityLog_ActivityUserName] DEFAULT (SUSER_SNAME()),
		[ActivityProc]		   NVARCHAR(255) NULL,
		[ActivityCategory]	   NVARCHAR(255) NULL,
		[ActivityMessage]	   NVARCHAR(MAX) NULL,
		[ActivityRowsAffected] BIGINT		 NULL,
		[ActivityDate]		   DATETIME		 NOT NULL CONSTRAINT [DF_Audit_DatabaseActivityLog_ActivityDate] DEFAULT (GETDATE())
	);

	-- populate expected values
	INSERT INTO #expected ([ActivityProc], [ActivityCategory], [ActivityMessage], [ActivityRowsAffected])
	VALUES
		('Audit Tests.test usp_LogDatabaseActivity', @category, @message, @rows_affected);

	-- call the audit handler proc to test the actual output
	EXEC @actual_ret_val = [Audit].[usp_LogDatabaseActivity] @@PROCID, @message, @rows_affected, @category;

	-- Remove time granularity - should make comparison more deterministic
	UPDATE #expected
	SET ActivityDate = DATEFROMPARTS(YEAR(ActivityDate), MONTH(ActivityDate), DAY(ActivityDate));

	UPDATE [Audit].[DatabaseActivityLog]
	SET ActivityDate = DATEFROMPARTS(YEAR(ActivityDate), MONTH(ActivityDate), DAY(ActivityDate));

	-- test assertions
	EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = 'Audit.DatabaseActivityLog', @Message = 'Activity record generated is incorrect.';
	EXEC tSQLt.AssertEquals @Expected = @expected_ret_val, @Actual = @actual_ret_val, @Message = 'Return value should be zero.'; 

END;
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@level1type = N'Procedure', @level1name = 'test usp_LogDatabaseActivity',
@name = N'MS_Description', @value = 'Unit test for Audit.usp_LogDatabaseActivity';
GO
