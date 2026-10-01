-- ============================================================
-- SUPPLY CHAIN DISRUPTION ANALYSIS
-- SQL BUSINESS ANALYSIS
-- ============================================================

USE supply_chain;


-- ============================================================
-- Q1. Overall Delivery Performance
-- ============================================================

SELECT
    COUNT(DISTINCT `Order Id`) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN `Late_delivery_risk` = 1
        THEN `Order Id`
    END) AS late_orders,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN `Late_delivery_risk` = 1
            THEN `Order Id`
        END) / COUNT(DISTINCT `Order Id`),
        2
    ) AS late_rate_pct,
    ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit,
    ROUND(AVG(`Days for shipping (real)`), 2) AS avg_actual_shipping_days,
    ROUND(AVG(`Days for shipment (scheduled)`), 2) AS avg_scheduled_shipping_days
FROM orders;


-- ============================================================
-- Q2. Delivery Performance by Region
-- ============================================================

SELECT
    `Order Region` AS region,
    COUNT(DISTINCT `Order Id`) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN `Late_delivery_risk` = 1
        THEN `Order Id`
    END) AS late_orders,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN `Late_delivery_risk` = 1
            THEN `Order Id`
        END) / COUNT(DISTINCT `Order Id`),
        2
    ) AS late_rate_pct,
    ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit
FROM orders
GROUP BY `Order Region`
ORDER BY late_rate_pct DESC;


-- ============================================================
-- Q3. Delivery Performance by Shipping Mode
-- ============================================================

SELECT
    `Shipping Mode` AS shipping_mode,
    COUNT(DISTINCT `Order Id`) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN `Late_delivery_risk` = 1
        THEN `Order Id`
    END) AS late_orders,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN `Late_delivery_risk` = 1
            THEN `Order Id`
        END) / COUNT(DISTINCT `Order Id`),
        2
    ) AS late_rate_pct,
    ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit
FROM orders
GROUP BY `Shipping Mode`
ORDER BY late_rate_pct DESC;


-- ============================================================
-- Q4. Category Risk and Profit
-- ============================================================

SELECT
    `Category Name` AS category,
    COUNT(*) AS order_items,
    SUM(CASE
        WHEN `Late_delivery_risk` = 1
        THEN 1 ELSE 0
    END) AS late_items,
    ROUND(
        100.0 * SUM(CASE
            WHEN `Late_delivery_risk` = 1
            THEN 1 ELSE 0
        END) / COUNT(*),
        2
    ) AS late_rate_pct,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit
FROM orders
GROUP BY `Category Name`
ORDER BY late_rate_pct DESC;


-- ============================================================
-- Q5. Late vs Non-Late Profitability
-- ============================================================

SELECT
    CASE
        WHEN `Late_delivery_risk` = 1 THEN 'Late'
        ELSE 'Not Late'
    END AS delivery_group,
    COUNT(*) AS order_items,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit,
    ROUND(AVG(`Order Profit Per Order`), 2) AS avg_profit_per_item,
    ROUND(
        100.0 * SUM(`Order Profit Per Order`) / SUM(Sales),
        2
    ) AS profit_margin_pct
FROM orders
GROUP BY
    CASE
        WHEN `Late_delivery_risk` = 1 THEN 'Late'
        ELSE 'Not Late'
    END
ORDER BY delivery_group;


-- ============================================================
-- Q6. Region × Shipping Mode Delivery Performance
-- ============================================================

SELECT
    `Order Region` AS region,
    `Shipping Mode` AS shipping_mode,
    COUNT(DISTINCT `Order Id`) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN `Late_delivery_risk` = 1
        THEN `Order Id`
    END) AS late_orders,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN `Late_delivery_risk` = 1
            THEN `Order Id`
        END) / COUNT(DISTINCT `Order Id`),
        2
    ) AS late_rate_pct
FROM orders
GROUP BY
    `Order Region`,
    `Shipping Mode`
ORDER BY late_rate_pct DESC;


-- ============================================================
-- Q7. Top 3 Regions by Late Rate Within Each Category
-- Uses CTE + Window Function
-- ============================================================

WITH category_region AS (
    SELECT
        `Category Name` AS category,
        `Order Region` AS region,
        COUNT(*) AS order_items,
        SUM(CASE
            WHEN `Late_delivery_risk` = 1
            THEN 1 ELSE 0
        END) AS late_items,
        ROUND(
            100.0 * SUM(CASE
                WHEN `Late_delivery_risk` = 1
                THEN 1 ELSE 0
            END) / COUNT(*),
            2
        ) AS late_rate_pct
    FROM orders
    GROUP BY
        `Category Name`,
        `Order Region`
),
ranked_regions AS (
    SELECT
        category,
        region,
        order_items,
        late_items,
        late_rate_pct,
        RANK() OVER (
            PARTITION BY category
            ORDER BY late_rate_pct DESC
        ) AS region_rank
    FROM category_region
)
SELECT
    category,
    region,
    order_items,
    late_items,
    late_rate_pct,
    region_rank
FROM ranked_regions
WHERE region_rank <= 3
ORDER BY
    category,
    region_rank;