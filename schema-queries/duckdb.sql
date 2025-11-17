-- DuckDB Schema Query for Easy ERD
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
        table_schema,
        table_name,
        column_name
    FROM information_schema.key_column_usage
    WHERE constraint_name LIKE '%_pk' OR constraint_name LIKE '%_pkey'
) pk 
    ON c.table_schema = pk.table_schema
    AND c.table_name = pk.table_name
    AND c.column_name = pk.column_name
LEFT JOIN (
    SELECT 
        kcu.table_schema,
        kcu.table_name,
        kcu.column_name,
        ccu.table_schema as foreign_table_schema,
        ccu.table_name as foreign_table_name,
        ccu.column_name as foreign_column_name
    FROM information_schema.key_column_usage kcu
    JOIN information_schema.constraint_column_usage ccu
        ON kcu.constraint_name = ccu.constraint_name
    WHERE kcu.constraint_name LIKE '%_fk' OR kcu.constraint_name LIKE '%_fkey'
) fk
    ON c.table_schema = fk.table_schema
    AND c.table_name = fk.table_name
    AND c.column_name = fk.column_name
WHERE t.table_type = 'BASE TABLE'
    AND t.table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY t.table_schema, t.table_name, c.ordinal_position;