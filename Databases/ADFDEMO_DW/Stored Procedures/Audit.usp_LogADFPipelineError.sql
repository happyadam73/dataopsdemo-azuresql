--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Custom error log handler for Azure Data Factory Pipelines
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit].[usp_LogADFPipelineError]
	@data_factory_name	   NVARCHAR(500) = NULL,
	@pipeline_name		   NVARCHAR(500) = NULL,
	@pipeline_run_id	   NVARCHAR(500) = NULL,
	@pipeline_trigger_time DATETIME		 = NULL,
	@activity_name		   NVARCHAR(500) = NULL,
	@activity_run_id	   NVARCHAR(500) = NULL,
	@activity_start_time   DATETIME		 = NULL,
	@error_message		   NVARCHAR(MAX) = NULL,
	@error_code			   VARCHAR(10)	 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [Audit].[ADFPipelineErrorLog]
	(
		[DataFactoryName],
		[PipelineName],
		[PipelineRunID],
		[PipelineTriggerTime],
		[ActivityName],
		[ActivityRunID],
		[ActivityStartTime],
		[ErrorMessage],
		[ErrorCode]
	)
	VALUES
		(
			@data_factory_name, @pipeline_name, @pipeline_run_id, @pipeline_trigger_time, @activity_name, @activity_run_id, @activity_start_time, @error_message, @error_code
		);
END;
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Procedure', @level1name = 'usp_LogADFPipelineError',
@name = N'MS_Description', @value = 'Custom error log handler for Azure Data Factory Pipelines';
GO
