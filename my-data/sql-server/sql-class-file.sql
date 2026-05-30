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
-- LEFT JOIN
SELECT * 
FROM 
	production.products p
JOIN sales.order_items oi --4722 records
	ON p.product_id = oi.product_id --only join means inner join

SELECT 
	product_id, product_name
FROM 
	production.products p
left JOIN sales.order_items oi
	ON p.product_id = oi.product_id
ORDER BY order_id;

--product_name, order_id, order_date, product_id
--retrieve these 4 columns using left join
SELECT 
    p.product_name,
    p.product_id,
    o.order_id,
    o.order_date
FROM 
    production.products p
LEFT JOIN 
    sales.order_items oi ON p.product_id = oi.product_id
LEFT JOIN 
    sales.orders o ON oi.order_id = o.order_id;
-- TIP: we first define right table and then left table
SELECT
	p.product_name,
	oi.order_id
FROM
	sales.order_items oi --left table
RIGHT JOIN
	production.products p ON oi.product_id = p.product_id--right table

SELECT *
FROM
	sales.staffs s
RIGHT JOIN
	sales.stores ss ON s.store_id = ss.store_id;

-- cross join
-- syntax
-- SELECT select_list
-- FROM table_t1
-- CROSS JOIN table_t2;

SELECT *
FROM 
	sales.order_items
CROSS JOIN 
	production.products

-- SELF JOIN [alias is very imp]
select * from sales.staffs s1 inner join sales.staffs s2 on s1.staff_id = s2.manager_id

-- class 09/05/2026

-- GROUP BY
-- Grouping / categorizing same values

-- SYNTAX
-- SELECT column1, aggregate_function(column2)
-- FROM table_name
-- WHERE condition
-- GROUP BY column1
-- ORDER BY column1;

-- date functions
-- year(date), day, month
SELECT 
	customer_id, year(order_date) as order_year
FROM
	sales.orders
WHERE
	customer_id in (1,2)
GROUP BY
	customer_id, year(order_date)
-- group by always work with aggregate functions 

-- aggregate functions 

select 
	customer_id,
	count(order_date) as order_count,
	year(order_date) as order_year
from
	sales.orders
group by
	customer_id,
	year(order_date)

-- query: city wise count of customers

-- query: net value of every order id

-- aggregate grouping

-- HAVING

-- min and max value in every category

-- query: category wise average price ranging between 500 till 1k

-- SUBQUERY
-- sub queries limit -> 32 sub queries in one main query

-- query: retrieve those products whose prices are greater than avg prices using subquery

 select *
 from production.products
 where category_id in (select category_id from production.categories
 where category_name in ('Comfort Bicycles','Electric Bikes'
 ))

--query: find product details where product stocks quantity > 30

-- 16/05/2026 [ABSENT]
-- studied set operators and cte's

-- CLASS 17/05/2026

-- constraints

-- primary key [unique id that identifies each row uniquely, not null]
-- foreign key
-- not null
-- unique 
-- check

-- composite key -- more than one column combined

-- alter 

-- foreign key

-- CLASS 23/05/2026
create table production.parts(
	part_id int not null,
	part_name varchar(100)
);

insert into	
	production.parts(part_id,part_name)
values
	(1,'frame'),
	(2, 'head tube'),
	(3, 'handlebar grip'),
	(4, 'shock absorber'),
	(5, 'fork')

select * from production.parts

select 
	part_id,
	part_name
from 
	production.parts
where
	part_id=5

alter table production.parts
add primary key (part_id);

drop table production.parts;

create clustered index ix_parts_id
on production.parts (part_id);

-- CLASS 24/05/2026

-- COALESCE
SELECT 
    COALESCE(NULL, 'Hi', 'Hello', NULL) result; --hi

SELECT 
    COALESCE(NULL, NULL, 'Hello', NULL) result; --hello

SELECT 
    COALESCE(NULL, NULL, NULL, NULL) result; -- error

SELECT 
    COALESCE(NULL, NULL, 100, 200) result;

SELECT 
    first_name, 
    last_name, 
    phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;

-- WINDOW FUNCTIONS [INTERVIEW IMP]
-- SYNTAX


-- ROW NUMBER() OVER()
-- [partition by partition_expresssion,...]
-- order by sort expression [asc | desc]

delete from sales.customers
where 

-- RANK
-- RANK() OVER (
-- [PARTITION BY partition_expression, ... ]
--  ORDER BY sort_expression [ASC | DESC], ...
)

-- CLASS 30/05/2026

-- INSERT
-- SYNTAX
-- INSERT INTO table_name (column_list) VALUES (value_list)

select * from production.brands;

update production.brands set brand_name = 'Elektra' where brand_id = 1;

CREATE TABLE sales.category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);

INSERT INTO sales.category(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (2,'Comfort Bicycles',25000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',10000);


CREATE TABLE sales.category_staging (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);


INSERT INTO sales.category_staging(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',20000),
    (5,'Electric Bikes',10000),
    (6,'Mountain Bikes',10000);

MERGE sales.category t 
    USING sales.category_staging s
ON (s.category_id = t.category_id)
WHEN MATCHED
    THEN UPDATE SET 
        t.category_name = s.category_name,
        t.amount = s.amount
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (category_id, category_name, amount)
         VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

select * from sales.category

CREATE TABLE invoices (
  id int IDENTITY PRIMARY KEY,
  customer_id int NOT NULL,
  total decimal(10, 2) NOT NULL DEFAULT 0 CHECK (total >= 0)
);

CREATE TABLE invoice_items (
  id int,
  invoice_id int NOT NULL,
  item_name varchar(100) NOT NULL,
  amount decimal(10, 2) NOT NULL CHECK (amount >= 0),
  tax decimal(4, 2) NOT NULL CHECK (tax >= 0),
  PRIMARY KEY (id, invoice_id),
  FOREIGN KEY (invoice_id) REFERENCES invoices (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

BEGIN TRANSACTION;

INSERT INTO invoices (customer_id, total)
VALUES (100, 0);

INSERT INTO invoice_items (id, invoice_id, item_name, amount, tax)
VALUES (10, 1, 'Keyboard', 70, 0.08),
       (20, 1, 'Mouse', 50, 0.08);

UPDATE invoices
SET total = (SELECT
  SUM(amount * (1 + tax))
FROM invoice_items
WHERE invoice_id = 1);

COMMIT;

select * from invoices;

