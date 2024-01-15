-- show customers table
SELECT *
FROM customers;

-- show date table
SELECT *
FROM date;

-- show markets table
SELECT *
FROM markets;

-- show products table
SELECT *
FROM products;

-- show transactions table
SELECT *
FROM transactions;

-- change column name proft_margin to profit
ALTER TABLE transactions
CHANGE COLUMN profit_margin profit DOUBLE;

-- change column name proft_margin_percentage to profit_margin
ALTER TABLE transactions
CHANGE COLUMN profit_margin_percentage profit_margin DOUBLE;

-- show total revenue and currency standardise
SELECT SUM(normalized_amount)
FROM
(SELECT *, 
CASE
	WHEN currency = 'INR' THEN sales_amount*1
    WHEN currency = 'USD' THEN sales_amount*74

ELSE sales_amount
END as normalized_amount

FROM transactions) as transaction2;

-- create view for table with normalized amount
CREATE VIEW combinetable AS 
(SELECT *,
CASE
	WHEN currency = 'INR' THEN sales_amount*1
    WHEN currency = 'USD' THEN sales_amount*74

ELSE sales_amount
END as normalized_amount

FROM 
(
SELECT *
FROM transactions t
JOIN date d ON t.order_date = d.date) as combinetable);

-- show combine table
SELECT *
FROM combinetable;

-- join table all
CREATE VIEW combinetableall AS 
(SELECT ct.product_code, 
        ct.customer_code, 
        ct.market_code, 
        ct.order_date, 
        ct.sales_qty,
        ct.sales_amount,
        ct.currency,
        ct.profit,
        ct.profit_margin,
        ct.cost_price,
		ct.normalized_amount,
        ct.date,
        ct.cy_date,
        ct.year,
        ct.month_name,
        ct.date_yy_mmm,
        m.markets_name,
        m.zone,
        c.custmer_name,
        c.customer_type
FROM combinetable ct
JOIN markets m ON ct.market_code = m.markets_code
JOIN customers c ON ct.customer_code = c.customer_code);


-- show combinetableall
SELECT *
FROM combinetableall;

-- calculate total profit
SELECT SUM(profit)
FROM combinetableall;

-- calculate total revenue
SELECT SUM(normalized_amount)
FROM combinetableall;



