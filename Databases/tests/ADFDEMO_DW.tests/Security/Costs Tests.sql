--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for all Costs database tSQLt Unit tests
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		02/06/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [Costs Tests]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Costs Tests',
@name = N'MS_Description', @value = 'Database Schema for all Costs database tSQLt Unit tests';
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Costs Tests',
@name = N'tSQLt.TestClass', @value = 1;
GO
