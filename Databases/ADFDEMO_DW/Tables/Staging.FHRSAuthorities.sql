--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Staging Table for FHRS API Local Authorities
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE TABLE [Staging].[FHRSAuthorities]
(
	[RowId]				   INT			 IDENTITY(1, 1) NOT NULL CONSTRAINT [PK_Staging_FHRSAuthorities] PRIMARY KEY CLUSTERED,
	[LocalAuthorityId]	   INT			 NULL,
	[LocalAuthorityIdCode] INT			 NULL,
	[Name]				   NVARCHAR(255) NULL,
	[FriendlyName]		   NVARCHAR(255) NULL,
	[Url]				   NVARCHAR(255) NULL,
	[SchemeUrl]			   NVARCHAR(255) NULL,
	[Email]				   NVARCHAR(255) NULL,
	[RegionName]		   NVARCHAR(255) NULL,
	[FileName]			   NVARCHAR(255) NULL,
	[FileNameWelsh]		   NVARCHAR(255) NULL,
	[EstablishmentCount]   INT			 NULL,
	[CreationDate]		   DATETIME		 NULL,
	[LastPublishedDate]	   DATETIME		 NULL,
	[SchemeType]		   INT			 NULL,
	[LinkHref]			   NVARCHAR(255) NULL
);
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Staging',
@level1type = N'Table', @level1name = 'FHRSAuthorities',
@name = N'MS_Description', @value = 'Staging Table for FHRS API Local Authorities';
GO
