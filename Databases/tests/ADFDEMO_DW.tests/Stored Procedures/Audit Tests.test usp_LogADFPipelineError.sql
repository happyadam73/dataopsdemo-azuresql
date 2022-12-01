--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for Audit.usp_LogADFPipelineError
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/

CREATE PROCEDURE [Audit Tests].[test usp_LogADFPipelineError]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE
		@data_factory_name NVARCHAR(500) = 'Test Factory',
		@pipeline_name	   NVARCHAR(500) = 'Test Pipeline',
		@message		   NVARCHAR(100) = 'Test Message',
		@expected_ret_val  INT			 = 0,
		@actual_ret_val	   INT;

	-- Mock the Error log table
	EXEC [tSQLt].[FakeTable] @TableName = 'Audit.ADFPipelineErrorLog', @Identity = 1, @Defaults = 1;

	-- Create expected version for comparison
	CREATE TABLE #expected
	(
		[ErrorLogID]		  INT			IDENTITY(1, 1) NOT NULL CONSTRAINT [PK_ADFPipelineErrorLog] PRIMARY KEY CLUSTERED,
		[DataFactoryName]	  NVARCHAR(500) NULL,
		[PipelineName]		  NVARCHAR(500) NULL,
		[PipelineRunID]		  NVARCHAR(500) NULL,
		[PipelineTriggerTime] DATETIME		NULL,
		[ActivityName]		  NVARCHAR(500) NULL,
		[ActivityRunID]		  NVARCHAR(500) NULL,
		[ActivityStartTime]	  DATETIME		NULL,
		[ErrorMessage]		  NVARCHAR(MAX) NULL,
		[ErrorCode]			  VARCHAR(10)	NULL,
		[ErrorDate]			  DATETIME		NOT NULL CONSTRAINT [DF_Audit_ADFPipelineErrorLog_ErrorDate] DEFAULT (GETDATE())
	);

	-- populate expected values
	INSERT INTO #expected ([DataFactoryName], [PipelineName], [ErrorMessage])
	VALUES
		(@data_factory_name, @pipeline_name, @message);

	-- call the audit handler proc to test the actual output
	EXEC @actual_ret_val = [Audit].[usp_LogADFPipelineError]
		@data_factory_name = @data_factory_name,
		@pipeline_name = @pipeline_name,
		@error_message = @message;

	-- Remove time granularity - should make comparison more deterministic
	UPDATE #expected
	SET ErrorDate = DATEFROMPARTS(YEAR(ErrorDate), MONTH(ErrorDate), DAY(ErrorDate));

	UPDATE [Audit].[ADFPipelineErrorLog]
	SET ErrorDate = DATEFROMPARTS(YEAR(ErrorDate), MONTH(ErrorDate), DAY(ErrorDate));

	-- test assertions
	EXEC tSQLt.AssertEqualsTable
		@Expected = '#expected',
		@Actual = 'Audit.ADFPipelineErrorLog',
		@Message = 'Error record generated is incorrect.';

	EXEC tSQLt.AssertEquals
		@Expected = @expected_ret_val,
		@Actual = @actual_ret_val,
		@Message = 'Return value should be zero.';
END;
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@level1type = N'Procedure', @level1name = 'test usp_LogADFPipelineError',
@name = N'MS_Description', @value = 'Unit test for Audit.usp_LogADFPipelineError';
GO
