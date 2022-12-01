--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Auditing log table for SQL processing activity
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/						Revision History:	1.0
--/	

CREATE TABLE [Audit].[DatabaseActivityLog]
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
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Table', @level1name = 'DatabaseActivityLog',
@name = N'MS_Description', @value = 'Auditing log table for SQL processing activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityLogID', @name=N'MS_Description', @value='The unique id for the database activity log event';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityProcessID', @name=N'MS_Description', @value='The activity process id for the specific database activity performed';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityUserName', @name=N'MS_Description', @value='The username of the person(s) that triggerred the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityProc', @name=N'MS_Description', @value='The name of the procedure that was triggerred on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityCategory', @name=N'MS_Description', @value='The category name of the procedure that was triggerred on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityMessage', @name=N'MS_Description', @value='Details of the activity message when triggerred on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityRowsAffected', @name=N'MS_Description', @value='The number of rows affected by the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseActivityLog', @level2type=N'Column', @level2name='ActivityDate', @name=N'MS_Description', @value='The data and time the database activity was triggered';
GO
