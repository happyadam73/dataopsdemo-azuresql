--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Staging Table for FHRS API Establishments
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE TABLE [Staging].[FHRSEstablishments]
(
	[RowId]						  INT			 IDENTITY(1, 1) NOT NULL CONSTRAINT [PK_Staging_FHRSEstablishments] PRIMARY KEY CLUSTERED,
	[FHRSID]					  INT			 NULL,
	[LocalAuthorityBusinessID]	  NVARCHAR(255)	 NULL,
	[BusinessName]				  NVARCHAR(255)	 NULL,
	[BusinessType]				  NVARCHAR(255)	 NULL,
	[BusinessTypeID]			  INT			 NULL,
	[AddressLine1]				  NVARCHAR(255)	 NULL,
	[AddressLine2]				  NVARCHAR(255)	 NULL,
	[AddressLine3]				  NVARCHAR(255)	 NULL,
	[AddressLine4]				  NVARCHAR(255)	 NULL,
	[PostCode]					  NVARCHAR(255)	 NULL,
	[Phone]						  NVARCHAR(255)	 NULL,
	[RatingValue]				  NVARCHAR(255)	 NULL,
	[RatingKey]					  NVARCHAR(255)	 NULL,
	[RatingDate]				  DATETIME		 NULL,
	[LocalAuthorityCode]		  INT			 NULL,
	[LocalAuthorityName]		  NVARCHAR(255)	 NULL,
	[LocalAuthorityWebSite]		  NVARCHAR(255)	 NULL,
	[LocalAuthorityEmailAddress]  NVARCHAR(255)	 NULL,
	[HygieneScore]				  INT			 NULL,
	[StructuralScore]			  INT			 NULL,
	[ConfidenceInManagementScore] INT			 NULL,
	[SchemeType]				  NVARCHAR(255)	 NULL,
	[Longitude]					  DECIMAL(9, 6)	 NULL,
	[Latitude]					  DECIMAL(9, 6)	 NULL,
	[RightToReply]				  NVARCHAR(255)	 NULL,
	[Distance]					  DECIMAL(11, 6) NULL,
	[NewRatingPending]			  NVARCHAR(255)	 NULL,
	[LinkHREF]					  NVARCHAR(255)	 NULL
);
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Staging',
@level1type = N'Table', @level1name = 'FHRSEstablishments',
@name = N'MS_Description', @value = 'Staging Table for FHRS API Establishments';
GO
