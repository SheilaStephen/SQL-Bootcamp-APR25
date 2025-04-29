SELECT * FROM categories;
SELECT * FROM products;
 
/*1)Update the categoryName From “Beverages” to "Drinks" in the categories table.*/
UPDATE categories 
SET "categoryName" = 'Drinks'
WHERE "categoryName" = 'Beverages';

/*2)Insert into shipper new record (give any values) Delete that new record from shippers table.*/
INSERT INTO shippers(shipperid,companyname)
VALUES(4,'FedEx');

DELETE FROM shippers WHERE companyname = 'FedEx';

/*3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.
Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid) )
*/
ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (categoryid)
REFERENCES categories("categoryID")
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories 
SET "categoryID" = 1
WHERE "categoryID" = 1001;

DELETE FROM categories WHERE "categoryID" = 3;

/*4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/
SELECT * FROM customers WHERE "customerID" = 'VINET';
SELECT * FROM orders;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY ("customerID")
REFERENCES customers("customerID")
ON DELETE SET NULL;

DELETE FROM customers WHERE "customerID" = 'VINET';

/*5)Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)
*/

SELECT * FROM products WHERE productid = 100;
INSERT INTO products(productid, productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES(100,'Wheat bread','1',13,'false',5),
	  (101,'White bread','5 boxes',13,'false',5)
ON CONFLICT(productid)
DO UPDATE
SET productid=EXCLUDED.productid;

INSERT INTO products(productid, productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES(100,'Wheat bread','10 boxes',13,'false',5)
ON CONFLICT(productid)
DO UPDATE
SET quantityperunit='10 boxes';

/*6)Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:
productID
productName
quantityPerUnit
unitPrice
discontinued
categoryID
100
Wheat bread
10
20
1
5
101
White bread
5 boxes
19.99
0
5
102
Midnight Mango Fizz
24 - 12 oz bottles
19
0
1
103
Savory Fire Sauce
12 - 550 ml bottles
10
0
2

Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .
discontinued =0 
If there are matching products and updated_products .discontinued =1 then delete 
Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.
*/

MERGE INTO products p
USING(
	VALUES
		(100,'Wheat bread','10',20,true,5),
		(101,'White bread','5 boxes',19.99,false,5),
		(102, 'Midnight Mango Fizz', '24-12 oz bottles',19,false,1),
		(103,'Savory Fire Sauce','12-550 ml bottles',10,false,2)
)AS updated_products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
ON p.productid=updated_products.productid
WHEN MATCHED  AND updated_products.discontinued = 'false' THEN 
	UPDATE SET 
		unitprice = updated_products.unitprice,
		discontinued = updated_products.discontinued
WHEN MATCHED AND updated_products.discontinued = 'true' THEN
	DELETE
WHEN NOT MATCHED AND updated_products.discontinued='false' THEN
	INSERT(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
	VALUES(updated_products.productid,updated_products.productname,updated_products.quantityperunit,updated_products.unitprice,updated_products.discontinued,updated_products.categoryid)

SELECT * FROM products;

/*7) List all orders with employee full names. (Inner join) */
SELECT e.first_name || e.last_name AS Name ,orders.* FROM orders 
INNER JOIN employees e ON orders.employee_id=e.employee_id;



