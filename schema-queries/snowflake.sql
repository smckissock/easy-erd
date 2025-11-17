-- Snowflake Schema Query for Easy ERD
-- Run this query and export results as CSV

SELECT 
    t.table_schema,
    t.table_name,
    c.column_name,
    c.data_type,
    c.ordinal_position,
    CASE WHEN pk.column_name IS NOT NULL THEN 'YES' ELSE 'NO' END as is_primary_key,
    fk.foreign_table_schema,
    fk.foreign_table_name,
    fk.foreign_column_name
FROM information_schema.tables t
JOIN information_schema.columns c 
    ON t.table_schema = c.table_schema 
    AND t.table_name = c.table_name
LEFT JOIN (
    SELECT 
        tc.table_schema,
        tc.table_name,
        kcu.column_name
    FROM information_schema.table_constraints tc
    JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name
        AND tc.table_schema = kcu.table_schema
        AND tc.table_name = kcu.table_name
    WHERE tc.constraint_type = 'PRIMARY KEY'
) pk 
    ON c.table_schema = pk.table_schema
    AND c.table_name = pk.table_name
    AND c.column_name = pk.column_name
LEFT JOIN (
    SELECT 
        kcu.table_schema,
        kcu.table_name,
        kcu.column_name,
        kcu2.table_schema as foreign_table_schema,
        kcu2.table_name as foreign_table_name,
        kcu2.column_name as foreign_column_name
    FROM information_schema.referential_constraints rc
    JOIN information_schema.key_column_usage kcu
        ON rc.constraint_name = kcu.constraint_name
        AND rc.constraint_schema = kcu.table_schema
    JOIN information_schema.key_column_usage kcu2
        ON rc.unique_constraint_name = kcu2.constraint_name
        AND rc.unique_constraint_schema = kcu2.table_schema
) fk
    ON c.table_schema = fk.table_schema
    AND c.table_name = fk.table_name
    AND c.column_name = fk.column_name
WHERE t.table_type = 'BASE TABLE'
    AND t.table_schema NOT IN ('INFORMATION_SCHEMA', 'PERFORMANCE_SCHEMA')
ORDER BY t.table_schema, t.table_name, c.ordinal_position;