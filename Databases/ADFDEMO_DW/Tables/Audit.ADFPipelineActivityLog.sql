--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Auditing log table for Azure Data Factory Pipeline activity
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/						Revision History:	1.0
--/	

CREATE TABLE [Audit].[ADFPipelineActivityLog]
(
	[ActivityLogID]				  INT			IDENTITY(1, 1) NOT NULL CONSTRAINT [PK_ADFPipelineActivityLog] PRIMARY KEY CLUSTERED,
	[DataFactoryName]			  NVARCHAR(500) NULL,
	[PipelineName]				  NVARCHAR(500) NULL,
	[PipelineRunID]				  NVARCHAR(500) NULL,
	[PipelineTriggerTime]		  DATETIME		NULL,
	[ActivityName]				  NVARCHAR(500) NULL,
	[ActivityRunID]				  NVARCHAR(500) NULL,
	[ActivityStartTime]			  DATETIME		NULL,
	[ActivityMessage]			  NVARCHAR(MAX) NULL,
	[ActivityDate]				  DATETIME		NOT NULL CONSTRAINT [DF_Audit_ADFPipelineActivityLog_ActivityDate] DEFAULT (GETDATE()),
	[CopyActivityRowsCopied]	  INT			NULL,
	[CopyActivityRowsRead]		  INT			NULL,
	[CopyActivityDurationSeconds] INT			NULL,
	[CopyActivitySourceType]	  NVARCHAR(500) NULL,
	[CopyActivitySinkType]		  NVARCHAR(500) NULL,
	[CopyActivityExecutionStatus] NVARCHAR(500) NULL,
	[CopyActivityStartTime]		  DATETIME		NULL
);
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Table', @level1name = 'ADFPipelineActivityLog',
@name = N'MS_Description', @value = 'Auditing log table for all errors raised during Azure Data Factory Pipeline activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='ActivityLogID', @name=N'MS_Description', @value='The unique id for the audit record';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='DataFactoryName', @name=N'MS_Description', @value='The name of data factory that ran the pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='PipelineName', @name=N'MS_Description', @value='The name of pipeline ran that created the audit record';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='PipelineRunID', @name=N'MS_Description', @value='The Id relating to the pipeline name';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='ActivityName', @name=N'MS_Description', @value='The name of the activity within the pipeline that created the audit record';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='ActivityRunID', @name=N'MS_Description', @value='The unique id of activity run within the given pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='ActivityStartTime', @name=N'MS_Description', @value='The date and time that activity started within the given pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='ActivityMessage', @name=N'MS_Description', @value='The activity message outputted as part of the activity within the given pipeline';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='ActivityDate', @name=N'MS_Description', @value='Date time the activity outputted the message';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='CopyActivityRowsCopied', @name=N'MS_Description', @value='The number of rows copied as part of the activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='CopyActivityRowsRead', @name=N'MS_Description', @value='The number of rows read as part of the activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='CopyActivityDurationSeconds', @name=N'MS_Description', @value='The duration of the copy activity in seconds';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='CopyActivitySourceType', @name=N'MS_Description', @value='The type of linked service for the source of the copy activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='CopyActivitySinkType', @name=N'MS_Description', @value='The type of linked service for the end sink of the copy activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='CopyActivityExecutionStatus', @name=N'MS_Description', @value='The status of the pipeline copy activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='ADFPipelineActivityLog', @level2type=N'Column', @level2name='CopyActivityStartTime', @name=N'MS_Description', @value='The date and time the copy activity started';
GO