--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for all Capacity Tracker database tSQLt Unit tests
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		08/07/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [Capacity Tests]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Capacity Tests',
@name = N'MS_Description', @value = 'Database Schema for all Capacity Tracker tSQLt Unit tests';
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Capacity Tests',
@name = N'tSQLt.TestClass', @value = 1;
GO
