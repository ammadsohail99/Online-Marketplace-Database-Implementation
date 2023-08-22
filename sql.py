import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import toml

query_dict = {1:"SELECT * FROM Tasker",
              2:"SELECT * FROM Tasker limit 2"

              }

#connect with an sql database
secrets = toml.load("secrets.toml")

# Connect to SQL database
engine = create_engine(f"mssql+pyodbc://{secrets['azure']['username']}:{secrets['azure']['password']}@{secrets['azure']['server']}/{secrets['azure']['database']}?driver=ODBC+Driver+17+for+SQL+Server")


for i in range(1, len(query_dict)+1):
    st.write(f"Query {i}:")
    st.write(query_dict[i])
    st.write(pd.read_sql(query_dict[i], con=engine))
   
