import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import toml

query_dict = {1:"SELECT * FROM Tasker",
              2:"SELECT * FROM Tasker ",
              3:"SELECT * FROM Tasker ",
              4:"SELECT * FROM Tasker ",
              5:"SELECT * FROM Tasker ",
              6:"SELECT * FROM Tasker ",
              7:"SELECT * FROM Tasker ",
              8:"SELECT * FROM Tasker ",
              9:"SELECT * FROM Tasker ",
              10:"SELECT * FROM Tasker ",
              11:"SELECT * FROM Tasker ",
              12:"SELECT * FROM Tasker ",
              13:"SELECT * FROM Tasker ",
              14:"SELECT * FROM Tasker ",
              15:"SELECT * FROM Tasker ",
              16:"SELECT * FROM Tasker ",
              17:"SELECT * FROM Tasker ",
              18:"SELECT * FROM Tasker ",
              19:"SELECT * FROM Tasker ",
              20:"SELECT * FROM Tasker "
              }

#connect with an sql database
secrets = toml.load("secrets.toml")

# Connect to SQL database
engine = create_engine(f"mssql+pyodbc://{secrets['azure']['username']}:{secrets['azure']['password']}@{secrets['azure']['server']}/{secrets['azure']['database']}?driver=ODBC+Driver+17+for+SQL+Server")

st.title("Taskrabbit- SQL Queries (PROJECT-INSY661)")

for i in range(1, len(query_dict)+1):
    st.write(f"Query {i}:")
    st.write(query_dict[i])
    st.write(pd.read_sql(query_dict[i], con=engine))
   
