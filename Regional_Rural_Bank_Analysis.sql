
CREATE DATABASE IF NOT EXISTS rrb_financial_inclusion;
USE rrb_financial_inclusion;


CREATE TABLE IF NOT EXISTS location_dim (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    district VARCHAR(50) NOT NULL,
    rural_urban VARCHAR(20) NOT NULL,
    UNIQUE KEY unique_location (state, region, district, rural_urban)
);


CREATE TABLE IF NOT EXISTS rrb_financial_data (
    record_id INT PRIMARY KEY,
    location_id INT NOT NULL,
    year INT NOT NULL,
    quarter VARCHAR(5) NOT NULL,
    population BIGINT,
    branches INT,
    banking_outlets INT,
    atms INT,
    bc_outlets INT,
    total_accounts BIGINT,
    active_accounts BIGINT,
    women_accounts BIGINT,
    jan_dhan_accounts BIGINT,
    total_deposits_lakh DECIMAL(15,2),
    savings_deposits_lakh DECIMAL(15,2),
    current_deposits_lakh DECIMAL(15,2),
    term_deposits_lakh DECIMAL(15,2),
    total_loans_lakh DECIMAL(15,2),
    agricultural_loans_lakh DECIMAL(15,2),
    msme_loans_lakh DECIMAL(15,2),
    personal_loans_lakh DECIMAL(15,2),
    digital_transactions BIGINT,
    upi_transactions BIGINT,
    mobile_banking_users BIGINT,
    internet_banking_users BIGINT,
    agricultural_beneficiaries BIGINT,
    shg_accounts BIGINT,
    kcc_accounts BIGINT,
    FOREIGN KEY (location_id) REFERENCES location_dim(location_id)
);

SHOW TABLES;


SELECT COUNT(*) FROM location_dim;
SELECT COUNT(*) FROM rrb_financial_data;

-- Data Extraction
SELECT f.*, l.state, l.region, l.district, l.rural_urban
FROM rrb_financial_data f
JOIN location_dim l ON f.location_id = l.location_id;

-- Data preparation
-- Duplicate check
SELECT record_id, COUNT(*)
FROM rrb_financial_data
GROUP BY record_id
HAVING COUNT(*) > 1;


-- Missing value checks
SELECT COUNT(*) AS missing_total_accs
FROM rrb_financial_data
WHERE total_accounts IS NULL;

SELECT COUNT(*) AS missing_mobile_banking
FROM rrb_financial_data
WHERE mobile_banking_users IS NULL;

-- Query 1: Total Accounts by State
SELECT l.state, SUM(f.total_accounts) AS total_accounts
FROM rrb_financial_data f
JOIN location_dim l ON f.location_id = l.location_id
GROUP BY l.state
ORDER BY total_accounts DESC;

-- Query 2: Average Active Accounts by Rural/Urban/Semi-Urban
SELECT l.rural_urban, AVG(f.active_accounts) AS avg_active_accounts
FROM rrb_financial_data f
JOIN location_dim l ON f.location_id = l.location_id
GROUP BY l.rural_urban;

-- Query 3: Total Digital Transactions by Year
SELECT f.year, SUM(f.digital_transactions) AS total_digital_transactions
FROM rrb_financial_data f
GROUP BY f.year
ORDER BY f.year;

-- Query 4: Total Deposits and Loans by Region
SELECT l.region, SUM(f.total_deposits_lakh) AS total_deposits, SUM(f.total_loans_lakh) AS total_loans
FROM rrb_financial_data f
JOIN location_dim l ON f.location_id = l.location_id
GROUP BY l.region
ORDER BY total_deposits DESC;

-- Query 5: Top 10 Districts by Mobile Banking Users
SELECT l.district, l.state, AVG(f.mobile_banking_users) AS avg_mobile_banking_users
FROM rrb_financial_data f
JOIN location_dim l ON f.location_id = l.location_id
GROUP BY l.district, l.state
ORDER BY avg_mobile_banking_users DESC
LIMIT 10;