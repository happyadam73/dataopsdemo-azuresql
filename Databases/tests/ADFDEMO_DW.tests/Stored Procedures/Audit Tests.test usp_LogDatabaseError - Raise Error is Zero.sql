--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for Audit.usp_LogDatabaseError - check that when @raise_error = 0 then no error is raised
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		15/07/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit Tests].[test usp_LogDatabaseError - Raise Error is Zero]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @dummy_val INT;
	
	-- When setting the @raise_error flag to zero, we expect the error logging proc to not re-raise the error
	EXEC tSQLt.ExpectNoException;

	BEGIN TRY
		SELECT @dummy_val = 1/0;	-- create a divide by zero exception
	END TRY
	BEGIN CATCH
		EXEC [Audit].[usp_LogDatabaseError] @raise_error = 0;
	END CATCH

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@level1type = N'Procedure', @level1name = 'test usp_LogDatabaseError - Raise Error is Zero',
@name = N'MS_Description', @value = 'Unit test for Audit.usp_LogDatabaseError - check that when @raise_error = 0 then no error is raised';
GO
