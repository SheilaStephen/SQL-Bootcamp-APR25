/*1.Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
units_in_stock = 0  is 'Out of Stock'
units_in_stock < 20  is 'Low Stock')*/
SELECT * FROM products;
SELECT product_name,
CASE 
	WHEN units_in_stock = 0 THEN 'out of stock'
	WHEN units_in_stock < 20 THEN 'Low stock'
	ELSE 'In Stock'
END AS stock_status
FROM products;
 
/*2.Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)*/
SELECT * FROM categories;
SELECT category_id, 
	   product_name, 
	   unit_price 
FROM 
	products 
WHERE 
	category_id = (
		SELECT category_id 
		FROM categories
		WHERE category_name = 'Beverages'
	);
 
/*3.Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC 
and limit 1. Use Subquery)*/
SELECT * FROM orders;
SELECT order_id, 
	   order_date, 
	   freight, 
	   employee_id  
FROM orders 
WHERE employee_id = (
	SELECT employee_id 
	FROM orders
	GROUP BY employee_id
	ORDER BY count(*) DESC
	LIMIT 1
);

/*4.Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. 
(Subquery, Try with ANY, ALL operators)*/
SELECT * FROM orders;
SELECT order_id, ship_country, freight 
FROM orders 
WHERE ship_country != 'USA'
AND freight > ANY (
SELECT freight FROM orders WHERE ship_country = 'USA'
);

SELECT order_id, ship_country, freight 
FROM orders 
WHERE ship_country != 'USA'
AND freight > ALL (
SELECT freight FROM orders WHERE ship_country = 'USA'
);

