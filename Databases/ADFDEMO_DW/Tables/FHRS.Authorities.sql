--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Local Authorities for the Food Hygiene Rating Scheme API
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE TABLE [FHRS].[Authorities]
(
	[LocalAuthorityId]	   SMALLINT		NOT NULL CONSTRAINT [PK_FHRS_Authorities] PRIMARY KEY CLUSTERED,
	[LocalAuthorityIdCode] VARCHAR(10)	NOT NULL,
	[Name]				   VARCHAR(100) NOT NULL,
	[FriendlyName]		   VARCHAR(100) NOT NULL,
	[Url]				   VARCHAR(200) NULL,
	[SchemeUrl]			   VARCHAR(200) NULL,
	[Email]				   VARCHAR(100) NULL,
	[RegionName]		   VARCHAR(50)	NOT NULL,
	[FileName]			   VARCHAR(200) NOT NULL,
	[FileNameWelsh]		   VARCHAR(200) NULL,
	[EstablishmentCount]   SMALLINT		NOT NULL,
	[CreationDate]		   DATETIME		NOT NULL,
	[LastPublishedDate]	   DATETIME		NOT NULL,
	[SchemeType]		   TINYINT		NOT NULL,
	[LinkHref]			   VARCHAR(200) NOT NULL,
	[IsDeleted]			   BIT			NOT NULL CONSTRAINT DF_FHRS_Authorities_IsDeleted DEFAULT (0),
	[RecordCreatedAt]	   DATETIME		NOT NULL CONSTRAINT DF_FHRS_Authorities_RecordCreatedAt DEFAULT (GETDATE()),
	[RecordModifiedOn]	   DATETIME		NULL
);
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS',
@level1type = N'Table', @level1name = 'Authorities',
@name = N'MS_Description', @value = 'Local Authorities for the Food Hygiene Rating Scheme API';
GO
