-- 1 ����� ������� ���������� ������� �� ��� ��� ������� ���������� (2 �������).
SELECT SOH.CustomerID, AVG(SOD.OrderQty) FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID;
SELECT * FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
--2 ����� ��� ������� �������� � ������� ���������� ����������� ���������� ������ ������� ������� ������ ������ ����������� 
-- � ������ ���������� ������ ������� ������� ������ �����������
SELECT * FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID

SELECT SOH.CustomerID, SOD.ProductID, COUNT(*) AS c FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID, SOD.ProductID;

WITH tb_1 (CustomerID, ProductID, c_cur) AS
(SELECT SOH.CustomerID, SOD.ProductID, COUNT(*) AS c_cur FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID, SOD.ProductID),
tb_2 (CustomerID, c_all) AS
(SELECT SOH.CustomerID, COUNT(*) AS c_all FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID)
SELECT tb_1.CustomerID, tb_1.ProductID, 1.0*tb_1.c_cur/tb_2.c_all 
FROM tb_1 INNER JOIN tb_2 ON tb_1.CustomerID=tb_2.CustomerID

--3 ������� �� ����� �������� ����������: �������� ��������, ����� ���������� ������ ������� ����� ��������, ����� ���������� ����������� ����� ��������

--4 ������� ��� ������� ���������� ���������� � ������������ � ����������� ��������� ����� �������, ����, � ���� �������: ����� ����������, ������������ �����, ����������� �����.
--5 ����� ������ �����������, � ������� �� ���� ��� �� ����� ���� ����� � ���������� ����������� ������������ �������.
--6 ����� ������ �����������, � ������� ��� ��������� ��� ������ ���� ������� ��� ������� ������, �.�. �� ��� ������ ����.