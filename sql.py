import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import toml
from queries import query_dict, query_detail


#connect with an sql database
secrets = toml.load("secrets.toml")

# Connect to SQL database
engine = create_engine(f"mssql+pyodbc://{secrets['azure']['username']}:{secrets['azure']['password']}@{secrets['azure']['server']}/{secrets['azure']['database']}?driver=ODBC+Driver+17+for+SQL+Server")

st.title("Group 1: Taskrabbit SQL Queries")



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
    st.write("________________________________________________________")
    st.code(query_dict[i], language="sql")
    st.write(pd.read_sql(query_dict[i], con=engine, index_col=None))
    
