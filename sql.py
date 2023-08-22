import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import toml

#connect with an sql database


# Connect to SQL database
engine = sqlalchemy.create_engine(f"mssql+pyodbc://{secrets['azure']['username']}:{secrets['azure']['password']}@{secrets['azure']['server']}/{secrets['azure']['database']}?driver=ODBC+Driver+17+for+SQL+Server")

query = "SELECT * FROM Tasker"
data = pd.read_sql(query, engine)


st.write("Displaying data from SQL database:")
st.dataframe(data)
