# Data Dictionary

## Dataset

DataCo Smart Supply Chain dataset.

## Key Fields

| Field | Description | Usage |
|---|---|---|
| Order Id | Unique identifier for an order | Order-level analysis |
| Order Item Id | Unique identifier for an order item | Item-level analysis |
| Order Region | Geographic region associated with the order | Regional delivery analysis |
| Market | Market grouping | Dashboard filtering |
| Category Name | Product category | Category analysis |
| Shipping Mode | Shipping method used | Delivery performance analysis |
| Delivery Status | Recorded delivery outcome | Delivery analysis |
| Late_delivery_risk | Dataset-provided late-delivery indicator | Governed late-order definition |
| Days for shipping (real) | Actual shipping duration in days | Delay analysis |
| Days for shipment (scheduled) | Scheduled shipping duration in days | Delay analysis |
| Sales | Sales value associated with the order item | Revenue/profit analysis |
| Order Profit Per Order | Recorded profit value | Profit analysis |
| Order Item Discount | Discount amount | Pricing analysis |
| Order Item Discount Rate | Discount rate | Pricing analysis |
| Order Item Quantity | Quantity of items | Volume analysis |
| order date (DateOrders) | Order date and time | Time-series analysis |
| Product Name | Product name | Product analysis |
| Customer Segment | Customer segment | Segmentation |
| Order Status | Order status | Order analysis |

## Key Measures

### Total Orders

Distinct count of `Order Id`.

### Late Orders

Distinct count of orders where `Late_delivery_risk = 1`.

### Late Delivery Rate

Late Orders divided by Total Orders.

### Total Profit

Sum of `Order Profit Per Order`.

### Profit Margin

Total Profit divided by Sales.

### Average Delay Days

Average of:

`max(0, actual shipping days - scheduled shipping days)`

Early shipments are treated as zero delay.

## Metric Governance

The dataset's `Late_delivery_risk` field is used as the governed definition
for late orders.

A validation check compared this field against an independently calculated
actual-versus-scheduled shipping delay indicator. The definitions agreed
for 176,096 records, while 4,423 records differed. The provided
`Late_delivery_risk` field was therefore retained for reporting consistency.