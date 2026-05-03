--class 25/04/2026
--creating database [database_name]
create database BikeStores;

SELECT * FROM sales.customers;

SELECT * FROM production.products;

select product_id, product_name FROM production.products;

select * from sales.orders;

select * from sales.orders 
where order_id = 94;

select first_name, last_name from sales.customers
where customer_id = 94;

--class 26/04/2026
--ORDER OF EXECUTION

SELECT * FROM sales.customers 
where city = 'New York';

SELECT * FROM sales.customers
where state = 'NY';

--FILTERATION QUERIES
-- Order By
--Syntax
/*
SELECT
	select_list [any columns]
FROM
	table_name
ORDER BY
	column_name | expression [ ASC | DSC ]
*/

SELECT
	first_name, last_name
FROM
	sales.customers
ORDER BY
	first_name; --ASC [data is in ascending order by default]

--for descending
SELECT
	first_name, last_name
FROM
	sales.customers
ORDER BY
	first_name DESC;

--Sort a result by multiple columns

SELECT city, first_name, last_name
FROM sales.customers
ORDER BY city, first_name; --sorts data by given order by columns give priority to the first column

SELECT city, first_name, last_name
FROM sales.customers
ORDER BY city ASC, first_name DESC;

SELECT * FROM production.products
ORDER BY model_year ASC, list_price DESC;

SELECT * FROM sales.orders
ORDER BY order_id ASC;

SELECT * FROM sales.orders
ORDER BY order_date DESC;

SELECT
	city, first_name, last_name
FROM
	sales.customers
WHERE
	state = 'NY'
ORDER BY
	city; --order of execution => FROM > WHERE > ORDER BY > SELECT

--LIMITING ROW
--TOP N [where N = no. of rows]

SELECT TOP 10
	product_id, product_name, list_price
FROM production.products
ORDER BY list_price DESC;

SELECT TOP 10
	product_id, product_name, list_price
FROM production.products
ORDER BY list_price ASC;

--LIMIT 10 -- POSTGRES SQL
--TOTAL RECORDS IN PRODUCTS TABLE 321
-- 1% = 3.21
-- ROUND UP TO 4

SELECT TOP 1 PERCENT
	*
FROM production.products
ORDER BY list_price ASC;

--OFFSET AND FETCH [Used with order by, counter error if order by is missing]
--OFFSET [skips rows] , FETCH [provide data after OFFSET]

SELECT 
	*
FROM production.products
ORDER BY list_price DESC
OFFSET 5 ROWS
FETCH NEXT 20 ROWS ONLY;

--DISTINCT [query will return unique values]
--SYNTAX [SELECT DISTINCT column_name FROM table_name]

SELECT city
FROM sales.customers
ORDER BY city;

SELECT DISTINCT city
FROM sales.customers
ORDER BY city;

SELECT DISTINCT state
FROM sales.customers
ORDER BY state;

SELECT DISTINCT state, city
FROM sales.customers
ORDER BY state;

SELECT DISTINCT phone
FROM sales.customers

--LOGICAL OPERATORS [ AND | OR ]
--AND [ CONDITION IS TRUE > IF CONDITION 1 AND 2 TRUE ]
--OR [ CONDITION IS TRUE > IF CONDITION 1 OR 2 2 IS TRUE ]

SELECT 
	* 
FROM production.products
WHERE list_price > 400 AND list_price < 500
ORDER BY list_price;

SELECT * FROM production.products
WHERE category_id = 1 and list_price > 500
ORDER BY list_price DESC;

SELECT * FROM production.products
WHERE category_id = 1 OR list_price > 400
ORDER BY list_price DESC;

SELECT * FROM production.products
WHERE list_price > 300 AND model_year = 2018
ORDER BY list_price DESC;

SELECT * FROM production.products
WHERE (brand_id = 1 OR brand_id = 2) AND list_price > 1000
ORDER BY list_price ASC;

--class 02/05/2026
SELECT * --use brackets to prioritize results and filter accordingly
FROM production.products
WHERE list_price > 1000 AND brand_id = 1
	OR brand_id = 2;

SELECT *
FROM production.products
WHERE list_price = 2999.99 OR
list_price = 2599.99 OR
list_price = 1199.99 OR
list_price = 2799.99;

-- IN OPERATOR [to filter multiple results, best to use this instead of OR]
SELECT *
FROM production.products
WHERE list_price IN (2999.99, 2599.99, 1199.99, 2799.99);

SELECT *
FROM production.products
WHERE list_price NOT IN (2999.99, 2599.99, 1199.99, 2799.99);

--BETWEEN
SELECT *
FROM production.products
WHERE list_price BETWEEN 1199.99 AND 2999.99;

SELECT *
FROM production.products
WHERE list_price NOT BETWEEN 1199.99 AND 2999.99;

SELECT * FROM sales.orders
WHERE order_date BETWEEN '2016-01-01' AND '2016-01-31';

-- Alias
-- column and tables
SELECT product_name as prd_name
FROM production.products;

--customer full name
--Abdul Basit -- AbdulBasit [need to add a space]
SELECT first_name + ' ' + last_name as full_name
FROM sales.customers

--like
-- logical operator that checks or matches with specified string/text
-- used with wild card % _ ^ []

-- % - represent multiple characters
SELECT customer_id, first_name, last_name FROM sales.customers
WHERE first_name LIKE 'A%'
ORDER BY first_name;

SELECT customer_id, first_name, last_name FROM sales.customers
WHERE first_name LIKE '%a'
ORDER BY first_name;

SELECT customer_id, first_name, last_name FROM sales.customers
WHERE last_name LIKE 'T%n' 
ORDER BY first_name;

--use dash (_) to check a single character

SELECT customer_id, first_name, last_name FROM sales.customers
WHERE last_name LIKE '_a%' 
ORDER BY first_name;

SELECT customer_id, first_name, last_name FROM sales.customers
WHERE first_name NOT LIKE 'A%' 
ORDER BY first_name;

--JOINS

create schema hr;
go

create table hr.candidates(
	id int primary key identity,
	fullname varchar(100) not null);

create table hr.employees(
	id int primary key identity,
	fullname varchar(100) not null);


insert into 
	hr.candidates(fullname)
values
	('Saad'),
	('Mohsin'),
	('Owais'),
	('Haseeb')

insert into 
	hr.employees(fullname)
values
	('Haseeb'),
	('Saad'),
	('Bilal'),
	('Adnan')

select * from hr.candidates

select * from hr.employees

--SYNTAX
--select * from [table_1] inner join table_2 on table_1.column = table_2.column
--INNER JOIN

SELECT candidates.fullname FROM hr.candidates
INNER JOIN hr.employees
	ON candidates.fullname = employees.fullname

select product_name, category_id, list_price
from production.products
order by product_name desc;

select product_name, list_price, p.category_id from production.products as p
inner join production.categories as c 
on c.category_id = p.category_id;

--customer full name, order status, order date
select first_name + ' ' + last_name as fullname, order_status, order_date from sales.customers
inner join sales.orders
on customers.customer_id = orders.customer_id;

select product_name, brand_name from production.brands as b
inner join production.products as p on b.brand_id = p.brand_id;

-- class 03/05/2026
