import pandas as pd
from sqlalchemy import create_engine

# Load CSV files
Order = pd.read_csv("data/Orders.csv", low_memory=False)
People = pd.read_csv("data/People.csv", low_memory=False)
Returns = pd.read_csv("data/Returns.csv", low_memory=False)

# Database connection
user = 'root'
password = 'zahid'
host = 'localhost'
port = 3306
database = 'retailSales'

# Create engine
engine = create_engine(f"mysql+pymysql://{user}:{password}@{host}:{port}/{database}?charset=utf8mb4")

# Use engine.begin() for better transaction handling
with engine.begin() as conn:
    Order.to_sql(name='Orders', con=conn, if_exists='replace', index=False)
    People.to_sql(name='People', con=conn, if_exists='replace', index=False)
    Returns.to_sql(name='Returns', con=conn, if_exists='replace', index=False)

print("✅ Data inserted successfully!")
