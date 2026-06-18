-- ==========================================
-- PROJECT: Superstore Sales Analysis
-- FILE: 02_validation_cleaning.sql
-- AUTHOR: M SureshKumar
-- DESCRIPTION: Data Validation, Cleaning, and Duplicate Removal
-- ==========================================

-- 1. CHECK FOR MISSING VALUES (NUMERIC)
SELECT 
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM store;

-- 2. CHECK FOR INVALID LOGIC
-- Sales must be > 0
SELECT COUNT(*) AS invalid_sales FROM store WHERE sales <= 0;
-- Quantity must be >= 1
SELECT COUNT(*) AS invalid_quantity FROM store WHERE quantity <= 0;
-- Discount must be between 0 and 1
SELECT COUNT(*) AS invalid_discount FROM store WHERE discount < 0 OR discount > 1;

-- 3. DETECT DUPLICATES
-- Group by all business columns (excluding auto-generated row_id)
SELECT COUNT(*) FILTER (WHERE duplicate_count > 1) AS duplicate_groups_found
FROM (
    SELECT 
        ship_mode, segment, country, city, state, postal_code, region,
        category, sub_category, sales, quantity, discount, profit,
        COUNT(*) AS duplicate_count
    FROM store
    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
) AS dup_check;

-- Calculate total extra duplicate rows
WITH dup_counts AS (
    SELECT COUNT(*) AS duplicate_count
    FROM store
    GROUP BY 
        ship_mode, segment, country, city, state, postal_code, region,
        category, sub_category, sales, quantity, discount, profit
    HAVING COUNT(*) > 1
)
SELECT SUM(duplicate_count - 1) AS total_duplicate_rows_to_remove FROM dup_counts;
-- Expected Result: 17 duplicates found

-- 4. CREATE CLEAN TABLE (SAFETY STRATEGY)
DROP TABLE IF EXISTS store_clean;

CREATE TABLE store_clean (
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

-- INSERT UNIQUE ROWS ONLY
INSERT INTO store_clean (
    ship_mode, segment, country, city, state, postal_code, region,
    category, sub_category, sales, quantity, discount, profit
)
SELECT DISTINCT 
    ship_mode, segment, country, city, state, postal_code, region,
    category, sub_category, sales, quantity, discount, profit
FROM store;

-- VERIFY CLEAN TABLE
SELECT COUNT(*) AS clean_rows FROM store_clean;
-- Expected Output: 9977 (9994 original - 17 duplicates)