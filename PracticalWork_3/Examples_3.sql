-- 1. ����� �������� ��������� � �������� ������������ ���� ���������, 
-- � ������� ��������� ���� ������ 100, �� ������� ������, 
-- ����� ������� �� ��������� �� � ����� ������������.
SELECT P.Name, PSC.Name
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
WHERE [ListPrice]>100;

-- 2. ����� �������� ��������� � �������� ������������ ���� ���������, 
-- � ������� ��������� ���� ������ 100, ������� ������, 
-- ����� ������� �� ��������� �� � ����� ���������.
SELECT P.Name, PSC.Name
FROM [Production].[Product] AS P LEFT JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
WHERE [ListPrice]>100;

-- 3 ����� �������� ��������� � �������� ��������� �� ������� ProductCategory, 
-- � ������� ������ ���� �������, �� ������� ������, 
-- ����� � �������� ��� ������������.
SELECT P.Name, PC.Name
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID;

-- 4 ����� �������� ��������, ��������� ���� ��������, 
-- � ����� ��������� ��������� ���� ����� �������� (LAStReceiptCost), 
-- ������� ����� ������ �� ������� ProductVendor.
SELECT P.Name, P.ListPrice, PV.LAStReceiptCost
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID;

-- 5 ����� �������� ��������, ��������� ���� ��������, 
-- � ����� ��������� ��������� ���� ����� �������� (LAStReceiptCost), 
-- ������� ����� ������ �� ������� ProductVendor, ��� ����� ���������, 
-- � ������� ��������� ���� ��������� ���� ��������� ��������� ���� � ����������, 
-- �������� �� ������, ��� ������� ��������� ���� ����� ����.
SELECT P.Name, P.ListPrice, PV.LAStReceiptCost
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID
WHERE P.ListPrice!=0 AND P.ListPrice<PV.LAStReceiptCost;

-- 6 ����� ���������� �������, ������� ���������� ���������� 
-- � ����� ������ ��������� ��������� 
-- (CreditRatINg ��������� ����� �������� �� ������������, ������� 1, �� �������������, ������� 5).
SELECT COUNT(DISTINCT PV.ProductID)
FROM [PurchASINg].[ProductVendor] AS PV INNER JOIN
[PurchASINg].[Vendor] AS V
ON PV.BusINessEntityID=V.BusINessEntityID
WHERE [CreditRatINg]=1;

-- 7 �����, ������� ������� ���������� �� ������ ��������� �������, 
-- �.�. ������������ �������, ������ �������, 
-- ������� ����� ��������� ����� ���������� ��������, ������ � ���������� �������, 
-- ������������ ����� ������������, �������� ��������������� ��������� �������. 
-- ���������� ������������ ������������� ������, 
-- ������� ����� �������� � � ������ ��������� ����� �������� ���������� ��������.
SELECT [CreditRatINg], COUNT(DISTINCT PV.ProductID)
FROM [PurchASINg].[ProductVendor] AS PV INNER JOIN
[PurchASINg].[Vendor] AS V
ON PV.BusINessEntityID=V.BusINessEntityID
GROUP BY [CreditRatINg];

-- 8 ����� ������ ������ ���� ������������ (ProductSubcategoryID) 
-- � ���������� ����������� ������������ �������.
SELECT TOP 3 [ProductSubcategoryID], COUNT(*) AS Count
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
GROUP BY [ProductSubcategoryID]
ORDER BY COUNT(*) DESC;

-- 9 �������� �������� ������ ���� ������������ � ���������� ����������� ������������ �������.
SELECT TOP 3 PC.ProductCategoryID, COUNT(*)
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID
GROUP BY PC.ProductCategoryID
ORDER BY COUNT(*) DESC;
SELECT top 3 psc.name, count(*)
FROM [Production].[Product] AS p INner JOIN
[Production].[ProductSubcategory] AS psc
ON p.ProductSubcategoryID=psc.ProductSubcategoryID
WHERE p.ProductSubcategoryID is NOT null
GROUP BY p.ProductSubcategoryID, psc.Name
ORDER BY count(*) desc;

-- 10 ��������� ������� ���������� �������, ������������ �� ���� ������������, � ��������� ������� �� ����� �������.
-- ������� 1
SELECT 1.0*COUNT(*)/COUNT(DISTINCT [ProductSubcategoryID])
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
-- ������� 2
SELECT CAST(COUNT(*) AS FLOAT)/COUNT(DISTINCT [ProductSubcategoryID])
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
-- ������� 3
SELECT cASt((cASt(count(p.ProductID) AS float)/count(DISTINCT p.ProductSubcategoryID))
AS decimal(6,3))
FROM [Production].[Product] AS p
WHERE p.ProductSubcategoryID is NOT null;

-- 11 ��������� ������� ���������� �������, ������������ �� ���� ���������, � ����� ������.
SELECT COUNT(*)/COUNT(DISTINCT PC.ProductCategoryID)
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
RIGHT JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID;

-- 12 ����� ���������� ������ �������, ������������ �� ������ ���������, 
-- ��� ����� �������, ��� ������� ���� �� ���������.
SELECT COUNT(DISTINCT [Color])
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
RIGHT JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID
GROUP BY PC.ProductCategoryID;

-- 13 ����� ������� ��� ���������. ����������� ������� ��������� � ���������, 
-- ��� ���� ��������, ��� ������� ��� �� ���������. �������������� ������ ���, 
-- ����� ��� ���������� �������� ���� ��������� �� ��������, 
-- ��� ������� ��� �� ���������, ��������� ��� �������� � ����� 10.
SELECT AVG(ISNULL([Weight],10))
FROM [Production].[Product];

-- 14 ������� �������� ��������� � ������ �� �������� ������ 
-- (������ ����� SellStartDate � SellEndDate) � ����, ������������ �� ���������� ������� ������. 
-- ���� ������� ���� �� ��� ��� � SellEndDate �� ���������, 
-- �� ������� �������� ������ ����� ���� � ������ ������ � �� ������� �����.
SELECT [Name], [SellStartDate], [SellEndDate],
DATEDIFF(D,[SellStartDate],ISNULL([SellEndDate],GETDATE())) AS diff
FROM [Production].[Product]
WHERE [SellStartDate] IS NOT NULL
ORDER BY diff desc;

-- 15 ������� �������� �� ���������� �������� � ��������, 
-- � ��� ������ ������ ���������� ���������� ���������.
SELECT LEN([Name]), COUNT(*)
FROM [Production].[Product]
GROUP BY LEN([Name]);

-- 16 ����� ��� ������� ���������� ���������� ������������ ���������, 
-- � ������� ��������� ��������, ������������ ��, ��� ����� ��������, 
-- ����� ������� �� ��������� �� � ����� ������������.
SELECT PV.BusINessEntityID, COUNT(DISTINCT P.ProductSubcategoryID)
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY PV.BusINessEntityID;

-- 17 ���������, ���� �� �������� � ���������� ���������, ���� ����, �� ������� ��� ��������.
-- ������� 1
SELECT P1.Name
FROM [Production].[Product] AS P1,
[Production].[Product] AS P2
WHERE P1.ProductID!=P2.ProductID AND
P1.Name=P2.Name; 
-- ������� 2
SELECT [Name]
FROM [Production].[Product]
GROUP BY [ProductID], [Name]
HAVING COUNT(*)>1; 

-- 18 ����� ������ 10 ����� ������� �������, � ������ ��������, 
-- ����� ���� ���� � ��������� ������� ����� ���������. (WITH TIES) !!!
SELECT TOP 10 WITH TIES [Name]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

-- 19 ����� ������ 10 ��������� ����� ������� �������, � ������ ��������, 
-- ����� ���� � ��������� ������� ����� ���������.
SELECT TOP 10 PERCENT WITH TIES [Name]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

-- 20 ����� ������ ���� �����������, ��������������� �� ���������� ������������ �������, 
-- � ������ ��������, ��� ���������� ������������ ������� ����� ��������� ��� ������ �����������.
SELECT TOP 3 WITH TIES PV.BusINessEntityID
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID
GROUP BY PV.BusINessEntityID
ORDER BY COUNT(P.ProductID) DESC;
