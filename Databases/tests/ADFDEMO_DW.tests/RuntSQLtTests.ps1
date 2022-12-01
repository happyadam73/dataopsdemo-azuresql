<#
.SYNOPSIS
    Run tSQLt Tests Script

.DESCRIPTION
    Invokes remote SQL command on Server and Database, runs all tSQLt tests and outputs
	the response from the XML Results Formatter into an XML file (JUnit format)

.PARAMETER serverName
    Full FQDN of the Azure SQL Server instance

.PARAMETER databaseName
    Name of the Azure SQL Datatabase       

.PARAMETER accessToken
    A valid access token to be used to authenticate to SQL Server, in alternative to user/password or Windows Authentication.
    This can be used, for example, to connect to SQL Azure DB and SQL Azure Managed Instance using a Service Principal or a 
    Managed Identity

.PARAMETER outputFile
    Full file path for the output file
  
.NOTES
    Author: Adam Buckley
    Version 1.0	(2022-04-29):	Initial release

#>
Param (
    [Parameter(Mandatory=$true)]
    [System.String]
    $serverName,

    [Parameter(Mandatory=$true)]
    [System.String]
    $databaseName,

    [Parameter(Mandatory=$true)]
    [System.String]
    $accessToken,

    [Parameter(Mandatory=$true)]
    [System.String]
    $outputFile
)

$out = ""; 
Invoke-SqlCmd -ServerInstance $serverName -Database $databaseName `
                          -Query "BEGIN TRY EXEC tSQLt.RunAll END TRY BEGIN CATCH END CATCH; EXEC tSQLt.XmlResultFormatter" `
                          -AccessToken $accessToken `
                          -MaxCharLength 1000000 | %{ $out = $out + $_[0]}; 
$out > $outputFile
