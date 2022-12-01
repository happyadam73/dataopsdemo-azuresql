--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Database Schema for all ETL Staging objects
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/

CREATE SCHEMA [Staging]
    AUTHORIZATION [dbo];
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Staging',
@name = N'MS_Description', @value = 'Database Schema for all ETL Staging objects';
GO
