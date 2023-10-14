-- 1. ����� � ������� �� ����� ���������� ������� ������� �����, 
-- �������� �� ������ ������, ���� ������� ������ 30.
SELECT P.Color, COUNT(*) AS Count
FROM Production.Product AS P
WHERE P.ListPrice < 30
GROUP BY P.Color;

-- 2. ����� � ������� �� ����� ������, ��������� �� ������ �������, 
-- �����, ��� ����������� ���� ������ ������� ����� ����� 100.
SELECT P.Color, COUNT(*) AS Count
FROM Production.Product AS P
WHERE P.ListPrice > 100
GROUP BY P.Color;

-- 3. ����� � ������� �� ����� ������ ������������ ������� 
-- � ���������� ������� � ������ ���������.
SELECT P.ProductSubcategoryID, COUNT(*)
FROM Production.Product AS P
GROUP BY P.ProductSubcategoryID;

-- 4. ����� � ������� �� ����� ������ ������� 
-- � ���������� ������ ������ ������� ������ 
-- (������������ ������� SalesORDERDetail)
SELECT P.ProductID, COUNT(*)
FROM Sales.SalesORDERDetail AS SOD
JOIN Production.Product AS P
ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID;

-- 5. ����� � ������� �� ����� ������ �������, 
-- ������� ���� ������� ����� ���� ���.
SELECT P.ProductID, COUNT(*)
FROM Sales.SalesORDERDetail AS SOD
JOIN Production.Product AS P
ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID
HAVING COUNT(*) > 5;

-- 6. ����� � ������� �� ����� ������ �����������, CustomerID, 
-- � ������� ���������� ����� ������ ����, SalesORDERID, 
-- � ���������� �����
SELECT C.CustomerID
FROM Sales.Customer AS C
JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID
HAVING COUNT(*) > 1;
-- 7. ����� � ������� �� ����� ��� ������ �����, 
-- �� ������� ���������� ����� ���� ���������.
SELECT SOH.SalesOrderID
FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.SalesOrderID
HAVING COUNT(*) > 1;

-- 8. ����� � ������� �� ����� ��� ������ ���������, 
-- ������� ���� ������� ����� ���� ���.
SELECT P.ProductID
FROM Sales.SalesOrderDetail AS SOD
JOIN Production.Product AS P
ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID
HAVING COUNT(*) > 3;

-- 9. ����� � ������� �� ����� ��� ������ ���������, 
-- ������� ���� ������� ��� ��� ��� ���� ���.
SELECT P.ProductID
FROM Sales.SalesOrderDetail AS SOD
JOIN Production.Product AS P
ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID
HAVING COUNT(*) = 3 OR COUNT(*) = 5;

-- 10. ����� � ������� �� ����� ��� ������ ������������, 
-- � ������� ��������� ����� ������ �������.
SELECT P.ProductSubcategoryID
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID
HAVING COUNT(*) > 10;

-- 11. ����� � ������� �� ����� ������ �������, 
-- ������� ������ ���������� � ����� ���������� �� ���� �������.
SELECT DISTINCT SOD.ProductID 
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.SalesOrderID IN (SELECT SOD.SalesOrderID
FROM Sales.SalesOrderDetail AS SOD
GROUP BY SOD.SalesOrderID
HAVING COUNT(SOD.ProductID) = 1);

-- 12 ����� � ������� �� ����� ����� ����, SalesORDERID, 
-- �� ������� ���������� � ���������� ������������� ������� 
-- ��������� �� ���� ���.
SELECT DISTINCT SOD.SalesORDERID
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.SalesOrderID IN (SELECT TOP 1 SOD.SalesOrderID
FROM Sales.SalesOrderDetail AS SOD
GROUP BY SOD.SalesOrderID
ORDER BY COUNT(*) DESC);

-- 13 ����� � ������� �� ����� ����� ����, SalesORDERID 
-- � ���������� ������ �������, ������ �� ����, 
-- ��� ���� ������ � ��� UnitPrice, � ���������� ����������� 
-- ������ � ���� � ��� ORDERQty
SELECT TOP 1 SOD.SalesOrderDetailID
FROM Sales.SalesOrderDetail AS SOD
ORDER BY SOD.UnitPrice*SOD.OrderQty DESC;

-- 14 ���������� ���������� ������� � ������ ������������, 
-- �������� ������, ��� ������� ������������ �� ����������, 
-- � ������, � ������� �� ��������� ����.
SELECT P.ProductSubcategoryID
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL AND P.Color IS NULL
GROUP BY P.ProductSubcategoryID;

-- 15 �������� ������ ������ ������� � ������� 
-- �������� ���������� ������� ������� �����
SELECT P.Color
FROM Production.Product AS P
GROUP BY P.Color
ORDER BY COUNT(*) DESC;

-- 16 ������� �� ����� ProductID ��� �������, ��� ������ 
-- ���������� � ���������� ����� 1 ������� �� ���� ���, 
-- ��� ���� ����� ������� ���� ����� ����.
SELECT DISTINCT SOD.ProductID 
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.SalesOrderID IN (SELECT SOD.SalesOrderID
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.OrderQty > 1
GROUP BY SOD.SalesOrderID
HAVING COUNT(SOD.ProductID) > 2);
