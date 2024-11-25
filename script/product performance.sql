-- Clean up invalid or inconsistent data
DELETE FROM sales
WHERE 
    (addonspurchased IS NULL AND addonstotal <> 0) 
    OR 
    (addonspurchased IS NOT NULL AND addonstotal = 0);

-- Update SKUs for each product type
UPDATE sales
SET sku = 'SKU1006'
WHERE producttype = 'Smartwatch' AND sku = 'SKU1003';

UPDATE sales
SET sku = 'SKU1007'
WHERE producttype = 'Laptop' AND sku = 'SKU1004';

UPDATE sales
SET sku = 'SKU1008'
WHERE producttype = 'Laptop' AND sku = 'SKU1005';

UPDATE sales
SET sku = 'HDP1001'
WHERE producttype = 'Headphones' AND sku = 'HDP456';

UPDATE sales
SET sku = 'HDP1002'
WHERE producttype = 'Headphones' AND sku = 'SKU1003';

UPDATE sales
SET sku = 'LTP1001'
WHERE producttype = 'Laptop' AND sku = 'LTP123';

UPDATE sales
SET sku = 'LTP1002'
WHERE producttype = 'Laptop' AND sku = 'SKU1007';

UPDATE sales
SET sku = 'LTP1003'
WHERE producttype = 'Laptop' AND sku = 'SKU1008';

UPDATE sales
SET sku = 'SMP1001'
WHERE producttype = 'Smartphone' AND sku = 'SKU1001';

UPDATE sales
SET sku = 'SMP1002'
WHERE producttype = 'Smartphone' AND sku = 'SKU1004';

UPDATE sales
SET sku = 'SMP1003'
WHERE producttype = 'Smartphone' AND sku = 'SKU1005';

UPDATE sales
SET sku = 'SMP1004'
WHERE producttype = 'Smartphone' AND sku = 'SMP234';

UPDATE sales
SET sku = 'SWT1001'
WHERE producttype = 'Smartwatch' AND sku = 'SKU1006';

UPDATE sales
SET sku = 'SWT1002'
WHERE producttype = 'Smartwatch' AND sku = 'SWT567';

UPDATE sales
SET sku = 'TBL1001'
WHERE producttype = 'Tablet' AND sku = 'SKU1002';

UPDATE sales
SET sku = 'TBL1002'
WHERE producttype = 'Tablet' AND sku = 'TBL345';

-- Create or recreate the product performance view
DROP VIEW IF EXISTS product_performance;

CREATE VIEW product_performance AS
SELECT
    producttype AS product_type,
    sku,
    TO_CHAR(purchasedate, 'YYYY-MM') AS year_month,
    paymentmethod AS payment_method,
    shippingtype AS shipping_type,
    SUM(totalprice) AS sales,
    SUM(quantity) AS quantity,
    SUM(addonstotal) AS addon_sales,
    SUM(
        COALESCE(
            ARRAY_LENGTH(STRING_TO_ARRAY(addonspurchased, ','), 1),
            0
        )
    ) AS addon_count,
    CAST(
        SUM(CASE WHEN addonspurchased IS NULL THEN 0 ELSE 1 END) AS DECIMAL(10, 2)
    ) AS addon_purchase,
    CAST(
        SUM(CASE WHEN orderstatus = 'Cancelled' THEN 1 ELSE 0 END) AS DECIMAL(10, 2)
    ) AS purchase_cancel,
    COUNT(customerid) AS order_count,
    SUM(rating) AS sum_rating
FROM sales
GROUP BY 
    producttype, 
    sku, 
    TO_CHAR(purchasedate, 'YYYY-MM'),
    paymentmethod, 
    shippingtype;



