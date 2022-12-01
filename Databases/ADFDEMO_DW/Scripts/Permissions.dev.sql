--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Grant Permissions Script for AD Accounts on Dev Instance (not included as part of the build)
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

/*

DECLARE 
	@data_factory_managed_identity	SYSNAME	= 'adf-awb-cicddemo-dev',
	@sql_cmd						NVARCHAR(200);

-- Create Data Factory account (DB Owner access)
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] = @data_factory_managed_identity) 
BEGIN
	SET @sql_cmd = N'CREATE USER [' + @data_factory_managed_identity + '] FOR EXTERNAL PROVIDER;';
	EXEC sp_executesql @sql_cmd;
END
EXEC sp_addrolemember N'db_owner', @data_factory_managed_identity;
SET @sql_cmd = N'GRANT CONNECT TO [' + @data_factory_managed_identity + '];';
EXEC sp_executesql @sql_cmd;

*/
