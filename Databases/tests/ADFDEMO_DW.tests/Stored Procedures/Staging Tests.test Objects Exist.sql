--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test to check Staging objects exist
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		12/06/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Staging Tests].[test Objects Exist]
AS
BEGIN
    SET NOCOUNT ON;

	-- Check table exists
	EXEC tSQLt.AssertObjectExists 'Staging.FHRSAuthorities'
	EXEC tSQLt.AssertObjectExists 'Staging.FHRSEstablishments'

	-- Check stored procs exist
	EXEC tSQLt.AssertObjectExists 'Staging.usp_InitialiseFHRSLoading'
	EXEC tSQLt.AssertObjectExists 'Staging.usp_LoadFHRSAuthoritiesFromStaging'
	EXEC tSQLt.AssertObjectExists 'Staging.usp_LoadFHRSEstablishmentsFromStaging'

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Staging Tests',
@level1type = N'Procedure', @level1name = 'test Objects Exist',
@name = N'MS_Description', @value = 'Unit test to check Staging objects exist';
GO
