--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Main Post-deployment script for ADFDEMO_DW database - since it's a referenced database, this just calls the main database's post-deployment script
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/

:r ..\..\..\..\ADFDEMO_DW\Scripts\Post-Deployment\MainDeployment.sql
:r .\EnableCLRStrictSecurity.sql
