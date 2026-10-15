-- Task 1: Product Information
SELECT 
    ProductID, 
    UPPER(Name) AS ProductName, 
    ROUND(Weight, 0) AS ApproxWeight
FROM SalesLT.Product;

SELECT 
    ProductID, 
    UPPER(Name) AS ProductName, 
    ROUND(Weight, 0) AS ApproxWeight,
    YEAR(SellStartDate) AS SellStartYear,
    DATENAME(month, SellStartDate) AS SellStartMonth
FROM SalesLT.Product;

SELECT 
    ProductID, 
    UPPER(Name) AS ProductName, 
    ROUND(Weight, 0) AS ApproxWeight,
    YEAR(SellStartDate) AS SellStartYear,
    DATENAME(month, SellStartDate) AS SellStartMonth,
    LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

SELECT 
    ProductID, 
    UPPER(Name) AS ProductName, 
    ROUND(Weight, 0) AS ApproxWeight,
    YEAR(SellStartDate) AS SellStartYear,
    DATENAME(month, SellStartDate) AS SellStartMonth,
    LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;


-- Task 2: Customer Ranking by Revenue
SELECT 
    c.CompanyName,
    oh.TotalDue AS Revenue,
    RANK() OVER (ORDER BY oh.TotalDue DESC) AS RankByRevenue
FROM SalesLT.SalesOrderHeader AS oh
JOIN SalesLT.Customer AS c ON oh.CustomerID = c.CustomerID;


-- Task 3: Product Sales Aggregation
SELECT 
    p.Name,
    SUM(od.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS od
JOIN SalesLT.Product AS p ON od.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

SELECT 
    p.Name,
    SUM(od.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS od
JOIN SalesLT.Product AS p ON od.ProductID = p.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

SELECT 
    p.Name,
    SUM(od.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS od
JOIN SalesLT.Product AS p ON od.ProductID = p.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
HAVING SUM(od.LineTotal) > 20000
ORDER BY TotalRevenue DESC;
