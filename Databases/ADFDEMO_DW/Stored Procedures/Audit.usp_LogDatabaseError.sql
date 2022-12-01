--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Custom Error handler to be used in stored procedures
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE PROCEDURE [Audit].[usp_LogDatabaseError]
	@raise_error	BIT = 1,
	@error_proc		SYSNAME = NULL,
	@custom_error_msg NVARCHAR(MAX) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE
		@sql_cmd  NVARCHAR(MAX),
		@err_msg  NVARCHAR(MAX),
		@severity TINYINT,
		@state	  TINYINT,
		@err_no	  INT,
		@proc	  SYSNAME,
		@line_no  INT;

	-- Save Error State	       
	SELECT
		@err_msg  = ISNULL(@custom_error_msg, ERROR_MESSAGE()),
		@severity = ERROR_SEVERITY(),
		@state	  = ERROR_STATE(),
		@err_no	  = ERROR_NUMBER(),
		@line_no  = ERROR_LINE();

	IF @error_proc IS NOT NULL SET @proc = @error_proc;
	ELSE SET @proc = ERROR_PROCEDURE();

	INSERT INTO [Audit].[DatabaseErrorLog] ([ErrorMessage], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorProc], [ErrorLine], [ErrorDate])
	VALUES
		(@err_msg, @err_no, @state, @severity, @proc, @line_no, GETDATE());

	-- Optional re-raise error if required
	IF @raise_error = 1 RAISERROR(@err_msg, @severity, @state);
END;
GO

-- Extended Property for Stored Procedure Level Description
EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Audit',
@level1type = N'Procedure', @level1name = 'usp_LogDatabaseError',
@name = N'MS_Description', @value = 'Custom Error handler to be used in stored procedures';
GO
