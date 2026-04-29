-- =========================================
-- STEP 1: CREATE DATABASE
-- =========================================
CREATE DATABASE TransactionAnalysis;   -- Creates new database for project
GO

USE TransactionAnalysis;              -- Switch to the created database
GO


-- =========================================
-- STEP 2: CREATE TABLE
-- =========================================
CREATE TABLE transactions (
    Transaction_ID VARCHAR(10) PRIMARY KEY,   -- Unique identifier for each transaction (PK)
    User_ID VARCHAR(10) NOT NULL,             -- Customer/user identifier
    Transaction_Date DATE NOT NULL,           -- Date of transaction
    Transaction_Amount INT NOT NULL,          -- Transaction value
    Transaction_Type VARCHAR(10) NOT NULL,    -- Debit or Credit
    Merchant_Category VARCHAR(50) NOT NULL,   -- Type of spending category
    Location VARCHAR(50) NOT NULL,            -- City/location of transaction
    Device_Type VARCHAR(10) NOT NULL          -- Device used (Mobile/Web)
);
GO


-- =========================================
-- STEP 3: DATA VALIDATION QUERIES
-- =========================================

-- QUERY 1: View sample records
SELECT TOP 10 * FROM transactions;   -- Checks if data is loaded correctly

-- QUERY 2: Total number of records
SELECT COUNT(*) AS total_transactions FROM transactions;   -- Confirms dataset size

-- QUERY 3: Check NULL values in key columns
SELECT 
    SUM(CASE WHEN User_ID IS NULL THEN 1 ELSE 0 END) AS null_user_id,         -- Missing User_ID check
    SUM(CASE WHEN Transaction_Amount IS NULL THEN 1 ELSE 0 END) AS null_amt,   -- Missing amount check
    SUM(CASE WHEN Transaction_Date IS NULL THEN 1 ELSE 0 END) AS null_date     -- Missing date check
FROM transactions;

-- QUERY 4: Check duplicate Transaction_ID (PK validation)
SELECT Transaction_ID, COUNT(*) AS duplicate_count
FROM transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;   -- Should return no rows if PK is correct


-- =========================================
-- STEP 4: ANALYSIS QUERIES (ANOMALY DETECTION)
-- =========================================

-- QUERY 5: High-frequency users
SELECT 
    User_ID, 
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY User_ID
HAVING COUNT(*) > 10         -- Flags users with unusually high activity
ORDER BY transaction_count DESC;


-- QUERY 6: High-value transactions
SELECT *
FROM transactions
WHERE Transaction_Amount > 30000   -- Detects large suspicious transactions
ORDER BY Transaction_Amount DESC;


-- QUERY 7: Daily spending spikes
SELECT 
    User_ID,
    Transaction_Date,
    SUM(Transaction_Amount) AS daily_total
FROM transactions
GROUP BY User_ID, Transaction_Date
HAVING SUM(Transaction_Amount) > 50000   -- Detects abnormal daily spend
ORDER BY daily_total DESC;


-- QUERY 8: Multi-location activity
SELECT 
    User_ID,
    COUNT(DISTINCT Location) AS location_count
FROM transactions
GROUP BY User_ID
HAVING COUNT(DISTINCT Location) > 2   -- Possible account compromise indicator
ORDER BY location_count DESC;


-- QUERY 9: Frequent small transactions
SELECT *
FROM transactions
WHERE Transaction_Amount < 1000
AND User_ID IN (
    SELECT User_ID
    FROM transactions
    GROUP BY User_ID
    HAVING COUNT(*) > 5   -- Detects structuring-like behavior
);


-- QUERY 10: Category-wise spending
SELECT 
    Merchant_Category,
    COUNT(*) AS total_transactions,
    SUM(Transaction_Amount) AS total_spent
FROM transactions
GROUP BY Merchant_Category
ORDER BY total_spent DESC;


-- QUERY 11: High-risk users summary
SELECT 
    User_ID,
    COUNT(*) AS txn_count,
    SUM(Transaction_Amount) AS total_spent
FROM transactions
GROUP BY User_ID
HAVING COUNT(*) > 10 
    OR SUM(Transaction_Amount) > 100000   -- Combined risk rule
ORDER BY total_spent DESC;