--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		View based wrapper of existing table to allow for better abstraction
--/				
--/						FHRS.Authorities (table location)
--/							||
--/							||==> FHRS.vw_Authorities  (existing table mapped to view)
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		13/05/2022
--/	
--/ Revision History:	1.0
--/	

CREATE VIEW [FHRS].[vw_Authorities] AS 
SELECT 
	base.[LocalAuthorityId]    	AS [LocalAuthorityId],
	base.[LocalAuthorityIdCode]	AS [LocalAuthorityIdCode],
	base.[Name]                	AS [Name],
	base.[FriendlyName]        	AS [FriendlyName],
	base.[Url]                 	AS [Url],
	base.[SchemeUrl]           	AS [SchemeUrl],
	base.[Email]               	AS [Email],
	base.[RegionName]          	AS [RegionName],
	base.[FileName]            	AS [FileName],
	base.[FileNameWelsh]       	AS [FileNameWelsh],
	base.[EstablishmentCount]  	AS [EstablishmentCount],
	base.[CreationDate]        	AS [CreationDate],
	base.[LastPublishedDate]   	AS [LastPublishedDate],
	base.[SchemeType]          	AS [SchemeType],
	base.[LinkHref]            	AS [LinkHref]
FROM 
	[FHRS].[Authorities] base
WHERE
	base.[IsDeleted] = 0
GO
 
-- View Description Extended Property
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS',
@level1type = N'View', @level1name = 'vw_Authorities',
@name = N'MS_Description', @value = 'View based wrapper of existing table to allow for better abstraction';
GO
