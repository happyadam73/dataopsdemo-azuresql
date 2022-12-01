--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test to check Audit objects exists
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit Tests].[test Objects Exist]
AS
BEGIN
    SET NOCOUNT ON;

	-- Check table exists
	EXEC tSQLt.AssertObjectExists 'Audit.DatabaseErrorLog'
	EXEC tSQLt.AssertObjectExists 'Audit.DatabaseActivityLog'
	EXEC tSQLt.AssertObjectExists 'Audit.ADFPipelineErrorLog'
	EXEC tSQLt.AssertObjectExists 'Audit.ADFPipelineActivityLog'

	-- Check stored procs exist
	EXEC tSQLt.AssertObjectExists 'Audit.usp_LogDatabaseError'
	EXEC tSQLt.AssertObjectExists 'Audit.usp_LogDatabaseActivity'
	EXEC tSQLt.AssertObjectExists 'Audit.usp_LogADFPipelineError'
	EXEC tSQLt.AssertObjectExists 'Audit.usp_LogADFPipelineActivity'

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@level1type = N'Procedure', @level1name = 'test Objects Exist',
@name = N'MS_Description', @value = 'Unit test to check Audit objects exists';
GO
