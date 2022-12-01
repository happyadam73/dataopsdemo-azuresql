--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Get all active Main (top level) Data Factory pipelines for performing full ADFDEMO ETL
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Config].[usp_GetActiveADFMainPipelines]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

		-- Log start of proc
		EXEC [Audit].[usp_LogDatabaseActivity] @@PROCID, 'Begin Proc'

		-- Update skipped/trigger dates in config
		UPDATE [Config].[ADFMainPipelines]
		SET [LastTriggered] = GETDATE()
		WHERE [Active] = 1;

		UPDATE [Config].[ADFMainPipelines]
		SET [LastSkipped] = GETDATE()
		WHERE [Active] = 0;

		-- Select all active pipelines, ordered by the run sequence
		SELECT [PipelineName]
		FROM [Config].[ADFMainPipelines]
		WHERE [Active] = 1
		ORDER BY [RunSequenceID];

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
@level0type	= N'Schema', @level0name = 'Config',
@level1type = N'Procedure', @level1name = 'usp_GetActiveADFMainPipelines',
@name = N'MS_Description', @value = 'Get all active Main (top level) Data Factory pipelines for performing full ADFDEMO ETL';
GO
