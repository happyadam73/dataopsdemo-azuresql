--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Custom audit log handler to be used in stored procedures
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit].[usp_LogDatabaseActivity]
	@proc_id	   INT,
	@message	   NVARCHAR(MAX) = NULL,
	@rows_affected BIGINT		 = NULL,
	@category	   NVARCHAR(255) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @proc_name NVARCHAR(255) = OBJECT_SCHEMA_NAME(@proc_id) + '.' + OBJECT_NAME(@proc_id);

	-- Save Log record
	INSERT INTO [Audit].[DatabaseActivityLog] ([ActivityProc], [ActivityCategory], [ActivityMessage], [ActivityRowsAffected])
	VALUES
		(@proc_name, @category, @message, @rows_affected);
END;
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Procedure', @level1name = 'usp_LogDatabaseActivity',
@name = N'MS_Description', @value = 'Custom audit log handler to be used in stored procedures';
GO
