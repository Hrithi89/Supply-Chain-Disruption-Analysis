# Data Quality Log

## Source

DataCo Smart Supply Chain dataset.

## Initial Dataset

- Records: 180,519
- Columns: 53

## Duplicate Checks

| Check | Result | Action |
|---|---:|---|
| Duplicate rows | 0 | No action |
| Duplicate Order Item IDs | 0 | No action |

## Missing Values

| Field | Missing Records | Action |
|---|---:|---|
| Order Zipcode | 155,679 | Removed |
| Customer Zipcode | 3 | Removed |
| Customer Lname | 8 | Removed |
| Product Description | 180,519 | Removed |

## Removed / Excluded Fields

The following fields were removed because they were masked, empty,
constant, not required for the analysis, or unsuitable for the dashboard:

- Customer Email
- Customer Password
- Product Description
- Product Status
- Product Image
- Order Zipcode
- Customer Fname
- Customer Lname
- Customer Zipcode

## Data Type Checks

- Monetary fields were converted to fixed decimal where appropriate.
- Discount rate was retained as a decimal and formatted as a percentage
  in Power BI.
- Count and identifier fields were treated as whole numbers.
- Date fields were converted to date/time types in Power Query.

## Delivery Validation

A calculated indicator was created using:

`Days for shipping (real) > Days for shipment (scheduled)`

Comparison with `Late_delivery_risk` produced:

- Matching records: 176,096
- Mismatching records: 4,423

The provided `Late_delivery_risk` field was retained as the governed
definition for the dashboard.

## Shipping Duration Validation

| Check | Result |
|---|---:|
| Negative actual shipping duration | 0 |
| Negative scheduled shipping duration | 0 |

## Final Analytical Dataset

- Records: 180,519
- Duplicate rows: 0
- Duplicate Order Item IDs: 0