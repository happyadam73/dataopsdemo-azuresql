--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Utility stored procedure for retrieving contents of a JSON file stored in an Azure Storage account using a SAS token
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		19/06/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Utils].[usp_GetFileContentsFromBlobStorage]
	@storage_account_name	VARCHAR(24),
	@container_name			VARCHAR(64),
	@folder_name			VARCHAR(1024),
	@file_name				VARCHAR(1024),
	@sas_token				VARCHAR(200),
	@file_contents			NVARCHAR(MAX) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE 
		@sql_cmd					NVARCHAR(MAX),
		@sql_params					NVARCHAR(100) = '@file_contents NVARCHAR(MAX) OUTPUT',
		@uniquifier					VARCHAR(25),
		@credential_name			SYSNAME,
		@datasource_name			SYSNAME,
		@storage_account_location	VARCHAR(100),
		@blob_path					VARCHAR(1024);

	-- Configure uniquified names for data source and credential
	SET @uniquifier = '_' + FORMAT(SYSDATETIME(),'yyyyMMddHHmmssffff') + '_' + FORMAT(@@SPID,'#');
	SET @datasource_name = @storage_account_name + '_datasource' + @uniquifier;
	SET @credential_name = @storage_account_name + '_credential' + @uniquifier;
	SET @storage_account_location = 'https://' + @storage_account_name + '.blob.core.windows.net/' + @container_name;
	SET @blob_path = @folder_name + '/' + @file_name;

	-- Create a master key if one doesn't exist (required in order to create credentials)
	SET @sql_cmd = N'IF NOT EXISTS (SELECT * FROM sys.symmetric_keys) CREATE MASTER KEY'
	IF CAST(SERVERPROPERTY('edition') AS VARCHAR(255)) = 'SQL Azure' 
		SET @sql_cmd = @sql_cmd + ' ENCRYPTION BY PASSWORD = ''' + CAST(NEWID() AS VARCHAR(36)) + '''';
	PRINT @sql_cmd;
	EXEC sp_executesql @sql_cmd;

	-- Drop the data source if it already exists (unlikely since it's a uniquified name)
	SET @sql_cmd = N'
		IF EXISTS (SELECT * FROM sys.external_data_sources  WHERE [name] = ''' + @datasource_name + ''')
			DROP EXTERNAL DATA SOURCE ' + @datasource_name + ';
	';
	EXEC sp_executesql @sql_cmd;

	-- Drop the database scoped credential if it already exists (unlikely since it's a uniquified name)
	SET @sql_cmd = N'
		IF EXISTS (SELECT * FROM sys.database_scoped_credentials  WHERE [name] = ''' + @credential_name + ''')
			DROP DATABASE SCOPED CREDENTIAL ' + @credential_name + ';
	';
	EXEC sp_executesql @sql_cmd;

	-- Create database scoped credential using SAS token
	SET @sql_cmd = N'
		CREATE DATABASE SCOPED CREDENTIAL ' + @credential_name + '
		WITH IDENTITY = ''SHARED ACCESS SIGNATURE'',
		SECRET = ''' + @sas_token + ''';
	';
	EXEC sp_executesql @sql_cmd;

	-- Create data source for storage account using generated credentials
	SET @sql_cmd = N'
		CREATE EXTERNAL DATA SOURCE ' + @datasource_name + '
			WITH (
				TYPE = BLOB_STORAGE,
				LOCATION = ''' + @storage_account_location + ''',
				CREDENTIAL = ' + @credential_name + '
			);
	';
	EXEC sp_executesql @sql_cmd;

	-- Create the OPENROWSET query which assigns the output from the query to the @file_contents parameter
	SET @sql_cmd = N'
		SELECT @file_contents = (
			SELECT BulkColumn FROM OPENROWSET(
			   BULK ''' + @blob_path + ''',
			   DATA_SOURCE = ''' + @datasource_name + ''',
			   SINGLE_CLOB
			   ) AS FileContents
		);
	';
	EXEC sp_executesql @sql_cmd, @sql_params, @file_contents = @file_contents OUTPUT;

	-- Cleanup - drop the data source
	SET @sql_cmd = N'
		IF EXISTS (SELECT * FROM sys.external_data_sources  WHERE [name] = ''' + @datasource_name + ''')
			DROP EXTERNAL DATA SOURCE ' + @datasource_name + ';
	';
	EXEC sp_executesql @sql_cmd;

	-- Cleanup - drop the credentials
	SET @sql_cmd = N'
		IF EXISTS (SELECT * FROM sys.database_scoped_credentials  WHERE [name] = ''' + @credential_name + ''')
			DROP DATABASE SCOPED CREDENTIAL ' + @credential_name + ';
	';
	EXEC sp_executesql @sql_cmd;

END;
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Utils',
@level1type = N'Procedure', @level1name = 'usp_GetFileContentsFromBlobStorage',
@name = N'MS_Description', @value = 'Utility stored procedure for retrieving contents of a JSON file stored in an Azure Storage account using a SAS token';
GO
