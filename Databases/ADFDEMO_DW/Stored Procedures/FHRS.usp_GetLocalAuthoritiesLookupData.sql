--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Get Local Authorities that need Establishments retrieving for (currently all London Region Establishments)
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/
	
CREATE PROCEDURE [FHRS].[usp_GetLocalAuthoritiesLookupData]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

		-- Log start of proc
		EXEC [Audit].[usp_LogDatabaseActivity] @@PROCID, 'Begin Proc'

		SELECT
			[LocalAuthorityId],
			[LocalAuthorityIdCode],
			[Name]
		FROM [FHRS].[Authorities]
		WHERE 
			[RegionName] = 'London'
		AND [IsDeleted] = 0
		ORDER BY [LocalAuthorityId];

		-- Log end of proc (success)
		EXEC [Audit].[usp_LogDatabaseActivity] @@PROCID, 'End Proc (Success)', @@ROWCOUNT

		RETURN 0;
	END TRY
	BEGIN CATCH
		-- Log error information via generic Error Handler
		EXEC [Audit].[usp_LogDatabaseError];

		-- Log end of proc (failed)
		EXEC [Audit].[usp_LogDatabaseActivity] @@PROCID, 'End Proc (Failed)'

		RETURN 1;
	END CATCH;
END;
GO
-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS',
@level1type = N'Procedure', @level1name = 'usp_GetLocalAuthoritiesLookupData',
@name = N'MS_Description', @value = 'Get Local Authorities that need Establishments retrieving for (currently all London Region Establishments)';
GO
