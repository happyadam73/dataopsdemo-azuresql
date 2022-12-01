CREATE PROCEDURE [SQLCop].[test Fragmented Indexes]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	SET NOCOUNT ON;

	DECLARE @Output VARCHAR(MAX);

	SET @Output = '';

	CREATE TABLE #Result (ProblemItem VARCHAR(1000));

	IF EXISTS (SELECT [compatibility_level] FROM sys.databases WHERE [name] = DB_NAME() AND [compatibility_level] > 80)
		IF EXISTS (SELECT 1 FROM fn_my_permissions(NULL, 'DATABASE') WHERE permission_name = 'VIEW DATABASE STATE')
		BEGIN
			INSERT INTO #Result (ProblemItem)
			EXEC ('
                        SELECT  OBJECT_NAME(OBJECT_ID) + ''.'' + s.name As ProblemItem
                        FROM    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, N''LIMITED'') d
                                join sysindexes s
                                    ON  d.OBJECT_ID = s.id
                                    and d.index_id = s.indid
                        Where   avg_fragmentation_in_percent >= 30
                                And OBJECT_NAME(OBJECT_ID) + ''.'' + s.name > ''''
                                And page_count > 1000
                                Order By Object_Name(OBJECT_ID), s.name');
		END;
		ELSE SET @Output = 'You do not have VIEW DATABASE STATE permissions within this database';
	ELSE SET @Output = 'Unable to check index fragmentation when compatibility is set to 80 or below';

	IF @Output > ''
	BEGIN
		SET @Output = CHAR(13) + CHAR(10) + 'For more information:  ' + 'https://github.com/red-gate/SQLCop/wiki/Fragmented-indexes' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) + @Output;

		EXEC tSQLt.Fail @Output;
	END;
END;
