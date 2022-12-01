--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for all ONS database object tSQLt Unit tests
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		09/07/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [ONS Tests]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'ONS Tests',
@name = N'MS_Description', @value = 'Database Schema for all ONS database object tSQLt Unit tests';
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'ONS Tests',
@name = N'tSQLt.TestClass', @value = 1;
GO
