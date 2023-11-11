--1 ����� ���� ������ ������� ���������� �� ������ ��������� �� ������� ����� ����� ��� ������ � ������ ���� ���������. 
--����� ������������ ���������� ��������� ���������.
SELECT [SalesORDERID], p.[ProductID],
[ProductSubcategoryID],
[ORDERQty]*[UnitPrice],
[ORDERQty]*[UnitPrice]/sum([ORDERQty]*[UnitPrice])
OVER(partitiON BY [SalesORDERID]
, [ProductSubcategoryID])
FROM [Sales].[SalesORDERDetail] AS SOD INner JOIN
[Production].[Product] AS p
ON SOD.ProductID=p.ProductID

--2 ��� ������ ���������� ���������� �������, ��� ������ ������� (����), ������� � ������� ����� ���� � ��������� ��������.
--������� 1
with tmp (customer, ORDERid, total) AS
(SELECT soh.CustomerID, soh.SalesORDERID,
sum(sod.[ORDERQty]*[UnitPrice]) AS total
FROM [Sales].[SalesORDERHeader] AS SOH INner JOIN
[Sales].[SalesORDERDetail] AS SOD
ON soh.SalesORDERID=sod.SalesORDERID
GROUP BY soh.CustomerID, soh.SalesORDERID)
SELECT customer, ORDERid, total,
total-LEAD(total,1,0)
OVER(partitiON BY customer ORDER BY ORDERid)
FROM tmp;

--3 ������� ��������� ����������: ����� ����������, ����� ���� ����� ����������, ��������������� �� �����������, 
--������� ���� (�� �����������). ������ ������� ������ ��������� � ������ ����� ������ ����� �������� ���� ���������� 
--�� ����� ����������� ������ ����� ����������.
--������� 1
with tmp (cus, ord, ORDERsum)
AS (SELECT oh.CustomerID, od.SalesORDERID,
sum(od.[UnitPrice]*[ORDERQty])
FROM [Sales].[SalesORDERDetail] AS OD
INner JOIN
[Sales].[SalesORDERHeader] AS OH
ON od.SalesORDERID=oh.SalesORDERID
GROUP BY oh.CustomerID, od.SalesORDERID)
SELECT
cus, ord, ORDERsum,
sum(ORDERsum)
OVER(partitiON BY cus ORDER BY ord desc
RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM tmp;