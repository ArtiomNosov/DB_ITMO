SELECT T1.PS, T1.c, T2.c FROM
(SELECT COUNT(*) AS c, [ProductSubcategoryID] AS PS
FROM [Production].[Product] AS P
WHERE [ListPrice]<(SELECT avg([ListPrice])
FROM [Production].[Product] AS PT
WHERE pt.ProductSubcategoryID=p.ProductSubcategoryID)
GROUP BY [ProductSubcategoryID]) AS T1 INNER JOIN
(SELECT count(*) AS c, [ProductSubcategoryID] AS PS
FROM [Production].[Product] AS P
WHERE [ListPrice]>=(SELECT avg([ListPrice])
FROM [Production].[Product] AS PT
WHERE pt.ProductSubcategoryID=p.ProductSubcategoryID)
GROUP BY [ProductSubcategoryID]) AS T2 ON
T1.PS=T2.PS;

SELECT T1.PS, T1.c, T2.c FROM
(
	SELECT COUNT(*) AS c, ProductSubcategoryID AS PS
	FROM Production.Product AS P
	WHERE ListPrice < (SELECT avg(ListPrice)
	FROM Production.Product AS PT
	WHERE pt.ProductSubcategoryID=p.ProductSubcategoryID)
	GROUP BY ProductSubcategoryID
) AS T1 INNER JOIN
(SELECT count(*) AS c, [ProductSubcategoryID] AS PS
FROM [Production].[Product] AS P
WHERE [ListPrice]>=(SELECT avg([ListPrice])
FROM [Production].[Product] AS PT
WHERE pt.ProductSubcategoryID=p.ProductSubcategoryID)
GROUP BY [ProductSubcategoryID]) AS T2 ON
T1.PS=T2.PS;

WITH Sales_CTE (SalesPersonID, SalesORDERID, SalesYear)
AS
(
	SELECT SalesPersonID, SalesORDERID, YEAR(ORDERDate) AS SalesYear
	FROM Sales.SalesORDERHeader
	WHERE SalesPersonID IS NOT NULL
)
SELECT SalesPersonID, COUNT(SalesORDERID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear