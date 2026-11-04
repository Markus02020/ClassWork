-- Семинар 8 – Множества группировок и поворот данных

-- ============================================================================
-- Задача 1: Получение итогов продаж по регионам
-- ============================================================================

-- 1. Получите итоги для страны/региона и штата/провинции
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;


-- 2. Укажите уровни группировки в результатах
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue,
       CASE 
            WHEN GROUPING_ID(a.CountryRegion, a.StateProvince) = 3 THEN 'Total'
            WHEN GROUPING_ID(a.CountryRegion, a.StateProvince) = 1 THEN a.CountryRegion + ' Subtotal'
            ELSE a.StateProvince + ' Subtotal'
       END AS [Level]
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;


-- 3. Добавьте уровень группировки для городов
SELECT a.CountryRegion, a.StateProvince, a.City, SUM(soh.TotalDue) AS Revenue,
       CASE 
            WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 7 THEN 'Total'
            WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 3 THEN a.CountryRegion + ' Subtotal'
            WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 1 THEN a.StateProvince + ' Subtotal'
            ELSE a.City + ' Subtotal'
       END AS [Level]
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, a.City;


-- ============================================================================
-- Задача 2: Получение доходов от продаж по категориям
-- ============================================================================

-- 1. Получите доход от продаж для каждой родительской категории
SELECT CompanyName, [Accessories], [Bikes], [Clothing], [Components]
FROM 
(
    SELECT c.CompanyName, cat.ParentProductCategoryName, sod.LineTotal
    FROM SalesLT.Customer AS c
    INNER JOIN SalesLT.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
    INNER JOIN SalesLT.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
    INNER JOIN SalesLT.Product AS p ON sod.ProductID = p.ProductID
    INNER JOIN SalesLT.vGetAllCategories AS cat ON p.ProductCategoryID = cat.ProductCategoryID
) AS SourceTable
PIVOT
(
    SUM(LineTotal)
    FOR ParentProductCategoryName IN ([Accessories], [Bikes], [Clothing], [Components])
) AS PivotTable
ORDER BY CompanyName;
