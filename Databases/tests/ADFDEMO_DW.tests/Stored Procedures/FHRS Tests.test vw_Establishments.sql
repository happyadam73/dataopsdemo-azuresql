--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for vw_Establishments
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		13/05/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [FHRS Tests].[test vw_Establishments]
AS
BEGIN
    SET NOCOUNT ON;

	-- Mock the Establishments table
	EXEC [tSQLt].[FakeTable] @TableName = 'FHRS.Establishments', @Defaults = 1;

	INSERT INTO [FHRS].[Establishments] ([FHRSID], [BusinessTypeID], [BusinessName], [IsDeleted])
	VALUES
		(1,101,'Establishment101',0),
		(2,102,'Establishment102',1),
		(3,103,'Establishment103',0),
		(4,104,'Establishment104',1)

	CREATE TABLE #expected
	(
		[FHRSID]					  INT			 NOT NULL PRIMARY KEY CLUSTERED,
		[BusinessName]				  VARCHAR(100)	 NOT NULL,
		[BusinessTypeID]			  SMALLINT		 NOT NULL
	);

	CREATE TABLE #actual
	(
		[FHRSID]					  INT			 NOT NULL PRIMARY KEY CLUSTERED,
		[BusinessName]				  VARCHAR(100)	 NOT NULL,
		[BusinessTypeID]			  SMALLINT		 NOT NULL
	);

	INSERT INTO #expected ([FHRSID], [BusinessTypeID], [BusinessName])
	VALUES
		(1,101,'Establishment101'),
		(3,103,'Establishment103')

	-- check the view
	INSERT INTO #actual ([FHRSID], [BusinessTypeID], [BusinessName])
	SELECT 
		[FHRSID], 
		[BusinessTypeID], 
		[BusinessName]
	FROM [FHRS].[vw_Establishments];

	-- test assertions
	EXEC tSQLt.AssertEqualsTable
		@Expected = '#expected',
		@Actual = '#actual',
		@Message = 'FHRS.vw_Establishments records are different';

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'FHRS Tests',
@level1type = N'Procedure', @level1name = 'test vw_Establishments',
@name = N'MS_Description', @value = 'Unit test for vw_Establishments';
GO
