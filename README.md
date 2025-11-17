# Easy ERD

**Easy ERD** is a lightweight tool for generating ER diagrams (Mermaid) from database schemas.

[mermerd go cli](https://github.com/KarnerTh/mermerd?tab=readme-ov-file)

[duckerd cli](https://github.com/tobilg/duckerd)

[Snowflake - makes dot files](https://medium.com/snowflake/how-to-generate-erds-from-a-snowflake-model-3fc53abd0669)



## Concept

- User selects a database type (Postgres, DuckDB, Snowflake).
- App provides a query or view definition to extract schema metadata.
- User runs the query in their DB and exports the results as CSV.
- App loads the CSV and builds an internal model of tables, columns, and relationships.
- User chooses which tables to include.
- App outputs Mermaid ERD code (and later, a live preview).

## Goals

- Simple, driver-free workflow (CSV-based)
- Unified metadata format across different databases
- Clean, customizable ERDs
- Minimal UI friction (Streamlit prototype)

## Planned Features

- Upload schema CSV  
- Detect tables, columns, and keys  
- Filter out system tables  
- Table selection interface  
- Multiple ERD detail levels  
- Mermaid code generation  
- Optional in-app preview  

## Future Ideas

- Infer relationships where foreign keys are not declared  
- Save/load ERD configurations  
- Export images directly  
- Integrate with GitHub or documentation tools  
- Theme and styling options  
