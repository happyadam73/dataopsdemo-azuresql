--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for Audit.usp_LogDatabaseError - check that default call of this proc results in error
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		15/07/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit Tests].[test usp_LogDatabaseError - Default Raise Error]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @dummy_val INT;
	
	-- Default for the error logging proc is to re-raise any caught exception, so we expect this call to throw an exception
	EXEC tSQLt.ExpectException;

	BEGIN TRY
		SELECT @dummy_val = 1/0;	-- create a divide by zero exception
	END TRY
	BEGIN CATCH
		EXEC [Audit].[usp_LogDatabaseError];
	END CATCH

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@level1type = N'Procedure', @level1name = 'test usp_LogDatabaseError - Default Raise Error',
@name = N'MS_Description', @value = 'Unit test for Audit.usp_LogDatabaseError - check that default call of this proc results in error';
GO
