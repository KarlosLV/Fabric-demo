CREATE PROCEDURE usp_etl_watermark 
    @LastModifiedtime DATETIME, 
    @TableName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 
        FROM etl_watermarks 
        WHERE [table_name] = @TableName
    )
    BEGIN
        -- Update if it exists
        UPDATE etl_watermarks
        SET [last_modified] = @LastModifiedtime
        WHERE [table_name] = @TableName;
    END
    ELSE
    BEGIN
        -- Insert if it doesn't exist
        INSERT INTO etl_watermarks ([table_name], [last_modified])
        VALUES (@TableName, @LastModifiedtime);
    END
END