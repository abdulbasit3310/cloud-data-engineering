-- SQL QUERY STATEMENTS

-- 1. SELECT

-- SYNTAX:
-- SELECT
-- select_list
-- FROM
--	schema_name.table_name;

-- EXAMPLE:
SELECT
    first_name,
    last_name,
    email
FROM
    sales.customers;

-- using SELECT to retrieve all columns from a table 
SELECT * FROM sales.customers;

-- however, you should not use * everytime to get results

-- 2. ORDER BY
-- sort the results based on values of columns provided

/* 
SYNTAX:
SELECT
    select_list
FROM
    table_name
ORDER BY 
    column_name | expression [ASC | DESC ];
*/

-- in case of multiple columns, order by gives priority to sort acc to first column and so on.
-- if sort is not specified as ASC or DESC the result is sorted to ASC by default.

-- EXAMPLE:
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;


-- Sorting results by multiple columns
SELECT 
    first_name,
    last_name,
    city
FROM
    sales.customers
ORDER BY
    city,
    first_name;

-- sorting multiple columns in different orders
SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city DESC,
    first_name ASC;

-- sorting result by a column that is not listed in SELECT clause
-- but remember, the column should be present in the table selected in FROM clause.

SELECT
    state,
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    state;

-- sort result by an expression
-- LEN()
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;

-- 3. OFFSET AND FETCH
-- it requires ORDER BY clause to function properly

-- SYNTAX:
/* 
ORDER BY column_list [ASC |DESC]
OFFSET offset_row_count {ROW | ROWS}
FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY
*/

-- OFFSET: drops rows, mandatory in clause
-- FETCH: retrieves rows, OFFSET is required to function

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name;

-- APPLYING OFFSET:
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name
OFFSET 10 ROWS; 

-- APPLYING FETCH
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;

-- Using the OFFSET FETCH clause to get the top N rows
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC,
    product_name 
OFFSET 0 ROWS 
FETCH FIRST 10 ROWS ONLY;

--4. SELECT TOP
-- use to limit rows returned by a query
-- always be used with ORDER BY clause

-- SYTAX:
/*
SELECT TOP (expression) [PERCENT]
    [WITH TIES]
FROM 
    table_name
ORDER BY 
    column_name;
*/

-- other clauses also be icluded such as WHERE, JOIN, GROUP BY, HAVING

-- EXAMPLES:
SELECT TOP 10
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;

SELECT TOP 1 PERCENT
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;

-- SELECT DISTINCT
-- returns only distinct values in a column of a table

/*
SYNTAX:
SELECT 
  DISTINCT column_name 
FROM 
  table_name;

FOR MULTIPLE COLUMNS:
SELECT DISTINCT
	column_name1,
	column_name2 ,
	...
FROM
	table_name;
*/

-- EXAMPLE:
SELECT 
  city 
FROM 
  sales.customers 
ORDER BY 
  city; -- shows all the cities (repeated)

SELECT DISTINCT
  city 
FROM 
  sales.customers 
ORDER BY 
  city; -- shows every city only once

-- MULTIPLE COLUMNS
SELECT 
  city, 
  state 
FROM 
  sales.customers 
ORDER BY 
  city, 
  state; --duplicate values of city and state

SELECT DISTINCT
  city, 
  state 
FROM 
  sales.customers

SELECT
    DISTINCT phone
FROM
    sales.customers
ORDER BY
    phone;

-- DISTINCT VS GROUP BY 
SELECT 
  city, 
  state, 
  zip_code 
FROM 
  sales.customers 
GROUP BY 
  city, 
  state, 
  zip_code 
ORDER BY 
  city, 
  state, 
  zip_code -- GROUP BY

SELECT 
  DISTINCT city, state, zip_code 
FROM 
  sales.customers; -- DISTINCT

-- both queries return same results when executed.
-- group by is used when applying aggregate functions.

