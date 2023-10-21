-- Практическая работа 4
--Цель работы: использование подзапросов.

SELECT MAX(P.[ListPrice]) FROM [Production].[Product] AS P
WHERE P.[Color]='Red'

SELECT [Name]
FROM [Production].[Product]
WHERE [Color]='Red' AND [ListPrice]=3578.27

SELECT [Name]
FROM [Production].[Product]
WHERE [Color]='Red'AND [ListPrice]=
(SELECT MAX([ListPrice]) FROM [Production].[Product]
WHERE [Color]='Red')

SELECT [Name]
FROM [Production].[Product]
WHERE [Color]!='Red'AND [ListPrice] = ANY
(SELECT [ListPrice] FROM [Production].[Product]
WHERE [Color]='Red')

SELECT [Name]
FROM [Production].[Product]
WHERE [ListPrice] >ALL
(SELECT [ListPrice] FROM [Production].[Product]
WHERE [Color]='Red')

SELECT [Name]
FROM [Production].[Product]
WHERE [Color] IN
(SELECT [Color] FROM [Production].[Product]
WHERE [ListPrice]>3000)

SELECT [Name]
FROM [Production].[ProductCategory]
WHERE [ProductCategoryID] IN
(SELECT [ProductCategoryID]
FROM [Production].[ProductSubcategory]
WHERE [ProductSubcategoryID] IN
(SELECT [ProductSubcategoryID]
FROM [Production].[Product]
WHERE [ListPrice] =
(SELECT MAX([ListPrice])
FROM [Production].[Product])))

SELECT [Name]
FROM [Production].[Product]
WHERE [Color] IN
(SELECT [Color]
FROM [Production].[Product]
WHERE [ListPrice] =
(SELECT MAX([ListPrice])
FROM [Production].[Product]))
AND
[Style] IN
(SELECT [Style]
FROM [Production].[Product]
WHERE [ListPrice] =
(SELECT MAX([ListPrice])
FROM [Production].[Product]))

SELECT [ProductSubcategoryID]
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID]
HAVING COUNT(*)=
(SELECT TOP 1 COUNT(*)
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID]
ORDER BY 1 DESC)

SELECT [Name]
FROM [Production].[Product] AS P1
WHERE [ListPrice]=
(SELECT MAX([ListPrice])
FROM [Production].[Product] AS P2
WHERE P1.ProductSubcategoryID=P2.ProductSubcategoryID);
SELECT COUNT(*) FROM Production.ProductSubcategory;

SELECT [Name],
(SELECT [Name]
FROM [Production].[ProductSubcategory] AS PS
WHERE P1.ProductSubcategoryID=PS.ProductSubcategoryID)
FROM [Production].[Product] AS P1