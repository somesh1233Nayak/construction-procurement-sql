-- =====================================================================
-- PROJECT: Construction Procurement & Supplier Performance Analysis
-- FILE: queries.sql
-- DESCRIPTION: 10 Business Questions answered using SQL
-- =====================================================================

-- ---------------------------------------------------------------------
-- Q1: Which suppliers consistently submit the most competitive quotations?
-- (Find the average quotation price offered by each supplier)
-- ---------------------------------------------------------------------
SELECT 
    s.supplier_name,
    s.trade_category,
    ROUND(AVG(q.price), 2) AS avg_quote_price
FROM suppliers s
JOIN quotations q ON s.supplier_id = q.supplier_id
GROUP BY s.supplier_name, s.trade_category
ORDER BY avg_quote_price ASC;


-- ---------------------------------------------------------------------
-- Q2: Which trades have the highest quotation price variation?
-- (Calculate the difference between the highest and lowest quote for each trade)
-- ---------------------------------------------------------------------
SELECT 
    r.trade,
    MAX(q.price) AS highest_quote,
    MIN(q.price) AS lowest_quote,
    (MAX(q.price) - MIN(q.price)) AS price_variance
FROM rfqs r
JOIN quotations q ON r.rfq_id = q.rfq_id
GROUP BY r.trade
ORDER BY price_variance DESC;


-- ---------------------------------------------------------------------
-- Q3: Which RFQs receive the fewest supplier responses?
-- (Count how many quotations were received for each RFQ)
-- ---------------------------------------------------------------------
SELECT 
    r.rfq_id,
    r.trade,
    COUNT(q.quote_id) AS total_quotes_received
FROM rfqs r
LEFT JOIN quotations q ON r.rfq_id = q.rfq_id
GROUP BY r.rfq_id, r.trade
ORDER BY total_quotes_received ASC;


-- ---------------------------------------------------------------------
-- Q4: How much does the selected quotation differ from the average quotation?
-- (Compare final selected price vs average quote received for that RFQ)
-- ---------------------------------------------------------------------
SELECT 
    p.purchase_id,
    r.trade,
    p.final_price AS selected_price,
    ROUND(AVG(q.price), 2) AS average_quote_price,
    ROUND(p.final_price - AVG(q.price), 2) AS difference_from_average
FROM purchases p
JOIN quotations q_selected ON p.quote_id = q_selected.quote_id
JOIN rfqs r ON q_selected.rfq_id = r.rfq_id
JOIN quotations q ON r.rfq_id = q.rfq_id
GROUP BY p.purchase_id, r.trade, p.final_price;


-- ---------------------------------------------------------------------
-- Q5: Which suppliers have the best (fastest) response time?
-- (Calculate average days taken to submit a quote after RFQ is sent)
-- ---------------------------------------------------------------------
SELECT 
    s.supplier_name,
    ROUND(AVG(DATEDIFF(q.date_received, r.date_sent)), 1) AS avg_response_days
FROM suppliers s
JOIN quotations q ON s.supplier_id = q.supplier_id
JOIN rfqs r ON q.rfq_id = r.rfq_id
GROUP BY s.supplier_name
ORDER BY avg_response_days ASC;


-- ---------------------------------------------------------------------
-- Q6: Which projects have the highest quoted cost relative to budget?
-- (Find projects where total final purchase cost exceeds the initial budget)
-- ---------------------------------------------------------------------
SELECT 
    p.project_name,
    p.budget,
    SUM(pur.final_price) AS total_spent,
    (SUM(pur.final_price) - p.budget) AS overrun_amount
FROM projects p
JOIN rfqs r ON p.project_id = r.project_id
JOIN quotations q ON r.rfq_id = q.rfq_id
JOIN purchases pur ON q.quote_id = pur.quote_id
GROUP BY p.project_id, p.project_name, p.budget
HAVING total_spent > p.budget;


-- ---------------------------------------------------------------------
-- Q7: What is the supplier participation rate by trade?
-- (Count the number of unique suppliers who submitted quotes per trade)
-- ---------------------------------------------------------------------
SELECT 
    r.trade,
    COUNT(DISTINCT q.supplier_id) AS unique_suppliers_quoted
FROM rfqs r
JOIN quotations q ON r.rfq_id = q.rfq_id
GROUP BY r.trade
ORDER BY unique_suppliers_quoted DESC;


-- ---------------------------------------------------------------------
-- Q8: How many RFQs convert into purchases?
-- (Calculate the percentage of RFQs that resulted in a successful purchase)
-- ---------------------------------------------------------------------
SELECT 
    COUNT(DISTINCT r.rfq_id) AS total_rfqs,
    COUNT(DISTINCT q.rfq_id) AS rfqs_with_purchases,
    ROUND((COUNT(DISTINCT q.rfq_id) * 100.0) / COUNT(DISTINCT r.rfq_id), 2) AS conversion_rate_percentage
FROM rfqs r
LEFT JOIN quotations q ON r.rfq_id = q.rfq_id
LEFT JOIN purchases p ON q.quote_id = p.quote_id
WHERE p.purchase_id IS NOT NULL;


-- ---------------------------------------------------------------------
-- Q9: Which suppliers have the highest purchase value?
-- (Find the top 3 suppliers with the highest total revenue generated)
-- ---------------------------------------------------------------------
SELECT 
    s.supplier_name,
    COUNT(p.purchase_id) AS total_deals_won,
    SUM(p.final_price) AS total_revenue_generated
FROM suppliers s
JOIN quotations q ON s.supplier_id = q.supplier_id
JOIN purchases p ON q.quote_id = p.quote_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_revenue_generated DESC
LIMIT 3;


-- ---------------------------------------------------------------------
-- Q10: Rank suppliers based on average quote price within their trade
-- (Using Window Function to rank cheapest suppliers per trade)
-- ---------------------------------------------------------------------
WITH SupplierAvg AS (
    SELECT 
        s.trade_category,
        s.supplier_name,
        AVG(q.price) AS avg_price
    FROM suppliers s
    JOIN quotations q ON s.supplier_id = q.supplier_id
    GROUP BY s.trade_category, s.supplier_name
)
SELECT 
    trade_category,
    supplier_name,
    ROUND(avg_price, 2) AS avg_price,
    RANK() OVER(PARTITION BY trade_category ORDER BY avg_price ASC) AS price_rank
FROM SupplierAvg;
