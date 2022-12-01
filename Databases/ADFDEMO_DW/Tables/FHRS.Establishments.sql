--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Establishments with Ratings/Scores for the Food Hygiene Rating Scheme API
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE TABLE [FHRS].[Establishments]
(
	[FHRSID]					  INT			 NOT NULL CONSTRAINT [PK_FHRS_Establishments] PRIMARY KEY CLUSTERED,
	[LocationCQCID]				  VARCHAR(15)	 NULL,
	[LocalAuthorityBusinessID]	  VARCHAR(25)	 NOT NULL,
	[BusinessName]				  VARCHAR(100)	 NOT NULL,
	[BusinessType]				  VARCHAR(50)	 NOT NULL,
	[BusinessTypeID]			  SMALLINT		 NOT NULL,
	[AddressLine1]				  VARCHAR(255)	 NULL,
	[AddressLine2]				  VARCHAR(255)	 NULL,
	[AddressLine3]				  VARCHAR(255)	 NULL,
	[AddressLine4]				  VARCHAR(255)	 NULL,
	[PostCode]					  VARCHAR(8)	 NULL,
	[Phone]						  VARCHAR(20)	 NULL,
	[RatingValue]				  VARCHAR(20)	 NOT NULL,
	[RatingKey]					  VARCHAR(50)	 NOT NULL,
	[RatingDate]				  DATETIME		 NOT NULL,
	[LocalAuthorityCode]		  SMALLINT		 NOT NULL,
	[LocalAuthorityName]		  CHAR(50)		 NOT NULL,
	[LocalAuthorityWebSite]		  CHAR(100)		 NOT NULL,
	[LocalAuthorityEmailAddress]  CHAR(100)		 NOT NULL,
	[HygieneScore]				  TINYINT		 NULL,
	[StructuralScore]			  TINYINT		 NULL,
	[ConfidenceInManagementScore] TINYINT		 NULL,
	[SchemeType]				  CHAR(4)		 NOT NULL,
	[Longitude]					  DECIMAL(9, 6)	 NULL,
	[Latitude]					  DECIMAL(9, 6)	 NULL,
	[RightToReply]				  VARCHAR(255)	 NULL,
	[Distance]					  DECIMAL(11, 6) NULL,
	[NewRatingPending]			  VARCHAR(10)	 NOT NULL,
	[LinkHREF]					  VARCHAR(255)	 NOT NULL,
	[IsDeleted]					  BIT			 NOT NULL CONSTRAINT DF_FHRS_Establishments_IsDeleted DEFAULT (0),
	[RecordCreatedAt]			  DATETIME		 NOT NULL CONSTRAINT DF_FHRS_Establishments_RecordCreatedAt DEFAULT (GETDATE()),
	[RecordModifiedOn]			  DATETIME		 NULL
);
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS',
@level1type = N'Table', @level1name = 'Establishments',
@name = N'MS_Description', @value = 'Establishments with Ratings/Scores for the Food Hygiene Rating Scheme API';
GO
