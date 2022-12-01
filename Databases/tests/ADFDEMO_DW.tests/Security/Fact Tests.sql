--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for all Fact based database object tSQLt Unit tests
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		16/06/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [Fact Tests]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Fact Tests',
@name = N'MS_Description', @value = 'Database Schema for all Fact based database object tSQLt Unit tests';
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Fact Tests',
@name = N'tSQLt.TestClass', @value = 1;
GO
