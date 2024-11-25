-- Clean up invalid or inconsistent data
DELETE FROM sales
WHERE gender = '#N/A';

DELETE FROM sales
WHERE (addonspurchased IS NULL AND addonstotal <> 0) 
   OR (addonspurchased IS NOT NULL AND addonstotal = 0);

-- 1. Compare sales and AOV between members and non-members
DROP VIEW IF EXISTS loyalty_sales;
CREATE VIEW loyalty_sales AS 
SELECT
    loyaltymember AS loyalty_member,
    SUM(totalprice) AS sales,
    COUNT(customerid) AS sales_count,
    ROUND(SUM(totalprice) / COUNT(customerid), 2) AS AOV
FROM sales
WHERE orderstatus = 'Completed'
GROUP BY loyaltymember;

-- 1.1 View: Member sales summary
DROP VIEW IF EXISTS loyalty_member_sales;
CREATE VIEW loyalty_member_sales AS 
SELECT
    COUNT(DISTINCT customerid) AS member,
    SUM(totalprice) AS sales,
    COUNT(customerid) AS sales_count,
    ROUND(SUM(totalprice) / COUNT(customerid), 2) AS AOV
FROM sales
WHERE orderstatus = 'Completed' 
  AND loyaltymember = 'Yes';

-- 1.2 View: Non-member sales summary
DROP VIEW IF EXISTS loyalty_nonmember_sales;
CREATE VIEW loyalty_nonmember_sales AS 
SELECT
    COUNT(DISTINCT customerid) AS nonmember,
    SUM(totalprice) AS sales,
    COUNT(customerid) AS sales_count,
    ROUND(SUM(totalprice) / COUNT(customerid), 2) AS AOV
FROM sales
WHERE orderstatus = 'Completed' 
  AND loyaltymember = 'No';

-- 2. Compare repurchase rates between members and non-members
DROP VIEW IF EXISTS loyalty_repurchase;
CREATE VIEW loyalty_repurchase AS 
SELECT
    loyaltymember,
    CAST(SUM(CASE WHEN sales_count > 1 THEN 1 ELSE 0 END) AS NUMERIC(10, 2)) 
        / CAST(COUNT(sales_count) AS NUMERIC(10, 2)) AS repurchase_rate
FROM (
    SELECT
        loyaltymember,
        COUNT(customerid) AS sales_count
    FROM sales
    WHERE orderstatus = 'Completed'
    GROUP BY customerid, loyaltymember
) sub
GROUP BY loyaltymember;

-- 3. Age segmentation for members and non-members
DROP VIEW IF EXISTS loyalty_sales_age;
CREATE VIEW loyalty_sales_age AS 
SELECT
    age_group,
    loyaltymember AS loyalty_member,
    SUM(totalprice) AS sales,
    COUNT(customerid) AS sales_count,
    ROUND(SUM(totalprice) / COUNT(customerid), 2) AS AOV
FROM (
    SELECT
        customerid,
        totalprice,
        CASE 
            WHEN age <= 20 THEN '<=20'
            WHEN age <= 30 THEN '21-30'
            WHEN age <= 40 THEN '31-40'
            WHEN age <= 50 THEN '41-50'
            WHEN age <= 60 THEN '51-60'
            WHEN age <= 70 THEN '61-70'
            WHEN age <= 80 THEN '71-80'
            ELSE '>80'
        END AS age_group,
        loyaltymember
    FROM sales
    WHERE orderstatus = 'Completed'
) sub
GROUP BY age_group, loyaltymember
ORDER BY age_group DESC, loyaltymember;

-- 4. Gender segmentation for members and non-members
DROP VIEW IF EXISTS loyalty_sales_gender;
CREATE VIEW loyalty_sales_gender AS 
SELECT
    gender,
    loyaltymember AS loyalty_member,
    SUM(totalprice) AS sales,
    COUNT(customerid) AS sales_count,
    ROUND(SUM(totalprice) / COUNT(customerid), 2) AS AOV
FROM (
    SELECT
        customerid,
        totalprice,
        gender,
        loyaltymember
    FROM sales
    WHERE orderstatus = 'Completed'
) sub
GROUP BY gender, loyaltymember
ORDER BY gender DESC, loyaltymember;

-- 5. Add-on purchases comparison for members and non-members
DROP VIEW IF EXISTS loyalty_addon;
CREATE VIEW loyalty_addon AS 
SELECT
    loyaltymember,
    SUM(addonstotal) AS addon_sales,
    SUM(CASE WHEN addonspurchased IS NULL THEN 0 ELSE 1 END) AS addon_purchase_count,
    ROUND(SUM(addonstotal) / NULLIF(SUM(CASE WHEN addonspurchased IS NULL THEN 0 ELSE 1 END), 0), 2) AS addon_AOV,
    CAST(SUM(CASE WHEN addonspurchased IS NULL THEN 0 ELSE 1 END) AS DECIMAL(10, 2)) 
        / CAST(COUNT(customerid) AS DECIMAL(10, 2)) AS addon_purchase_rate
FROM sales
WHERE orderstatus = 'Completed'
GROUP BY loyaltymember;

-- 6. Return rate comparison for members and non-members
DROP VIEW IF EXISTS loyalty_return;
CREATE VIEW loyalty_return AS 
SELECT
    loyaltymember,
    CAST(SUM(CASE WHEN orderstatus = 'Cancelled' THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) 
        / CAST(COUNT(customerid) AS DECIMAL(10, 2)) AS return_rate
FROM sales
GROUP BY loyaltymember;

-- 7. Monthly trend analysis for members and non-members
DROP VIEW IF EXISTS loyalty_trend;
CREATE VIEW loyalty_trend AS 
SELECT
    TO_CHAR(purchasedate, 'YYYY-MM') AS month,
    SUM(CASE WHEN loyaltymember = 'Yes' THEN totalprice ELSE 0 END) AS member_sales,
    SUM(CASE WHEN loyaltymember = 'No' THEN totalprice ELSE 0 END) AS non_member_sales,
    SUM(CASE WHEN loyaltymember = 'Yes' THEN 1 ELSE 0 END) AS member_buy,
    SUM(CASE WHEN loyaltymember = 'No' THEN 1 ELSE 0 END) AS non_member_buy,
    ROUND(SUM(CASE WHEN loyaltymember = 'Yes' THEN totalprice ELSE 0 END) 
        / NULLIF(SUM(CASE WHEN loyaltymember = 'Yes' THEN 1 ELSE 0 END), 0), 2) AS member_AOV,
    ROUND(SUM(CASE WHEN loyaltymember = 'No' THEN totalprice ELSE 0 END) 
        / NULLIF(SUM(CASE WHEN loyaltymember = 'No' THEN 1 ELSE 0 END), 0), 2) AS non_member_AOV
FROM sales
WHERE orderstatus = 'Completed'
GROUP BY TO_CHAR(purchasedate, 'YYYY-MM')
ORDER BY month;
