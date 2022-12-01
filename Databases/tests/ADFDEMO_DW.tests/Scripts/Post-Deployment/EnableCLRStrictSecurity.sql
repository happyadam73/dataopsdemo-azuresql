--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Post-deployment script for dev instance of the database; if this is a local/on-prem recent version of SQL (2017 and above), then re-enables CLR strict security
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/

DECLARE @sql_cmd NVARCHAR(MAX) = 'EXEC tSQLt.InstallExternalAccessKey; EXEC master.sys.sp_executesql N''GRANT UNSAFE ASSEMBLY TO [tSQLtExternalAccessKey];''; EXEC sp_configure ''clr strict security'', 1; RECONFIGURE;'
IF ((CAST(SERVERPROPERTY('ProductMajorVersion') AS TINYINT) > 13) AND SERVERPROPERTY('edition') <> 'SQL Azure') 
	EXEC sp_executesql @sql_cmd;
