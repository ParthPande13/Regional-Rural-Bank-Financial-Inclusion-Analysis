# Regional Rural Bank Financial Inclusion Analysis

An end-to-end data analytics project examining financial inclusion metrics across Regional Rural Banks (RRBs) in India — covering account penetration, digital adoption, deposits, loans, and rural-urban banking gaps across 20 states, 100 districts, and 5 years (2021–2025).

---

##  Project Overview

This project analyzes quarterly RRB banking data to understand how well financial inclusion initiatives are performing across different regions and demographics in India. The analysis covers account activity, women's participation, digital banking adoption (mobile/internet/UPI), and credit-deposit patterns, with the goal of identifying which factors most strongly drive actual account usage — not just account ownership.

##  Tech Stack

- **Python** — Pandas, NumPy (data cleaning, transformation, analysis)
- **Matplotlib & Seaborn** — visualizations
- **MySQL** — relational database (schema design, joins, aggregations)
- **SQLAlchemy / mysql-connector-python** — Python-to-MySQL connectivity
- **Power BI** — interactive dashboard

##  Repository Structure

```
├── data/
│   ├── raw/                                  # Original unprocessed dataset
│   └── processed/                            # Cleaned dataset (post EDA)
├── Regional_Rural_Bank_Analysis.ipynb        # Main notebook: cleaning, EDA, visualization
├── db_connection.py                          # MySQL connection & data loading script
├── schema.sql                                # Table creation, extraction, and analytical queries
├── RRB_Dashboard.pbix                        # Power BI interactive dashboard
├── Research_Paper_1_Domain.pdf               # Financial inclusion domain research
├── Research_Paper_2_Technology.pdf           # Python/SQL/Power BI technology research
└── README.md
```

##  Key Findings

1. **Digital adoption is the strongest driver of account activity.** Mobile banking ratio (r = 0.44) and internet banking ratio (r = 0.42) correlate far more strongly with active account usage than any loan, deposit, or outreach metric — all of which sit below 0.05.
2. **No significant rural-urban gap.** Contrary to common assumptions in financial inclusion literature, Rural, Urban, and Semi-Urban areas show nearly identical average active account ratios (~0.75–0.76) and digital adoption rates (~0.26–0.27).
3. **Account activity has remained flat over time.** Despite year-over-year growth in digital transaction volume, the average active account ratio barely moved (within 1 percentage point) between 2021 and 2025 — suggesting digital growth may be concentrated among already-active users rather than expanding the active base.
4. **State-wise variation exists in raw scale.** Uttarakhand, Rajasthan, and Kerala lead in total accounts; Bihar and Madhya Pradesh trail — though with only ~5 districts sampled per state, this should be read as dataset-specific rather than a definitive national pattern.

##  Setup & Usage

### 1. Clone the repository
```bash
git clone <repo-url>
cd Regional_Rural_Bank_Financial_Inclusion
```

### 2. Install dependencies
```bash
pip install pandas numpy matplotlib seaborn sqlalchemy mysql-connector-python
```

### 3. Set up the database
Run `schema.sql` in MySQL Workbench (or CLI) to create the database and tables:
```bash
mysql -u root -p < schema.sql
```

### 4. Load data into MySQL
```bash
python db_connection.py
```
*(Update the `DB_PASSWORD` variable with your own MySQL credentials before running.)*

### 5. Run the analysis
Open `Regional_Rural_Bank_Analysis.ipynb` in Jupyter or VSCode and run all cells to reproduce the cleaning, EDA, and visualizations.

### 6. View the dashboard
Open `RRB_Dashboard.pbix` in Power BI Desktop.

##  Dashboard Highlights

The Power BI dashboard includes:
- KPI cards (Total Accounts, Active Accounts, Deposits, Loans, Mobile Banking Users)
- State-wise account comparison
- Rural vs Urban vs Semi-Urban activity comparison
- Year-over-year activity trend
- Digital adoption vs account activity scatter plot
- Interactive slicers (State, Region, Year, Quarter)

##  Research Papers

1. **Domain Paper** — Financial inclusion trends in Indian banking, existing studies, and how this analysis fits into the broader literature.
2. **Technology Paper** — Overview of Python (Pandas/NumPy), SQL, and Power BI, and their role in this analytics workflow.

##  Data Notes

- Dataset covers 2021–2025, quarterly, across 20 states and 100 districts.
- Cleaning removed 10 duplicate rows and 59 rows with missing values (< 3% of data).
- All financial figures are in **Lakh (₹100,000)** units, per Indian financial reporting convention.

---
