--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for usp_LoadFHRSAuthoritiesFromStaging
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		12/05/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Staging Tests].[test usp_LoadFHRSAuthoritiesFromStaging]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE		
		@expected_count		INT,
		@actual_count		INT,		
		@expected_ret_val	INT	= 0,
		@actual_ret_val		INT;

	-- Mock the Authorities tables
	EXEC [tSQLt].[FakeTable] @TableName = 'Staging.FHRSAuthorities', @Identity = 1, @Defaults = 1;
	EXEC [tSQLt].[FakeTable] @TableName = 'FHRS.Authorities', @Identity = 1, @Defaults = 1;

	INSERT INTO [Staging].[FHRSAuthorities] ([LocalAuthorityId], [LocalAuthorityIdCode], [Name])
	VALUES
		(1,101,'InSourceButNotTarget'),
		(2,102,'MatchedInSourceAndSame'),
		(3,103,'MatchedInSourceAndDifferent'),
		(4,104,'MatchedInSourceAndDeleted')

	INSERT INTO [FHRS].[Authorities] ([LocalAuthorityId], [LocalAuthorityIdCode], [Name], [IsDeleted], [RecordCreatedAt], [RecordModifiedOn])
	VALUES
		(2,102,'MatchedInSourceAndSame',0,DATEFROMPARTS(2022,5,1),NULL),
		(3,103,'DifferentFromSource',0,DATEFROMPARTS(2022,5,1),NULL),
		(4,104,'MatchedInSourceAndDeleted',1,DATEFROMPARTS(2022,5,1),NULL),
		(5,105,'InTargetButNotSource',0,DATEFROMPARTS(2022,5,1),NULL)

	CREATE TABLE #expected
	(
		[LocalAuthorityId]	   SMALLINT		NOT NULL CONSTRAINT [PK_FHRS_Authorities] PRIMARY KEY CLUSTERED,
		[LocalAuthorityIdCode] VARCHAR(10)	NOT NULL,
		[Name]				   VARCHAR(100) NOT NULL,
		[IsDeleted]			   BIT			NOT NULL,
		[RecordCreatedAt]	   DATETIME		NOT NULL,
		[RecordModifiedOn]	   DATETIME		NULL
	);

	INSERT INTO #expected ([LocalAuthorityId], [LocalAuthorityIdCode], [Name], [IsDeleted], [RecordCreatedAt], [RecordModifiedOn])
	VALUES
		(1,101,'InSourceButNotTarget',0,GETDATE(),NULL),
		(2,102,'MatchedInSourceAndSame',0,DATEFROMPARTS(2022,5,1),GETDATE()),
		(3,103,'MatchedInSourceAndDifferent',0,DATEFROMPARTS(2022,5,1),GETDATE()),
		(4,104,'MatchedInSourceAndDeleted',0,DATEFROMPARTS(2022,5,1),GETDATE()),
		(5,105,'InTargetButNotSource',1,DATEFROMPARTS(2022,5,1),GETDATE())

	-- call the merge proc
	EXEC @actual_ret_val = [Staging].[usp_LoadFHRSAuthoritiesFromStaging];

	-- Remove time granularity - should make comparison more deterministic
	UPDATE #expected
	SET 
		[RecordCreatedAt] = DATEFROMPARTS(YEAR([RecordCreatedAt]), MONTH([RecordCreatedAt]), DAY([RecordCreatedAt])),
		[RecordModifiedOn] = DATEFROMPARTS(YEAR([RecordModifiedOn]), MONTH([RecordModifiedOn]), DAY([RecordModifiedOn]));

	UPDATE [FHRS].[Authorities]
	SET 
		[RecordCreatedAt] = DATEFROMPARTS(YEAR([RecordCreatedAt]), MONTH([RecordCreatedAt]), DAY([RecordCreatedAt])),
		[RecordModifiedOn] = DATEFROMPARTS(YEAR([RecordModifiedOn]), MONTH([RecordModifiedOn]), DAY([RecordModifiedOn]));

	-- test assertions
	EXEC tSQLt.AssertEqualsTable
		@Expected = '#expected',
		@Actual = 'FHRS.Authorities',
		@Message = 'FHRS.Authorities records are different';

	EXEC tSQLt.AssertEquals
		@Expected = @expected_ret_val,
		@Actual = @actual_ret_val,
		@Message = 'Return value should be zero.';

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Staging Tests',
@level1type = N'Procedure', @level1name = 'test usp_LoadFHRSAuthoritiesFromStaging',
@name = N'MS_Description', @value = 'Unit test for usp_LoadFHRSAuthoritiesFromStaging';
GO
