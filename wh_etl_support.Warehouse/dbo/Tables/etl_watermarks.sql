CREATE TABLE [dbo].[etl_watermarks] (

	[table_name] varchar(50) NULL, 
	[last_modified] datetime2(6) NULL
);