<#
.SYNOPSIS
    Create and assign AAD based SQL Database principals through a service principal access token

.PARAMETER sqlAccessToken
    Access Token for Azure SQL (this will be for the CICD Service Principal calling this script)

.PARAMETER principalName
    Name of AAD User/Group Principal      

.PARAMETER databaseServer
    Full FQDN Azure SQL Server name

.PARAMETER databaseName
    Name of Azure SQL database

.PARAMETER databaseRole
    Name of database role to assign membership to, i.e. db_owner, db_datareader, db_datawriter
  
.NOTES
    Author: Adam Buckley
    Version 1.0	(2022-05-07):	Initial release

#>
Param (
    [Parameter(Mandatory=$true)]
    [System.String]
    $sqlAccessToken,

    [Parameter(Mandatory=$true)]
    [System.String]
    $principalObjectName,

    [Parameter(Mandatory=$true)]
    [System.String]
    $databaseServer,

    [Parameter(Mandatory=$true)]
    [System.String]
    $databaseName,

    [Parameter(Mandatory=$true)]
    [System.String]
    $databaseRole
)

Write-Verbose "Create SQL Connection String"
$conn = New-Object System.Data.SqlClient.SQLConnection
$conn.ConnectionString = "Server=$databaseServer;Initial Catalog=$databaseName;Encrypt=True;TrustServerCertificate=False;Connection Timeout=120"
$conn.AccessToken = $sqlAccessToken

Write-Verbose "Connect to database and execute SQL script"
$conn.Open()
$query = "
IF NOT EXISTS (SELECT [name] FROM [sys].[database_principals] WHERE [name] = N'$principalObjectName')
BEGIN
    CREATE USER [$principalObjectName] FOR EXTERNAL PROVIDER;
END
EXEC sp_addrolemember N'$databaseRole', N'$principalObjectName';
"
Write-Host $query
$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $conn)
$result = $command.ExecuteNonQuery()
$conn.Close()
