--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for vw_Authorities
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		13/05/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [FHRS Tests].[test vw_Authorities]
AS
BEGIN
    SET NOCOUNT ON;

	-- Mock the Authorities table
	EXEC [tSQLt].[FakeTable] @TableName = 'FHRS.Authorities', @Defaults = 1;

	INSERT INTO [FHRS].[Authorities] ([LocalAuthorityId], [LocalAuthorityIdCode], [Name], [IsDeleted])
	VALUES
		(1,101,'Authority101',0),
		(2,102,'Authority102',1),
		(3,103,'Authority103',0),
		(4,104,'Authority104',1)

	CREATE TABLE #expected
	(
		[LocalAuthorityId]	   SMALLINT		NOT NULL PRIMARY KEY CLUSTERED,
		[LocalAuthorityIdCode] VARCHAR(10)	NOT NULL,
		[Name]				   VARCHAR(100) NOT NULL
	);

	CREATE TABLE #actual
	(
		[LocalAuthorityId]	   SMALLINT		NOT NULL PRIMARY KEY CLUSTERED,
		[LocalAuthorityIdCode] VARCHAR(10)	NOT NULL,
		[Name]				   VARCHAR(100) NOT NULL
	);

	INSERT INTO #expected ([LocalAuthorityId], [LocalAuthorityIdCode], [Name])
	VALUES
		(1,101,'Authority101'),
		(3,103,'Authority103')

	-- check the view
	INSERT INTO #actual ([LocalAuthorityId], [LocalAuthorityIdCode], [Name])
	SELECT 
		[LocalAuthorityId], 
		[LocalAuthorityIdCode], 
		[Name]
	FROM [FHRS].[vw_Authorities];

	-- test assertions
	EXEC tSQLt.AssertEqualsTable
		@Expected = '#expected',
		@Actual = '#actual',
		@Message = 'FHRS.vw_Authorities records are different';

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS Tests',
@level1type = N'Procedure', @level1name = 'test vw_Authorities',
@name = N'MS_Description', @value = 'Unit test for vw_Authorities';
GO
