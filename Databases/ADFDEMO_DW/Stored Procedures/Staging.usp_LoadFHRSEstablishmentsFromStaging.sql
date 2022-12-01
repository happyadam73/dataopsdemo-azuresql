--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Load the main FHRS Establishments table from the Staging table
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Staging].[usp_LoadFHRSEstablishmentsFromStaging]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

		-- Log start of proc
		EXEC [Audit].[usp_LogDatabaseActivity] @@PROCID, 'Begin Proc'

		-- Merge Staging with target
		;WITH StagingFHRSEstablishments AS (
			SELECT
				[RowId],
				[FHRSID],
				[LocalAuthorityBusinessID],
				[BusinessName],
				[BusinessType],
				[BusinessTypeID],
				[AddressLine1],
				[AddressLine2],
				[AddressLine3],
				[AddressLine4],
				[PostCode],
				[Phone],
				[RatingValue],
				[RatingKey],
				[RatingDate],
				[LocalAuthorityCode],
				[LocalAuthorityName],
				[LocalAuthorityWebSite],
				[LocalAuthorityEmailAddress],
				[HygieneScore],
				[StructuralScore],
				[ConfidenceInManagementScore],
				[SchemeType],
				[Longitude],
				[Latitude],
				[RightToReply],
				[Distance],
				[NewRatingPending],
				[LinkHREF],
				ROW_NUMBER() OVER (PARTITION BY [FHRSID] ORDER BY [RatingDate] DESC, [RatingValue] DESC) AS [RatingRecencyRanking]
			FROM [Staging].[FHRSEstablishments]
		), StagingFHRSEstablishmentsDeduped AS (
			SELECT
				[RowId],
				[FHRSID],
				[LocalAuthorityBusinessID],
				[BusinessName],
				[BusinessType],
				[BusinessTypeID],
				[AddressLine1],
				[AddressLine2],
				[AddressLine3],
				[AddressLine4],
				[PostCode],
				[Phone],
				[RatingValue],
				[RatingKey],
				[RatingDate],
				[LocalAuthorityCode],
				[LocalAuthorityName],
				[LocalAuthorityWebSite],
				[LocalAuthorityEmailAddress],
				[HygieneScore],
				[StructuralScore],
				[ConfidenceInManagementScore],
				[SchemeType],
				[Longitude],
				[Latitude],
				[RightToReply],
				[Distance],
				[NewRatingPending],
				[LinkHREF]
			FROM StagingFHRSEstablishments
			WHERE [RatingRecencyRanking] = 1
		)
		MERGE FHRS.Establishments t
			USING StagingFHRSEstablishmentsDeduped s
		ON (t.[FHRSID] = s.[FHRSID])
		WHEN MATCHED
			THEN UPDATE SET
				t.[LocalAuthorityBusinessID] = s.[LocalAuthorityBusinessID],
				t.[BusinessName] = s.[BusinessName],
				t.[BusinessType] = s.[BusinessType],
				t.[BusinessTypeID] = s.[BusinessTypeID],
				t.[AddressLine1] = s.[AddressLine1],
				t.[AddressLine2] = s.[AddressLine2],
				t.[AddressLine3] = s.[AddressLine3],
				t.[AddressLine4] = s.[AddressLine4],
				t.[PostCode] = s.[PostCode],
				t.[Phone] = s.[Phone],
				t.[RatingValue] = s.[RatingValue],
				t.[RatingKey] = s.[RatingKey],
				t.[RatingDate] = s.[RatingDate],
				t.[LocalAuthorityCode] = s.[LocalAuthorityCode],
				t.[LocalAuthorityName] = s.[LocalAuthorityName],
				t.[LocalAuthorityWebSite] = s.[LocalAuthorityWebSite],
				t.[LocalAuthorityEmailAddress] = s.[LocalAuthorityEmailAddress],
				t.[HygieneScore] = s.[HygieneScore],
				t.[StructuralScore] = s.[StructuralScore],
				t.[ConfidenceInManagementScore] = s.[ConfidenceInManagementScore],
				t.[SchemeType] = s.[SchemeType],
				t.[Longitude] = s.[Longitude],
				t.[Latitude] = s.[Latitude],
				t.[RightToReply] = s.[RightToReply],
				t.[Distance] = s.[Distance],
				t.[NewRatingPending] = s.[NewRatingPending],
				t.[LinkHREF] = s.[LinkHREF],
				t.[IsDeleted] = 0,
				t.[RecordModifiedOn] = GETDATE()
		WHEN NOT MATCHED BY TARGET
			THEN INSERT (
				[FHRSID],
				[LocalAuthorityBusinessID],
				[BusinessName],
				[BusinessType],
				[BusinessTypeID],
				[AddressLine1],
				[AddressLine2],
				[AddressLine3],
				[AddressLine4],
				[PostCode],
				[Phone],
				[RatingValue],
				[RatingKey],
				[RatingDate],
				[LocalAuthorityCode],
				[LocalAuthorityName],
				[LocalAuthorityWebSite],
				[LocalAuthorityEmailAddress],
				[HygieneScore],
				[StructuralScore],
				[ConfidenceInManagementScore],
				[SchemeType],
				[Longitude],
				[Latitude],
				[RightToReply],
				[Distance],
				[NewRatingPending],
				[LinkHREF],
				[IsDeleted],
				[RecordCreatedAt],
				[RecordModifiedOn]
			) VALUES (
				s.[FHRSID],
				s.[LocalAuthorityBusinessID],
				s.[BusinessName],
				s.[BusinessType],
				s.[BusinessTypeID],
				s.[AddressLine1],
				s.[AddressLine2],
				s.[AddressLine3],
				s.[AddressLine4],
				s.[PostCode],
				s.[Phone],
				s.[RatingValue],
				s.[RatingKey],
				s.[RatingDate],
				s.[LocalAuthorityCode],
				s.[LocalAuthorityName],
				s.[LocalAuthorityWebSite],
				s.[LocalAuthorityEmailAddress],
				s.[HygieneScore],
				s.[StructuralScore],
				s.[ConfidenceInManagementScore],
				s.[SchemeType],
				s.[Longitude],
				s.[Latitude],
				s.[RightToReply],
				s.[Distance],
				s.[NewRatingPending],
				s.[LinkHREF],
				0,
				GETDATE(),
				NULL
			)
		WHEN NOT MATCHED BY SOURCE
			THEN UPDATE SET
				t.[IsDeleted] = 1,
				t.[RecordModifiedOn] = GETDATE();

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
@level1type = N'Procedure', @level1name = 'usp_LoadFHRSEstablishmentsFromStaging',
@name = N'MS_Description', @value = 'Load the main FHRS Establishments table from the Staging table';
GO
