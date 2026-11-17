# Construction Procurement & Supplier Performance Analysis

## Overview
This project is an independent portfolio project designed to analyze procurement data for a construction company. It uses SQL to evaluate supplier performance, RFQ response rates, and cost variances.

## Database Schema
The database consists of 5 tables: `projects`, `suppliers`, `rfqs`, `quotations`, and `purchases`.

## Key Business Questions Answered
1. Which suppliers offer the most competitive prices?
2. Which trades have the highest price variance?
3. How much did we save/lose compared to the average quote?
4. (List all 10 questions here)

## Key Insights
- **Price Variance:** Groundworks has the highest price fluctuation (e.g., £45k to £52k).
- **Supplier Performance:** Sparky Solutions submitted the most competitive quote for Electrical but took 2 days longer to respond.
- (Add 2-3 findings from your actual query results here)

## How to Run
1. Run `schema.sql` to create tables.
2. Run `data_insert.sql` to populate data.
3. Run `queries.sql` to see the analysis.
