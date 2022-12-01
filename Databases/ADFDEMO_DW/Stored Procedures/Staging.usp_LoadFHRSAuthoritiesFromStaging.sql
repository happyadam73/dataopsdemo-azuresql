--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Load the main FHRS Authorities table from the Staging table
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Staging].[usp_LoadFHRSAuthoritiesFromStaging]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

		-- Log start of proc
		EXEC [Audit].[usp_LogDatabaseActivity] @@PROCID, 'Begin Proc'

		-- Merge Staging with target
		MERGE FHRS.Authorities t
			USING Staging.FHRSAuthorities s
		ON (t.[LocalAuthorityId] = s.[LocalAuthorityId])
		WHEN MATCHED
			THEN UPDATE SET
				t.[LocalAuthorityIdCode] = s.[LocalAuthorityIdCode],
				t.[Name] = s.[Name],
				t.[FriendlyName] = s.[FriendlyName],
				t.[Url] = s.[Url],
				t.[SchemeUrl] = s.[SchemeUrl],
				t.[Email] = s.[Email],
				t.[RegionName] = s.[RegionName],
				t.[FileName] = s.[FileName],
				t.[FileNameWelsh] = s.[FileNameWelsh],
				t.[EstablishmentCount] = s.[EstablishmentCount],
				t.[CreationDate] = s.[CreationDate],
				t.[LastPublishedDate] = s.[LastPublishedDate],
				t.[SchemeType] = s.[SchemeType],
				t.[LinkHref] = s.[LinkHref],
				t.[IsDeleted] = 0,
				t.[RecordModifiedOn] = GETDATE()
		WHEN NOT MATCHED BY TARGET
			THEN INSERT (
					[LocalAuthorityId],
					[LocalAuthorityIdCode],
					[Name],
					[FriendlyName],
					[Url],
					[SchemeUrl],
					[Email],
					[RegionName],
					[FileName],
					[FileNameWelsh],
					[EstablishmentCount],
					[CreationDate],
					[LastPublishedDate],
					[SchemeType],
					[LinkHref],
					[IsDeleted],
					[RecordCreatedAt],
					[RecordModifiedOn]
			) VALUES (
					s.[LocalAuthorityId],
					s.[LocalAuthorityIdCode],
					s.[Name],
					s.[FriendlyName],
					s.[Url],
					s.[SchemeUrl],
					s.[Email],
					s.[RegionName],
					s.[FileName],
					s.[FileNameWelsh],
					s.[EstablishmentCount],
					s.[CreationDate],
					s.[LastPublishedDate],
					s.[SchemeType],
					s.[LinkHref],
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
@level1type = N'Procedure', @level1name = 'usp_LoadFHRSAuthoritiesFromStaging',
@name = N'MS_Description', @value = 'Load the main FHRS Authorities table from the Staging table';
GO
