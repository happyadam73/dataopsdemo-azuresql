--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Main Pre-deployment script for Developer instance of ADFDEMO_DW database 
--/						This ensure relevant CLR settings for use of tSQLt dependend on the version and on-prem/Azure version of SQL
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		19/06/2022
--/	
--/ Revision History:	1.0
--/


DECLARE @sql_cmd NVARCHAR(MAX);

SET @sql_cmd = N'EXEC sp_configure ''show advanced options'', 1; RECONFIGURE; EXEC sp_configure ''clr enabled'', 1; RECONFIGURE;'

-- Temporarily disable CLR Strict Security during deployment; this will get re-enabled in the post-deployment script
-- This also now includes Azure SQL Managed Instance
IF (CAST(SERVERPROPERTY('ProductMajorVersion') AS TINYINT) > 13) OR (SERVERPROPERTY('edition') = 'SQL Azure' AND CAST(SERVERPROPERTY('EngineEdition') AS TINYINT) = 8)
	SET @sql_cmd = @sql_cmd + N' EXEC sp_configure ''clr strict security'', 0; RECONFIGURE;'

-- The CLR settings only apply to on-premise or local deployments of SQL (not Azure SQL Database but does include Azure SQL Managed Instance)
IF (SERVERPROPERTY('edition') <> 'SQL Azure') OR (SERVERPROPERTY('edition') = 'SQL Azure' AND CAST(SERVERPROPERTY('EngineEdition') AS TINYINT) = 8) 
	EXEC sp_executesql @sql_cmd;
