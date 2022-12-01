--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Custom audit log handler for Azure Data Factory Pipelines
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit].[usp_LogADFPipelineActivity]
	@data_factory_name				NVARCHAR(500) = NULL,
	@pipeline_name					NVARCHAR(500) = NULL,
	@pipeline_run_id				NVARCHAR(500) = NULL,
	@pipeline_trigger_time			DATETIME	  = NULL,
	@activity_name					NVARCHAR(500) = NULL,
	@activity_run_id				NVARCHAR(500) = NULL,
	@activity_start_time			DATETIME	  = NULL,
	@activity_message				NVARCHAR(MAX) = NULL,
	@copy_activity_rows_copied		INT			  = NULL,
	@copy_activity_rows_read		INT			  = NULL,
	@copy_activity_duration_seconds INT			  = NULL,
	@copy_activity_source_type		NVARCHAR(500) = NULL,
	@copy_activity_sink_type		NVARCHAR(500) = NULL,
	@copy_activity_execution_status NVARCHAR(500) = NULL,
	@copy_activity_start_time		DATETIME	  = NULL
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [Audit].[ADFPipelineActivityLog]
	(
		[DataFactoryName],
		[PipelineName],
		[PipelineRunID],
		[PipelineTriggerTime],
		[ActivityName],
		[ActivityRunID],
		[ActivityStartTime],
		[ActivityMessage],
		[CopyActivityRowsCopied],
		[CopyActivityRowsRead],
		[CopyActivityDurationSeconds],
		[CopyActivitySourceType],
		[CopyActivitySinkType],
		[CopyActivityExecutionStatus],
		[CopyActivityStartTime]
	)
	VALUES
		(
			@data_factory_name, @pipeline_name, @pipeline_run_id, @pipeline_trigger_time, @activity_name, @activity_run_id, @activity_start_time, @activity_message, @copy_activity_rows_copied, @copy_activity_rows_read, @copy_activity_duration_seconds, @copy_activity_source_type, @copy_activity_sink_type, @copy_activity_execution_status, @copy_activity_start_time
		);
END;
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Procedure', @level1name = 'usp_LogADFPipelineActivity',
@name = N'MS_Description', @value = 'Custom audit log handler for Azure Data Factory Pipelines';
GO
