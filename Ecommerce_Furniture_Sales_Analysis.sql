
-- E-COMMERCE FURNITURE SALES ANALYSIS SQL SCRIPT
-- ================================================

-- TABLE STRUCTURE ASSUMPTION
-- Columns: productTitle, originalPrice, price, sold, tagText

-- 1. DATA CLEANING
DELETE FROM furniture_sales
WHERE rowid NOT IN (
  SELECT MIN(rowid)
  FROM furniture_sales
  GROUP BY productTitle, price, sold
);

UPDATE furniture_sales
SET originalPrice = price
WHERE originalPrice IS NULL OR originalPrice = 0;

UPDATE furniture_sales
SET tagText = 'Unknown'
WHERE tagText IS NULL OR TRIM(tagText) = '';

-- 2. ADD CALCULATED COLUMNS
ALTER TABLE furniture_sales ADD COLUMN discount_percent FLOAT;
ALTER TABLE furniture_sales ADD COLUMN total_revenue FLOAT;

UPDATE furniture_sales
SET discount_percent = ROUND(((originalPrice - price) / originalPrice) * 100, 2),
    total_revenue = price * sold;

-- 3. VIEW CLEANED DATA
SELECT * FROM furniture_sales LIMIT 20;

-- 4. TOTAL REVENUE, AVERAGE PRICE, AND TOTAL SOLD
SELECT 
    SUM(total_revenue) AS total_revenue,
    AVG(price) AS avg_price,
    SUM(sold) AS total_units_sold
FROM furniture_sales;

-- 5. TOP 10 BEST SELLING PRODUCTS
SELECT 
    productTitle,
    SUM(sold) AS total_units,
    SUM(total_revenue) AS total_revenue
FROM furniture_sales
GROUP BY productTitle
ORDER BY total_revenue DESC
LIMIT 10;

-- 6. HIGHEST DISCOUNTS OFFERED
SELECT 
    productTitle,
    originalPrice,
    price,
    discount_percent
FROM furniture_sales
ORDER BY discount_percent DESC
LIMIT 10;

-- 7. TAG-BASED PERFORMANCE
SELECT 
    tagText,
    COUNT(productTitle) AS number_of_products,
    SUM(total_revenue) AS total_revenue,
    SUM(sold) AS total_units_sold
FROM furniture_sales
GROUP BY tagText
ORDER BY total_revenue DESC;

-- 8. PRICE VS SALES RELATIONSHIP
SELECT 
    CASE 
        WHEN price < 50 THEN 'Low Price'
        WHEN price BETWEEN 50 AND 150 THEN 'Medium Price'
        ELSE 'High Price'
    END AS price_range,
    SUM(sold) AS total_sold,
    SUM(total_revenue) AS total_revenue
FROM furniture_sales
GROUP BY price_range
ORDER BY total_revenue DESC;

-- 9. SUMMARY STATISTICS
SELECT
    COUNT(*) AS total_products,
    SUM(sold) AS total_units_sold,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(discount_percent), 2) AS avg_discount,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM furniture_sales;

-- 10. CATEGORY INSIGHT (BASED ON PRODUCT TITLE)
SELECT
    CASE
        WHEN LOWER(productTitle) LIKE '%chair%' THEN 'Chair'
        WHEN LOWER(productTitle) LIKE '%sofa%' THEN 'Sofa'
        WHEN LOWER(productTitle) LIKE '%table%' THEN 'Table'
        WHEN LOWER(productTitle) LIKE '%bed%' THEN 'Bed'
        ELSE 'Other'
    END AS category,
    SUM(total_revenue) AS total_revenue,
    SUM(sold) AS total_units
FROM furniture_sales
GROUP BY category
ORDER BY total_revenue DESC;
