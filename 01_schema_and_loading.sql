-- ==========================================
-- PROJECT: Superstore Sales Analysis
-- FILE: 01_schema_and_loading.sql
-- AUTHOR: M SureshKumar
-- DESCRIPTION: Table creation and initial data loading
-- ==========================================

-- Drop table if exists to start fresh
DROP TABLE IF EXISTS store;

-- Create the main store table with proper data types
CREATE TABLE store (
    row_id SERIAL PRIMARY KEY,
    ship_mode VARCHAR(20),
    segment VARCHAR(20),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(10),
    region VARCHAR(20),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INTEGER,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2)
);

-- NOTE: 
-- In a real environment, you would load the CSV using:
-- COPY store (...) FROM 'path/to/file.csv' WITH CSV HEADER;
-- OR via pgAdmin Import Wizard.
-- 
-- Since we are simulating the clean process here, 
-- assume data is loaded into 'store' table below.

-- Verify row count after loading
SELECT COUNT(*) AS total_rows_loaded FROM store;
-- Expected Output: 9994