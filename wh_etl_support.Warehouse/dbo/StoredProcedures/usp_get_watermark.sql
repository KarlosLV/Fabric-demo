CREATE PROCEDURE usp_get_watermark
    @TableName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the record exists
    IF NOT EXISTS (
        SELECT 1
        FROM etl_watermarks
        WHERE [table_name] = @TableName
    )
    BEGIN
        -- Insert default watermark if it doesn't exist
        INSERT INTO etl_watermarks ([table_name], [last_modified])
        VALUES (@TableName, '2025-01-01');
    END

    -- Return the watermark
    SELECT [last_modified]
    FROM etl_watermarks
    WHERE [table_name] = @TableName;
END