--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test to for usp_GetLocalAuthoritiesLookupData
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/						1.1 (AWB, 12/05/2022) - additional handling of IsDeleted Flag
--/	

CREATE PROCEDURE [FHRS Tests].[test usp_GetLocalAuthoritiesLookupData]
AS
BEGIN
    SET NOCOUNT ON;

		-- Mock the Authorities table
	EXEC [tSQLt].[FakeTable] @TableName = 'FHRS.Authorities';

	INSERT INTO [FHRS].[Authorities]
           ([LocalAuthorityId]
           ,[LocalAuthorityIdCode]
           ,[Name]
		   ,[RegionName]
		   ,[IsDeleted])
     VALUES
           (6,'A6','TestAuth006','London',1),
           (5,'A5','TestAuth005','NotLondon',0),
           (4,'A4','TestAuth004','London',0),
           (3,'A3','TestAuth003','NotLondon',0),
           (2,'A2','TestAuth002','London',0),
           (1,'A1','TestAuth001','NotLondon',0);

	CREATE TABLE #expected (
		[LocalAuthorityId]     SMALLINT      NOT NULL,
		[LocalAuthorityIdCode] VARCHAR (10)  NOT NULL,
		[Name]                 VARCHAR (100) NOT NULL,
		CONSTRAINT [PK_expected] PRIMARY KEY CLUSTERED ([LocalAuthorityId] ASC)
	);

	CREATE TABLE #actual (
		[LocalAuthorityId]     SMALLINT      NOT NULL,
		[LocalAuthorityIdCode] VARCHAR (10)  NOT NULL,
		[Name]                 VARCHAR (100) NOT NULL,
		CONSTRAINT [PK_actual] PRIMARY KEY CLUSTERED ([LocalAuthorityId] ASC)
	);

	INSERT INTO #expected
           ([LocalAuthorityId]
           ,[LocalAuthorityIdCode]
           ,[Name])
     VALUES
           (2,'A2','TestAuth002'),
           (4,'A4','TestAuth004');

	INSERT INTO #actual
           ([LocalAuthorityId]
           ,[LocalAuthorityIdCode]
           ,[Name])
     EXEC [FHRS].[usp_GetLocalAuthoritiesLookupData];

	-- test assertions
	EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = '#actual', @Message = 'Lookup authorities do not match.';

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS Tests',
@level1type = N'Procedure', @level1name = 'test usp_GetLocalAuthoritiesLookupData',
@name = N'MS_Description', @value = 'Unit test to for usp_GetLocalAuthoritiesLookupData';
GO
