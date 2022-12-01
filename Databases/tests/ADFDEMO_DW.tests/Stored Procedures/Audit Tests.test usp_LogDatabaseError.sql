--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for Audit.usp_LogDatabaseError
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit Tests].[test usp_LogDatabaseError]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE 
		@error_message		NVARCHAR(100)	= 'Test Message',
		@error_proc			SYSNAME			= 'Test Proc',
		@expected_ret_val	INT				= 0,
		@actual_ret_val		INT;

	-- Mock the Error log table
	EXEC [tSQLt].[FakeTable] @TableName = 'Audit.DatabaseErrorLog', @Identity = 1, @Defaults = 1;

	-- Create expected version for comparison
	CREATE TABLE #expected
	(
		[ErrorLogID]	INT			   IDENTITY(1, 1) NOT NULL CONSTRAINT [PK_Audit_DatabaseErrorLog] PRIMARY KEY CLUSTERED,
		[ErrorMessage]	NVARCHAR(MAX)  NULL,
		[ErrorNumber]	INT			   NULL,
		[ErrorState]	INT			   NULL,
		[ErrorSeverity] INT			   NULL,
		[ErrorProc]		NVARCHAR(1024) NULL,
		[ErrorLine]		INT			   NULL,
		[ErrorDate]		DATETIME	   NULL CONSTRAINT [DF_Audit_DatabaseErrorLog_ErrorDate] DEFAULT (GETDATE()) 
	);

	-- populate expected values
	INSERT INTO #expected ([ErrorMessage], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorProc], [ErrorLine])
	VALUES
		(@error_message, NULL, NULL, NULL, @error_proc, NULL);

	-- call the error handler proc to test the actual output
	EXEC @actual_ret_val = [Audit].[usp_LogDatabaseError] 0, @error_proc, @error_message;

	-- Remove time granularity - should make comparison more deterministic
	UPDATE #expected SET ErrorDate = DATEFROMPARTS(YEAR(ErrorDate),MONTH(ErrorDate),DAY(ErrorDate));
	UPDATE [Audit].[DatabaseErrorLog] SET ErrorDate = DATEFROMPARTS(YEAR(ErrorDate),MONTH(ErrorDate),DAY(ErrorDate));

	-- test assertions
	EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = 'Audit.DatabaseErrorLog', @Message = 'Error record generated is incorrect.';
	EXEC tSQLt.AssertEquals @Expected = @expected_ret_val, @Actual = @actual_ret_val, @Message = 'Return value should be zero.'; 

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@level1type = N'Procedure', @level1name = 'test usp_LogDatabaseError',
@name = N'MS_Description', @value = 'Unit test for Audit.usp_LogDatabaseError';
GO
