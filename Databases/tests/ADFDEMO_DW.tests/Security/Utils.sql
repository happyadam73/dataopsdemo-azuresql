--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for utility objects
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		19/06/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [Utils]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Utils',
@name = N'MS_Description', @value = 'Database Schema for utility objects';
GO
