SELECT *
FROM dbo.Chocolate_Sales;

-- creating Customer table

CREATE TABLE Customers (
             Customer_ID INT PRIMARY KEY IDENTITY(1,1),
             Customer_Name VARCHAR(255) NOT NULL UNIQUE);

SELECT *
FROM Customers;

-- inserting data into Customers table

INSERT INTO Customers (Customer_Name)
SELECT DISTINCT Sales_Person
FROM dbo.Chocolate_Sales
ORDER BY Sales_Person;

SELECT *
FROM Customers;

-- creating Products table

CREATE TABLE Products (
             Product_ID INT PRIMARY KEY IDENTITY(1,1),
             Product_Name VARCHAR(255) NOT NULL UNIQUE);

SELECT *
FROM Products;

-- inserting data into Products table 

INSERT INTO Products (Product_Name)
SELECT DISTINCT Product
FROM dbo.Chocolate_Sales
ORDER BY Product;

SELECT *
FROM Products;

-- creating Sales table

CREATE TABLE Sales (
             Sales_ID INT PRIMARY KEY IDENTITY(1,1),
             Customer_ID INT NOT NULL,
             Product_ID  INT NOT NULL,
             Country VARCHAR(100),
             Sales_date DATE, 
             Amount DECIMAL(10,2),
             Boxes_shipped INT
CONSTRAINT FK_Sales_Customers FOREIGN KEY (Customer_ID)
REFERENCES Customers (Customer_ID),
       
CONSTRAINT FK_Sales_Products FOREIGN KEY (Product_ID)
REFERENCES Products (Product_ID)
);

SELECT * 
FROM Sales;

drop table Sales;

-- inserting data into Sales table 

INSERT INTO Sales (
            Customer_ID,
            Product_ID,
            Country,
            Sales_date,
            Amount,
            Boxes_shipped)
SELECT C.Customer_ID,
       P.Product_ID,
       CS.Country,
       CONVERT(DATE, CS.Date, 106) AS Sale_date,
       CONVERT(DECIMAL(10,2), CS.Amount) AS Amount,
       CS.Boxes_shipped
FROM dbo.Chocolate_Sales CS
INNER JOIN Customers C ON CS.Sales_Person = C.Customer_name
INNER JOIN Products P ON CS.Product = P.Product_name
ORDER BY Date;

SELECT * 
FROM Sales;