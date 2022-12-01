--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for usp_LoadFHRSEstablishmentsFromStaging
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		12/05/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Staging Tests].[test usp_LoadFHRSEstablishmentsFromStaging]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE		
		@expected_count		INT,
		@actual_count		INT,		
		@expected_ret_val	INT	= 0,
		@actual_ret_val		INT;

	-- Mock the Authorities tables
	EXEC [tSQLt].[FakeTable] @TableName = 'Staging.FHRSEstablishments', @Identity = 1, @Defaults = 1;
	EXEC [tSQLt].[FakeTable] @TableName = 'FHRS.Establishments', @Identity = 1, @Defaults = 1;

	INSERT INTO [Staging].[FHRSEstablishments] ([FHRSID], [BusinessTypeID], [BusinessName])
	VALUES
		(1,101,'InSourceButNotTarget'),
		(2,102,'MatchedInSourceAndSame'),
		(3,103,'MatchedInSourceAndDifferent'),
		(4,104,'MatchedInSourceAndDeleted'),
		(6,106,'DuplicateFHRSIDNotInTarget-a'),
		(6,106,'DuplicateFHRSIDNotInTarget-b'),
		(7,107,'DuplicateFHRSIDInTarget-a'),
		(7,107,'DuplicateFHRSIDInTarget-b');

	-- Testing cases 
	UPDATE [Staging].[FHRSEstablishments] SET RatingDate = DATEFROMPARTS(1900,1,1), RatingValue = 'AwaitingInspection' WHERE [BusinessName] = 'DuplicateFHRSIDNotInTarget-a';
	UPDATE [Staging].[FHRSEstablishments] SET RatingDate = DATEFROMPARTS(2022,1,1), RatingValue = '1' WHERE [BusinessName] = 'DuplicateFHRSIDNotInTarget-b';
	UPDATE [Staging].[FHRSEstablishments] SET RatingDate = DATEFROMPARTS(1900,1,1), RatingValue = 'AwaitingInspection' WHERE [BusinessName] = 'DuplicateFHRSIDInTarget-a';
	UPDATE [Staging].[FHRSEstablishments] SET RatingDate = DATEFROMPARTS(1900,1,1), RatingValue = 'Exempt' WHERE [BusinessName] = 'DuplicateFHRSIDInTarget-b';

	INSERT INTO [FHRS].[Establishments] ([FHRSID], [BusinessTypeID], [BusinessName], [IsDeleted], [RecordCreatedAt], [RecordModifiedOn])
	VALUES
		(2,102,'MatchedInSourceAndSame',0,DATEFROMPARTS(2022,5,1),NULL),
		(3,103,'DifferentFromSource',0,DATEFROMPARTS(2022,5,1),NULL),
		(4,104,'MatchedInSourceAndDeleted',1,DATEFROMPARTS(2022,5,1),NULL),
		(5,105,'InTargetButNotSource',0,DATEFROMPARTS(2022,5,1),NULL),
		(7,107,'RecordBasedOnSourceDuplicate',0,DATEFROMPARTS(2022,5,1),NULL);

	CREATE TABLE #expected
	(
		[FHRSID]					  INT			 NOT NULL CONSTRAINT [PK_FHRS_Establishments] PRIMARY KEY CLUSTERED,
		[BusinessName]				  VARCHAR(100)	 NOT NULL,
		[BusinessTypeID]			  SMALLINT		 NOT NULL,
		[IsDeleted]					  BIT			 NOT NULL,
		[RecordCreatedAt]			  DATETIME		 NOT NULL,
		[RecordModifiedOn]			  DATETIME		 NULL
	);

	INSERT INTO #expected ([FHRSID], [BusinessTypeID], [BusinessName], [IsDeleted], [RecordCreatedAt], [RecordModifiedOn])
	VALUES
		(1,101,'InSourceButNotTarget',0,GETDATE(),NULL),
		(2,102,'MatchedInSourceAndSame',0,DATEFROMPARTS(2022,5,1),GETDATE()),
		(3,103,'MatchedInSourceAndDifferent',0,DATEFROMPARTS(2022,5,1),GETDATE()),
		(4,104,'MatchedInSourceAndDeleted',0,DATEFROMPARTS(2022,5,1),GETDATE()),
		(5,105,'InTargetButNotSource',1,DATEFROMPARTS(2022,5,1),GETDATE()),
		(6,106,'DuplicateFHRSIDNotInTarget-b',0,GETDATE(),NULL),
		(7,107,'DuplicateFHRSIDInTarget-b',0,DATEFROMPARTS(2022,5,1),GETDATE());

	-- call the merge proc
	EXEC @actual_ret_val = [Staging].[usp_LoadFHRSEstablishmentsFromStaging];

	-- Remove time granularity - should make comparison more deterministic
	UPDATE #expected
	SET 
		[RecordCreatedAt] = DATEFROMPARTS(YEAR([RecordCreatedAt]), MONTH([RecordCreatedAt]), DAY([RecordCreatedAt])),
		[RecordModifiedOn] = DATEFROMPARTS(YEAR([RecordModifiedOn]), MONTH([RecordModifiedOn]), DAY([RecordModifiedOn]));

	UPDATE [FHRS].[Establishments]
	SET 
		[RecordCreatedAt] = DATEFROMPARTS(YEAR([RecordCreatedAt]), MONTH([RecordCreatedAt]), DAY([RecordCreatedAt])),
		[RecordModifiedOn] = DATEFROMPARTS(YEAR([RecordModifiedOn]), MONTH([RecordModifiedOn]), DAY([RecordModifiedOn]));

	-- test assertions
	EXEC tSQLt.AssertEqualsTable
		@Expected = '#expected',
		@Actual = 'FHRS.Establishments',
		@Message = 'FHRS.Establishments records are different';

	EXEC tSQLt.AssertEquals
		@Expected = @expected_ret_val,
		@Actual = @actual_ret_val,
		@Message = 'Return value should be zero.';

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Staging Tests',
@level1type = N'Procedure', @level1name = 'test usp_LoadFHRSEstablishmentsFromStaging',
@name = N'MS_Description', @value = 'Unit test for usp_LoadFHRSEstablishmentsFromStaging';
GO
