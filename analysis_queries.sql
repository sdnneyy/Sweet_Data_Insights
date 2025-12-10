SELECT * 
FROM dbo.Chocolate_Sales;

SELECT *
FROM Sales;

SELECT *
FROM Customers;

SELECT *
FROM Products;

-- What is the total revenue across all sales?

SELECT SUM(Amount) AS Total_Revenue 
FROM Sales;

-- Which 5 customers spent the most overall?

SELECT TOP(5) SUM(s.Amount) AS Total_Spent, 
       c.Customer_ID, 
       c.Customer_name
FROM Sales s
INNER JOIN Customers c ON c.Customer_ID = s.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spent DESC;

-- Which 5 products generated the highest revenue?

SELECT TOP(5) SUM(s.Amount) AS Total_Spent, 
       p.Product_ID, 
       p.Product_Name 
FROM Sales s
INNER JOIN Products p ON p.Product_ID = s.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Spent DESC;

-- How much revenue came from each country?

SELECT SUM(Amount) AS Revenue, Country
FROM Sales 
GROUP BY Country 
ORDER BY Revenue;

-- What is the total revenue per month over time?

SELECT SUM(Amount) AS Revenue, 
       FORMAT(Sales_date, 'yyyy-MM') AS Sale_Month_Year
FROM Sales
GROUP BY FORMAT(Sales_date, 'yyyy-MM')
ORDER BY Sale_Month_Year;

-- What is the average amount per sale?

SELECT AVG(Amount) AS Average_Amount_Per_Sale
FROM Sales;

-- Which product required the most boxes shipped overall?

SELECT TOP(1) s.Boxes_shipped, 
       p.Product_Name, 
       p.Product_ID
FROM Sales s
INNER JOIN Products p ON p.Product_ID = s.Product_ID;

-- For each customer, which product did they buy the most?

WITH Popular_Product AS (
     SELECT c.Customer_ID,
            c.Customer_Name,
            p.Product_Name,
            COUNT(s.Sales_ID) AS Total_Sales_Count
     FROM Sales s
     INNER JOIN Customers c ON s.Customer_ID = c.Customer_ID
     INNER JOIN Products p ON s.Product_ID = p.Product_ID
     GROUP BY c.Customer_ID, c.Customer_Name, p.Product_Name),
     
     Top_Counts AS (
     SELECT *, 
     ROW_NUMBER() OVER (
     PARTITION BY Customer_ID
     ORDER BY Total_Sales_Count DESC) AS Popularity
     FROM Popular_Product)

     SELECT Customer_Name, 
            Product_Name AS Most_Popular_Product, 
            Total_Sales_Count
     FROM Top_Counts
     WHERE Popularity = 1
     ORDER BY Total_Sales_Count DESC;

-- How much was revenue by year?

SELECT SUM(Amount) AS Revenue, 
       FORMAT(Sales_Date, 'yyyy') AS Year 
FROM Sales
GROUP BY FORMAT(Sales_Date, 'yyyy');

-- Which sales had an amount greater than $500?

SELECT Amount, Sales_ID 
FROM Sales 
WHERE Amount >= 500;
