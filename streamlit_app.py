import streamlit as st
from pathlib import Path

st.set_page_config(page_title="Easy ERD", page_icon="🗂️", layout="wide")

st.title("🗂️ Easy ERD")
st.markdown("Generate Entity Relationship Diagrams from your database schema")

# Step 1: Select Database
st.header("Step 1: Select Your Database")

database_type = st.selectbox(
    "Choose your database type:",
    ["Snowflake", "DuckDB", "PostgreSQL"]
)

# Load the appropriate query
query_file = f"schema-queries/{database_type.lower()}.sql"
query_path = Path(query_file)

if query_path.exists():
    with open(query_path, 'r') as f:
        query = f.read()
    
    st.header("Step 2: Run This Query in Your Database")
    st.markdown(f"""
    Copy the query below and run it in your **{database_type}** database.
    Then export the results as a CSV file.
    """)
    
    st.code(query, language="sql")
    
    # Copy button
    st.download_button(
        label="📋 Download Query",
        data=query,
        file_name=f"{database_type.lower()}_schema_query.sql",
        mime="text/plain"
    )
else:
    st.error(f"Query file not found: {query_file}")

# Step 3: Upload CSV
st.header("Step 3: Upload Query Results")
st.markdown("Upload the CSV file with your query results:")

uploaded_file = st.file_uploader("Choose a CSV file", type="csv")

if uploaded_file is not None:
    st.success("✓ File uploaded successfully!")
    st.info("Next: Table selection will appear here")
else:
    st.info("Waiting for CSV upload...")