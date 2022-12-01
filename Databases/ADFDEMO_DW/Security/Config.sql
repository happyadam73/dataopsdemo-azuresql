--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for all Configuration objects
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [Config]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Config',
@name = N'MS_Description', @value = 'Database Schema for all Configuration objects';
GO
