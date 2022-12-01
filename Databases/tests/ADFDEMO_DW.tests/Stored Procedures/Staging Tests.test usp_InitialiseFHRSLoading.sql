--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Unit test for usp_InitialiseFHRSLoading
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Staging Tests].[test usp_InitialiseFHRSLoading]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE		
		@expected_count		INT,
		@actual_count		INT,		
		@expected_ret_val	INT	= 0,
		@actual_ret_val		INT;

	-- Mock the Authorities table
	EXEC [tSQLt].[FakeTable] @TableName = 'Staging.FHRSAuthorities';
	EXEC [tSQLt].[FakeTable] @TableName = 'Staging.FHRSEstablishments';

	INSERT INTO [Staging].[FHRSAuthorities] ([LocalAuthorityId])
	VALUES
		(0),(1),(2);

	INSERT INTO [Staging].[FHRSEstablishments] ([FHRSID])
	VALUES
		(0),(1),(2);

	SET @expected_count = 3;
	SELECT @actual_count = COUNT(*) FROM [Staging].[FHRSAuthorities];
	EXEC tSQLt.AssertEquals @Expected = @expected_count, @Actual = @actual_count, @Message = 'Step 1: Expected count incorrect'; 

	SET @expected_count = 3;
	SELECT @actual_count = COUNT(*) FROM [Staging].[FHRSEstablishments];
	EXEC tSQLt.AssertEquals @Expected = @expected_count, @Actual = @actual_count, @Message = 'Step 2: Expected count incorrect'; 

	EXEC @actual_ret_val =[Staging].[usp_InitialiseFHRSLoading];
	EXEC tSQLt.AssertEquals @Expected = @expected_ret_val, @Actual = @actual_ret_val, @Message = 'Return value should be zero.'; 

	SET @expected_count = 0;
	SELECT @actual_count = COUNT(*) FROM [Staging].[FHRSAuthorities];
	EXEC tSQLt.AssertEquals @Expected = @expected_count, @Actual = @actual_count, @Message = 'Step 3: Expected count incorrect'; 

	SET @expected_count = 0;
	SELECT @actual_count = COUNT(*) FROM [Staging].[FHRSEstablishments];
	EXEC tSQLt.AssertEquals @Expected = @expected_count, @Actual = @actual_count, @Message = 'Step 4: Expected count incorrect'; 

END
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Staging Tests',
@level1type = N'Procedure', @level1name = 'test usp_InitialiseFHRSLoading',
@name = N'MS_Description', @value = 'Unit test for usp_InitialiseFHRSLoading';
GO
