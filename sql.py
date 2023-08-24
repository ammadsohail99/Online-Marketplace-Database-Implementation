import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import toml
from queries import query_dict, query_detail


# Get secrets from Streamlit's secrets API
azure_username = st.secrets["azure_username"]
azure_password = st.secrets["azure_password"]
azure_server = st.secrets["azure_server"]
azure_database = st.secrets["azure_database"]


# Connect to Azure database
engine = create_engine(f"mssql+pyodbc://{azure_username}:{azure_password}@{azure_server}/{azure_database}?driver=ODBC+Driver+17+for+SQL+Server")

st.title("Group 1: Taskrabbit SQL Queries")

# Display ERD Diagram using a link
erd_image_link = "https://storagekg33.blob.core.windows.net/containerk1/Database_Project_ERD.jpeg"
st.image(erd_image_link, use_column_width=True, caption="ERD Diagram")

# Input area for custom query
custom_query = st.text_area("Enter your custom SQL query here:")

if st.button("Run Custom Query"):
    st.write("Running Custom Query:")
    st.code(custom_query, language="sql")
    
    try:
        # Execute custom query and display results
        result = pd.read_sql(custom_query, con=engine)
        st.write("Query Result:")
        st.write(result)
    except Exception as e:
        st.error(f"An error occurred: {e}")


for i in range(1, len(query_dict)+1):
    
    st.write("________________________________________________________")
    st.write(f" {i}: {query_detail[i]}:")
    st.code(query_dict[i], language="sql")
    st.write(pd.read_sql(query_dict[i], con=engine, index_col=None))
    
