# Supply Chain Disruption Analysis

## Business Question

A CPG company is missing delivery promises. Which regions, shipping modes,
and product categories are associated with late deliveries and profit exposure,
and where should the team investigate first?

## Project Overview

This project analyzes the DataCo Smart Supply Chain dataset to understand
delivery performance, operational risk, and profit exposure.

The analysis combines SQL and Power BI to provide a business-ready analytical
view of supply chain performance.

## Dashboard

### Main Dashboard

![Supply Chain Disruption Dashboard](screenshots/dashboard.png)

### Drill-down Analysis

![Region to Category Drill-down](screenshots/drilldown.png)

## Tech Stack

- SQL / MySQL
- Power BI
- Power Query
- DAX
- Dimensional modeling

## Data Pipeline

Raw CSV
→ Power Query cleaning
→ Cleaned analytical dataset
→ Semantic model
→ DAX measures
→ Power BI dashboard

## Key Analysis

- Overall delivery performance
- Late delivery rate by region
- Late delivery rate by shipping mode
- Monthly late delivery trend
- Profit exposure by product category
- Region → category drill-down
- Category-region analysis using SQL window functions

## Key Findings

- 65,752 distinct orders were analyzed, with a 54.82% late-delivery rate.
- Total recorded order profit was approximately $3.97M.
- First Class and Second Class shipping modes had substantially higher
  late-delivery rates than Standard Class and Same Day.
- High-volume categories such as Cleats, Men's Footwear and Women's Apparel
  account for a large number of late items.
- Late-delivery items had slightly lower average profit per item
  (21.62 vs 22.40) and profit margin (10.63% vs 10.97%) than non-late items.
- Regional and shipping-mode combinations show substantial variation in
  late-delivery rates.

These findings describe associations in the dataset and do not establish
causality.

## Data Quality

- 180,519 records
- 0 duplicate rows
- 0 duplicate Order Item IDs
- 155,679 missing Order Zipcodes
- 3 missing Customer Zipcodes
- 8 missing Customer Last Names
- 0 negative actual shipping durations
- 4,423 differences between the calculated shipping-delay indicator and
  the provided `Late_delivery_risk` flag

The provided `Late_delivery_risk` field was retained as the governed
definition for late orders.

## Dashboard Features

The Power BI dashboard provides:

- KPI summary
- Regional delivery risk
- Shipping-mode comparison
- Monthly delivery trend
- Product-category profit exposure
- Interactive Market, Category and Year filters
- Region → Category drill-down