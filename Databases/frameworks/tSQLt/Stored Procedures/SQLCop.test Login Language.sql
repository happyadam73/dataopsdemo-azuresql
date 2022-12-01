﻿
CREATE PROCEDURE [SQLCop].[test Login Language]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Declare @DefaultLanguage VarChar(100)

    Set @Output = ''

    Select  @DefaultLanguage = L.name
    From    sys.configurations C
            Inner Join sys.syslanguages L
              On C.value = L.langid
              And C.name = 'default language'

    Select  @Output = @Output + name + Char(13) + Char(10)
    From    sys.server_principals
    Where   default_language_name <> @DefaultLanguage
    Order By name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Login-language'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
