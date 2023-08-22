import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import toml
from queries import query_dict, query_detail


#connect with an sql database
secrets = toml.load("secrets.toml")

# Connect to SQL database
engine = create_engine(f"mssql+pyodbc://{secrets['azure']['username']}:{secrets['azure']['password']}@{secrets['azure']['server']}/{secrets['azure']['database']}?driver=ODBC+Driver+17+for+SQL+Server")

st.title("Taskrabbit- SQL Queries (PROJECT-INSY661)")

for i in range(1, len(query_dict)+1):
    
    st.write("________________________________________________________")
    st.write(f" {i}: {query_detail[i]}:")
    st.write("________________________________________________________")
    st.code(query_dict[i], language="sql")
    st.write(pd.read_sql(query_dict[i], con=engine))

