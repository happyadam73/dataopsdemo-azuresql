--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test to check FHRS objects exist
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/						1.1 (AWB, 13/05/2022) - added views
--/	

CREATE PROCEDURE [FHRS Tests].[test Objects Exist]
AS
BEGIN
    SET NOCOUNT ON;

	-- Check table exists
	EXEC tSQLt.AssertObjectExists 'FHRS.Authorities'
	EXEC tSQLt.AssertObjectExists 'FHRS.Establishments'

	-- Check stored procs exist
	EXEC tSQLt.AssertObjectExists 'FHRS.usp_GetLocalAuthoritiesLookupData'

	-- Check views exist
	EXEC tSQLt.AssertObjectExists 'FHRS.vw_Authorities'
	EXEC tSQLt.AssertObjectExists 'FHRS.vw_Establishments'

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS Tests',
@level1type = N'Procedure', @level1name = 'test Objects Exist',
@name = N'MS_Description', @value = 'Unit test to check FHRS objects exist';
GO
