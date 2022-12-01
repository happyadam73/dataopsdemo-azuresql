--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Initialise FHRS Staging tables ready for ETL loading
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Staging].[usp_InitialiseFHRSLoading]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

		-- Log start of proc
		EXEC [Audit].[usp_LogDatabaseActivity] @@PROCID, 'Begin Proc'

		DELETE FROM [Staging].[FHRSAuthorities];
		DELETE FROM [Staging].[FHRSEstablishments];

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
@level0type	= N'Schema', @level0name = 'Staging',
@level1type = N'Procedure', @level1name = 'usp_InitialiseFHRSLoading',
@name = N'MS_Description', @value = 'Initialise FHRS Staging tables ready for ETL loading';
GO
