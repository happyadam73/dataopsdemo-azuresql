--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Post-deployment script - populate the Config.ADFMainPipelines table with the overall ADF pipeline configuration
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

MERGE [Config].[ADFMainPipelines] t
USING (VALUES 
	(10,'PL_MAIN_FHRS_Load_Establishments_And_Authorities',1)
) s ([RunSequenceID],[PipelineName],[Active]) ON s.[RunSequenceID] = t.[RunSequenceID] 
-- Insert new Rows
WHEN NOT MATCHED BY TARGET THEN 
INSERT ([RunSequenceID],[PipelineName],[Active])
VALUES (s.[RunSequenceID],s.[PipelineName],s.[Active]);
