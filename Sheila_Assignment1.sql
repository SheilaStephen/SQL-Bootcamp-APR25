CREATE TABLE shippers (
shipperID SERIAL PRIMARY KEY,  --ShipperID is the unique identifier of each row 
companyName VARCHAR(100) NOT NULL
);

SELECT * FROM shippers;

CREATE TABLE products (
    productID SERIAL PRIMARY KEY,
    productName VARCHAR(100) NOT NULL, --Product name cannot be null 
    quantityPerUnit VARCHAR(50),
    unitPrice NUMERIC(10, 2),
    discontinued BOOLEAN DEFAULT FALSE, --Default value is FALSE
    categoryID INTEGER
);

SELECT * FROM products;

CREATE TABLE orders (
    orderID INTEGER PRIMARY KEY,
    customerID VARCHAR(10),
    employeeID INTEGER,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INTEGER,
    freight NUMERIC(10, 2)
);

SELECT * FROM orders;

CREATE TABLE order_details (
    orderID INTEGER,
    productID INTEGER,
    unitPrice NUMERIC(10, 2),
    quantity INTEGER,
    discount NUMERIC(4, 2),
    PRIMARY KEY (orderID, productID) --Primary key is a combination of both orderID and productID
);

SELECT * FROM order_details;

CREATE TABLE employees (
    employeeID INTEGER PRIMARY KEY,
    employeeName VARCHAR(100),
    title VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50),
    reportsTo INTEGER
);

SELECT * FROM employees;

CREATE TABLE customers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(100),
    contactName VARCHAR(100),
    contactTitle VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

SELECT * FROM customers;

CREATE TABLE categories (
    categoryID INTEGER PRIMARY KEY,
    categoryName VARCHAR(50),
    description TEXT
);

SELECT * FROM categories;
