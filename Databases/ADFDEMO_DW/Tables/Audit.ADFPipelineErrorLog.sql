--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Auditing log table for all errors raised during Azure Data Factory Pipeline activity
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/						Revision History:	1.0
--/	

CREATE TABLE [Audit].[ADFPipelineErrorLog]
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
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Table', @level1name = 'ADFPipelineErrorLog',
@name = N'MS_Description', @value = 'Auditing log table for all errors raised during Azure Data Factory Pipeline activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='ErrorLogID', @name=N'MS_Description', @value='The unique id for the pipeline error record';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='DataFactoryName', @name=N'MS_Description', @value='The name of data factory that ran the pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='PipelineName', @name=N'MS_Description', @value='The name of pipeline ran that created the audit record';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='PipelineRunID', @name=N'MS_Description', @value='The Id relating to the pipeline name';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='PipelineTriggerTime', @name=N'MS_Description', @value='The date/time the pipeline that errored was triggered';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='ActivityName', @name=N'MS_Description', @value='The name of the activity within the pipeline that created the audit record';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='ActivityRunID', @name=N'MS_Description', @value='The unique id of activity run within the given pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='ActivityStartTime', @name=N'MS_Description', @value='The date and time that activity started within the given pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='ErrorMessage', @name=N'MS_Description', @value='The error message outputted from the failed pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='ErrorCode', @name=N'MS_Description', @value='The error code outputted from the failed pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineErrorLog', @level2type=N'Column', @level2name='ErrorDate', @name=N'MS_Description', @value='The date/time the error was outputted';
GO