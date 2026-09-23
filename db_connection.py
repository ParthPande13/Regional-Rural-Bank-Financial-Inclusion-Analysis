import pandas as pd
from sqlalchemy import create_engine

DB_USER = "root"
DB_PASSWORD = "MyNewPassword123!"
DB_NAME = "rrb_financial_inclusion"


# Loading the dataset

engine = create_engine(f"mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@localhost/{DB_NAME}")
print("Connected!")

df = pd.read_csv("data/processed/rrb_cleaned.csv")
df.shape



# creating the location table

location_dim = df[["State", "Region", "District", "Rural_Urban"]].drop_duplicates()
location_dim.insert(0, "location_id", range(1, len(location_dim) + 1))
location_dim.columns = ["location_id", "state", "region", "district", "rural_urban"]

location_dim.to_sql("location_dim", engine, if_exists="append", index=False)
print("location_dim loaded:", len(location_dim), "rows")



#

df = df.merge(
    location_dim,
    left_on=["State", "Region", "District", "Rural_Urban"],
    right_on=["state", "region", "district", "rural_urban"]
)
df[["State", "location_id"]].head()

# Load the main data table
cols = ["Record_ID", "location_id", "Year", "Quarter", "Population", "Branches",
    "Banking_Outlets", "ATMs", "BC_Outlets", "Total_Accounts", "Active_Accounts",
    "Women_Accounts", "Jan_Dhan_Accounts", "Total_Deposits_Lakh", "Savings_Deposits_Lakh",
    "Current_Deposits_Lakh", "Term_Deposits_Lakh", "Total_Loans_Lakh",
    "Agricultural_Loans_Lakh", "MSME_Loans_Lakh", "Personal_Loans_Lakh",
    "Digital_Transactions", "UPI_Transactions", "Mobile_Banking_Users",
    "Internet_Banking_Users", "Agricultural_Beneficiaries", "SHG_Accounts", "KCC_Accounts"]

fact_table = df[cols].copy()
fact_table.columns = [c.lower() for c in fact_table.columns]

fact_table.to_sql("rrb_financial_data", engine, if_exists="append", index=False)
print("rrb_financial_data loaded:", len(fact_table), "rows")