--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		View based wrapper of existing table to allow for better abstraction
--/				
--/						FHRS.Establishments (table location)
--/							||
--/							||==> FHRS.vw_Establishments  (existing table mapped to view)
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		13/05/2022
--/	
--/ Revision History:	1.0
--/	

CREATE VIEW [FHRS].[vw_Establishments] AS 
SELECT 
	base.[FHRSID]                     	AS [FHRSID],
	base.[LocationCQCID]				AS [LocationCQCID],
	base.[LocalAuthorityBusinessID]   	AS [LocalAuthorityBusinessID],
	base.[BusinessName]               	AS [BusinessName],
	base.[BusinessType]               	AS [BusinessType],
	base.[BusinessTypeID]             	AS [BusinessTypeID],
	base.[AddressLine1]               	AS [AddressLine1],
	base.[AddressLine2]               	AS [AddressLine2],
	base.[AddressLine3]               	AS [AddressLine3],
	base.[AddressLine4]               	AS [AddressLine4],
	base.[PostCode]                   	AS [PostCode],
	base.[Phone]                      	AS [Phone],
	base.[RatingValue]                	AS [RatingValue],
	base.[RatingKey]                  	AS [RatingKey],
	base.[RatingDate]                 	AS [RatingDate],
	base.[LocalAuthorityCode]         	AS [LocalAuthorityCode],
	base.[LocalAuthorityName]         	AS [LocalAuthorityName],
	base.[LocalAuthorityWebSite]      	AS [LocalAuthorityWebSite],
	base.[LocalAuthorityEmailAddress] 	AS [LocalAuthorityEmailAddress],
	base.[HygieneScore]               	AS [HygieneScore],
	base.[StructuralScore]            	AS [StructuralScore],
	base.[ConfidenceInManagementScore]	AS [ConfidenceInManagementScore],
	base.[SchemeType]                 	AS [SchemeType],
	base.[Longitude]                  	AS [Longitude],
	base.[Latitude]                   	AS [Latitude],
	base.[RightToReply]               	AS [RightToReply],
	base.[Distance]                   	AS [Distance],
	base.[NewRatingPending]           	AS [NewRatingPending],
	base.[LinkHREF]                   	AS [LinkHREF]
FROM 
	[FHRS].[Establishments] base
WHERE
	base.[IsDeleted] = 0
GO
 
-- View Description Extended Property
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS',
@level1type = N'View', @level1name = 'vw_Establishments',
@name = N'MS_Description', @value = 'View based wrapper of existing table to allow for better abstraction';
GO
