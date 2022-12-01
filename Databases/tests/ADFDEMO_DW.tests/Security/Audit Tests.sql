﻿--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for all Audit database tSQLt Unit tests
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [Audit Tests]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@name = N'MS_Description', @value = 'Database Schema for all Audit database tSQLt Unit tests';
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit Tests',
@name = N'tSQLt.TestClass', @value = 1;
GO
