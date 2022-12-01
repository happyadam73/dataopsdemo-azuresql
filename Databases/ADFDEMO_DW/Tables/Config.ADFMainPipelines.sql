--/	
--/ Product:			ADF DevOps Demo Data Warehouse
--/ Description:		Configuration table for running the full ADFDEMO ETL DW Load by calling all of the MAIN pipelines
--/	
--/ Author:				Adam Buckley
--/ Creation Date:		04/11/2022
--/	
--/ Revision History:	1.0
--/	

CREATE TABLE [Config].[ADFMainPipelines]
(
	[RunSequenceID]	SMALLINT	 NOT NULL CONSTRAINT [PK_Config_ADFMainPipelines] PRIMARY KEY CLUSTERED,
	[PipelineName]	VARCHAR(250) NOT NULL,
	[LastTriggered] DATETIME	 NULL,
	[LastSkipped]	DATETIME	 NULL,
	[Active]		TINYINT		 NOT NULL CONSTRAINT [DF_Config_ADFMainPipelines_Active] DEFAULT (1)
);
GO

EXEC sp_addextendedproperty 
@level0type	= N'Schema', @level0name = 'Config',
@level1type = N'Table', @level1name = 'ADFMainPipelines',
@name = N'MS_Description', @value = 'Configuration table for running the full ADFDEMO ETL DW Load by calling all of the MAIN pipelines';
GO
