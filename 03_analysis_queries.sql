-- ==========================================
-- PROJECT: Superstore Sales Analysis
-- FILE: 03_analysis_queries.sql
-- AUTHOR: M SureshKumar
-- DESCRIPTION: Business Analysis & Advanced SQL Techniques (CTEs, Window Functions)
-- ==========================================

-- --- LEVEL 1: OVERALL HEALTH ---
-- Total Sales and Profit Margin
SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100, 2) AS overall_profit_margin_percent
FROM store_clean;


-- --- LEVEL 2: REGIONAL PERFORMANCE ---
-- Compare regions by margin and discount
SELECT 
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100, 2) AS profit_margin,
    ROUND(AVG(discount)*100, 2) AS avg_discount_percent
FROM store_clean
GROUP BY region
ORDER BY profit_margin DESC;


-- --- LEVEL 3: DEEP DIVE (CENTRAL REGION) ---
-- Why is Central Region underperforming? Check Category Discounts
SELECT 
    category,
    ROUND(AVG(discount)*100, 2) AS avg_discount_percent
FROM store_clean
WHERE region = 'Central'
GROUP BY category
ORDER BY avg_discount_percent DESC;


-- --- LEVEL 4: PRODUCT COST VS DISCOUNT INSIGHT ---
-- Compare Tables (High Cost) vs Binders (Low Cost) margins
SELECT 
    sub_category,
    ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin,
    ROUND(AVG(discount)*100, 2) AS avg_discount
FROM store_clean
WHERE sub_category IN ('Tables', 'Binders')
GROUP BY sub_category;


-- --- ADVANCED SKILL 1: TOP 3 PRODUCTS PER REGION (CTE + WINDOW FUNCTION) ---
-- Identify regional best-sellers to avoid "one-size-fits-all" marketing
WITH regional_rankings AS (
    SELECT 
        region,
        sub_category,
        SUM(sales) AS total_sales,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS rank_in_region
    FROM store_clean
    GROUP BY region, sub_category
)
SELECT * 
FROM regional_rankings
WHERE rank_in_region <= 3
ORDER BY region, rank_in_region;


-- --- ADVANCED SKILL 2: ABOVE-AVERAGE PERFORMERS (NESTED SUBQUERY) ---
-- Find states performing better than the national average
SELECT 
    state,
    SUM(sales) AS total_sales
FROM store_clean
GROUP BY state
HAVING SUM(sales) > (
    SELECT AVG(state_avg) 
    FROM (
        SELECT SUM(sales) AS state_avg
        FROM store_clean
        GROUP BY state
    ) AS avg_calc
)
ORDER BY total_sales DESC;


-- --- ADVANCED SKILL 3: PROFIT CLASSIFICATION (CASE WHEN) ---
-- Categorize products into High/Medium/Low margin buckets
SELECT 
    category,
    ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin,
    CASE 
        WHEN (SUM(profit)/SUM(sales)*100) > 15 THEN 'High Margin (>15%)'
        WHEN (SUM(profit)/SUM(sales)*100) BETWEEN 5 AND 15 THEN 'Medium Margin (5-15%)'
        ELSE 'Low Margin (<5%)'
    END AS margin_status
FROM store_clean
GROUP BY category
ORDER BY profit_margin DESC;