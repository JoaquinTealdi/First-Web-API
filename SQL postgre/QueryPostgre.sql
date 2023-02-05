USE Sprint2DB;
-- A
CREATE TABLE Customers(
	customer_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL
)

CREATE TABLE Invoices(
	invoice_id INT PRIMARY KEY IDENTITY(1,1),
	invoice_number INT NOT NULL,	
	invoice_date DATE NOT NULL,
	invoice_total FLOAT NOT NULL,
	customer_id_fk INT NOT NULL,
	FOREIGN KEY (customer_id_fk) REFERENCES Customers(customer_id)
)

CREATE TABLE InvoiceDetails(
	invoice_detail_id INT PRIMARY KEY IDENTITY(1,1),
	invoice_id_fk INT NOT NULL,
	product_id_fk INT NOT NULL,
	quantity INT NOT NULL,
	subtotal FLOAT NOT NULL
	FOREIGN KEY(invoice_id_fk) REFERENCES Invoices(invoice_id),
	FOREIGN KEY(product_id_fk) REFERENCES Products(product_id)
)

CREATE TABLE Products (
	product_id INT PRIMARY KEY IDENTITY(1,1),
	category_id_fk INT NOT NULL,
	product_name VARCHAR(50) NOT NULL,
	description VARCHAR(200) NULL,
	price FLOAT NOT NULL,
	FOREIGN KEY(category_id_fk) REFERENCES Categories (category_id)
)

CREATE TABLE Categories (
	category_id SERIAL NOT NULL,
	category_name VARCHAR(50) NOT NULL,
	category_description VARCHAR(200) NULL,
	PRIMARY KEY(category_id)
)

-- B 
INSERT INTO Categories(category_name, category_description) 
VALUES ('PHONES','SAMGUNG - XIAOMI - MOTOROLA - IPHONE' ),
('COMPUTING','PC GAMER - PC HOME OFFICE - NOTEBOOK' ),
('PHOTOGRAPHY','CANON - NIKON - GOPRO - SONY'),
('KEYBOARD','REDRAGON - LOGITECH - HIPERX - HP'),
('MOUSE','REDRAGON - LOGITECH - HIPERX - HP');

INSERT INTO Customers(first_name, last_name)
VALUES('Martin','Lopez'),
('Pedro','Almanza'),
('Sebastian','Villordo');

INSERT INTO Products(category_id_fk, product_name, description, price)
VALUES(1, 'PHONES', 'SAMSUNG', 500),
(1, 'PHONES', 'XIAOMI', 500),
(1, 'PHONES', 'IPHONE', 500),
(1, 'PHONES', 'MOTOROLA', 500),
(2, 'COMPUTING','PC GAMER', 1000),
(2, 'COMPUTING','PC HOME OFFICE', 1000),
(2, 'COMPUTING','NOTEBOOK', 1000),
(2, 'COMPUTING','PC GAMER PRO', 1000),
(3, 'PHOTOGRAPHY','CANON', 400),
(3, 'PHOTOGRAPHY','NIKON', 400),
(3, 'PHOTOGRAPHY','GOPRO', 400),
(3, 'PHOTOGRAPHY','SONY', 400),
(4, 'KEYBOARD','REDRAGON',200),
(4, 'KEYBOARD','LOGITECH', 200),
(4, 'KEYBOARD','HIPERX', 200),
(4, 'KEYBOARD','HP', 200),
(5, 'MOUSE','REDRAGON', 150),
(5, 'MOUSE','LOGITECH', 150),
(5, 'MOUSE','HIPERX', 150),
(5, 'MOUSE','HP', 150);


INSERT INTO Invoices(invoice_number, invoice_date, invoice_total, customer_id_fk)
VALUES (1, CONVERT(DATE,'12/26/2022',101), 3700, 1), 
(2, CONVERT(DATE,'12/02/2022',101), 950, 1),
(3, CONVERT(DATE,'06/22/2022',101), 3200, 1), 
(4, CONVERT(DATE,'06/21/2022',101), 400, 2), 
(5, CONVERT(DATE,'04/13/2022',101), 1450, 2),
(6, CONVERT(DATE,'12/26/2022',101), 1350, 2), 
(7, CONVERT(DATE,'07/14/2022',101), 3400, 2), 
(8, CONVERT(DATE,'10/29/2022',101), 600, 3), 
(9, CONVERT(DATE,'04/13/2022',101), 1600, 3), 
(10, CONVERT(DATE,'03/10/2022',101), 1900, 3); 


INSERT INTO InvoiceDetails(invoice_id_fk, product_id_fk, quantity, subtotal)
VALUES (1, 1, 1, 500),
(1, 14, 1, 200),
(1, 5, 3, 3000),
(2, 18, 2, 300),
(2, 17, 1, 150),
(2, 2, 1, 500),
(3, 16, 1, 200),
(3, 3, 2, 1000),
(3, 7, 2, 2000),
(4, 15, 2, 400),
(5, 6, 1, 1000),
(5, 20, 3, 450),
(6, 20, 1, 150),
(6, 10, 3, 1200),
(7, 11, 1, 400),
(7, 4, 2, 1000),
(7, 8, 2, 2000),
(8, 14, 1, 200),
(8, 15, 1, 200),
(8, 13, 1, 200),
(9, 12, 4, 1600),
(10, 7, 1, 1000),
(10, 4, 1, 500),
(10, 16, 1, 200),
(10, 13, 1, 200);


SELECT * FROM Categories;
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Invoices;
SELECT * FROM InvoiceDetails;


TRUNCATE TABLE InvoiceDetails;
TRUNCATE TABLE Customers;
TRUNCATE TABLE Invoices;
TRUNCATE TABLE Categories;
TRUNCATE TABLE Products;


DROP TABLE InvoiceDetails;
DROP TABLE Products;
DROP TABLE Categories;
DROP TABLE Invoices;
DROP TABLE Customers;

-- C
-- i
SELECT c.category_name, 
	count(p.product_id) AS Products_Amount 
FROM Categories c INNER JOIN Products p ON c.category_id = p.category_id_fk
GROUP BY(c.category_name);



--ii
--name
SELECT c.last_name,
	i.invoice_date,
	i.invoice_number,
	invoice_total AS amount
FROM Customers c INNER JOIN Invoices i ON c.customer_id = i.customer_id_fk
ORDER BY(c.last_name);

--date
SELECT c.last_name,
	i.invoice_date,
	i.invoice_number,
	invoice_total AS amount
FROM Customers c INNER JOIN Invoices i ON c.customer_id = i.customer_id_fk
ORDER BY(i.invoice_date);

--iii
SELECT p.product_name,
	p.description,
	p.price
FROM Products p INNER JOIN InvoiceDetails i ON p.product_id = i.product_id_fk
				INNER JOIN Invoices n ON n.invoice_id = i.invoice_id_fk
				WHERE( n.invoice_date =	CONVERT(DATE,'12/26/2022',101));