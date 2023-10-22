--������� ��� ��������������� ������
--1 ����� �������� ������ ������������ ��������.
SELECT P.Name FROM Production.Product AS P WHERE P.ProductID IN
(SELECT TOP 1 WITH TIES SOD.ProductID FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID
ORDER BY COUNT(*) DESC);
--2 ����� ����������, ������������ ������� �� ����� ������� ����, ������ ����� ������� ������ �� ���� ������ ��� ������ (UnitPrice).
SELECT C.CustomerID FROM Sales.Customer AS C WHERE C.CustomerID IN
(SELECT TOP 1 WITH TIES SOH.CustomerID FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
ORDER BY SOD.OrderQty*SOD.UnitPrice DESC);

--3 ����� ����� ��������, ������� ������� ������ ���� ����������.
SELECT SOD1.ProductID,
(SELECT COUNT(DISTINCT SOH.CustomerID) FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOD.ProductID = SOD1.ProductID)

FROM Sales.SalesOrderDetail AS SOD1 JOIN Sales.SalesOrderHeader
AS SOH1 ON SOD1.SalesOrderID = SOH1.SalesOrderID;

--4 ������� ������ ���������, ���� ������� ���� ������� ���� ������� � ������������, � ������� ��������� �����.
SELECT P.Name
FROM Production.Product AS P
WHERE P.ListPrice > 
(
	SELECT AVG(P2.ListPrice) FROM Production.Product AS P2
	WHERE P.ProductSubcategoryID = P2.ProductSubcategoryID
);
--5 ����� ����� ������, ������� ���� ������� ����� ��� ����� �����������, 
-- ��� ���� ��� ���������� ���� ������� �������� ������ ������ ������ ����� 
-- � ������ �� ������ � ������ ������� �����������, �������� ������ ������ ���� ������.
SELECT SOD1.ProductID

FROM Sales.SalesOrderDetail AS SOD1 JOIN Sales.SalesOrderHeader
AS SOH1 ON SOD1.SalesOrderID = SOH1.SalesOrderID
WHERE (SELECT COUNT(DISTINCT SOH.CustomerID) FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOD.ProductID = SOD1.ProductID) > 1;

SELECT DISTINCT SOD2.ProductID
FROM Sales.SalesOrderDetail AS SOD2 JOIN Sales.SalesOrderHeader
AS SOH2 ON SOD2.SalesOrderID = SOH2.SalesOrderID

SELECT t.ProductID FROM (SELECT DISTINCT SOD2.ProductID
FROM Sales.SalesOrderDetail AS SOD2 JOIN Sales.SalesOrderHeader
AS SOH2 ON SOD2.SalesOrderID = SOH2.SalesOrderID
WHERE SOH2.CustomerID = CID) AS t

(SELECT COUNT(P.Color) FROM Production.Product AS P
WHERE 
P.ProductID = t.ProductID);


--6 ����� ����� ������, ������� ���� ������� ������ ������������, � ������� ��� �������������� � ������ �� �������.
--7 ����� �����������, � ������� ���� �����, �������������� � ������ �������/����.
--8 ����� ����� ����� ��� ������, ������� ���� ������� �� ����� ��� ����� ���������� ������������.
--9 ����� ��� ������, ����� ��� �� �������� ������ � �������, ���� �������� ����������� � ����� ���������.
--10 ����� ������ ��� �����������, � ������� ���� ��� ������� ��� ����, � ������ �� ���� ����� �������� ��� ������� ��� ������, ������ �� ������� ��� ������� ��� ������ ������� ������������ ��� ����.
--11 ����� ��� ����, � ������� ������ ����� ��� ������ ������ ���� �� �����������.
--12 ����� ������, ������� ���� ������� ������� ��� ���� ���������� ������������.
--13 ����� ����� ������������ ��� ������������ �������, ������� �������� ����� ���� �������, ��������� ����� ���� ���.
--14 ����� �� ������, ������� �� ���� ������� ����� ���� ���, � ��� ������� ������ ����� � ��� �� �����������.