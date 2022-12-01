--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Auditing log table for all errors raised using the common error handler
--/	
--/ Author:			Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/				Revision History:	1.0
--/	

CREATE TABLE [Audit].[DatabaseErrorLog]
(
	[ErrorLogID]	INT			   IDENTITY(1, 1) NOT NULL CONSTRAINT [PK_Audit_DatabaseErrorLog] PRIMARY KEY CLUSTERED,
	[ErrorMessage]	NVARCHAR(MAX)  NULL,
	[ErrorNumber]	INT			   NULL,
	[ErrorState]	INT			   NULL,
	[ErrorSeverity] INT			   NULL,
	[ErrorProc]		NVARCHAR(1024) NULL,
	[ErrorLine]		INT			   NULL,
	[ErrorDate]		DATETIME	   NOT NULL CONSTRAINT [DF_Audit_DatabaseErrorLog_ErrorDate] DEFAULT (GETDATE()) 
);
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Table', @level1name = 'DatabaseErrorLog',
@name = N'MS_Description', @value = 'Auditing log table for all errors raised using the common error handler';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorLogID', @name=N'MS_Description', @value='The Id of the error logged on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorMessage', @name=N'MS_Description', @value='Details of the error message recorded when the error was logged on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorNumber', @name=N'MS_Description', @value='The error number recorded when the error was logged on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorState', @name=N'MS_Description', @value='The current state of the database error logged on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorSeverity', @name=N'MS_Description', @value='The severity of the database error logged on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorProc', @name=N'MS_Description', @value='The name of the procedure that was triggerred when the database error was logged on the database activity';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorLine', @name=N'MS_Description', @value='What line in the procedure errored causing the database error to be logged';
GO

EXEC sp_addextendedproperty @level0type=N'Schema', @level0name='Audit', @level1type=N'Table', @level1name='DatabaseErrorLog', @level2type=N'Column', @level2name='ErrorDate', @name=N'MS_Description', @value='The data and time the database error was logged';
GO

