-- ������� �������� � ���������
--�������� ������� � ����������� ��������� � ����������. 

--1. �������� ��� �������� ������� �� ������� Product. 
SELECT p.Name FROM Production.Product AS p;
--� ������ ������ ��� ������� Product �� ����� Production ������ ��������� p. 
--�������� ������������� ����������� ��������� ��������� �������� ��������� ���� � MS SQL Management Studio.

--2. �������� ��� �������� ������� � �������, ���� ������� (listprice) ���� 200. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.ListPrice>200

--3. �������� ��� �������� ������� � ������� ���� ������� (listprice) ���� 200 � � ������� ������ ����� � �������� �S�. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.ListPrice>200 AND p.Name like 'S%'

--4. �������� ��� �������� ������� � �������, ���� ������� (listprice) ���� 200 � � ������� � �������� ���� ��������� �������� �are�. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.ListPrice>200 AND p.Name like '%are%'

--5. �������� ��� �������� ������� � �������, � �������� ������� ������ 
-- ������ � ���� ����� �s�, ���� ����� �r�. ������ ������ ��� ������� ����� ���������. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.Name like '__s%' or p.Name like '__r%' 
-- ���
SELECT p.Name FROM [Production].[Product] AS p WHERE p.Name like '__[sr]%'

--7. �������� ��� �������� ������� � �������, � �������� ������� ����� 5 ��������. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.Name like '_____' 
-- ��� ������ ������� 
SELECT p.Name FROM [Production].[Product] AS p WHERE len(p.Name)=5 
-- �� ������ ������� ������������ ��������� ������� len. ��������� ������� ���� � ����������.

--8. �����, ��� ����������, ������ �������, ������� ���� ������� ���� �� ���� ���. 
SELECT DISTINCT sod.ProductID FROM [Sales].[SalesORDERDetail] AS sod

--9. ����� ������ ���� ��������� ������ (style) ��������, ��� ����������. 
SELECT DISTINCT p.Style FROM [Production].[Product] AS p WHERE p.Style is NOT null

--10.�������� ������, ������� ���������� �������� �������, ������� ���� ����������� 
-- ����� ������ 2011 ���� � ������ 2012 ���� ������������ (���������� ��������� ������ ����) 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.SellStartDate>='2011-01-03' AND p.SellStartDate<='2012-31-03'

--11. ����� ������������ ��������� ������ (��������� ���� ListPrice) �� ���, ������� ���� �����������, ������� � ����� 2011 ����. 
SELECT max(p.ListPrice) AS [max price] FROM [Production].[Product] AS p WHERE p.SellStartDate>='2011-01-03'

--12. ������� �������� � ���� ��������, ��������������� �� �������� �������� �� �����������. 
SELECT p.Name, p.Color FROM [Production].[Product] AS p ORDER BY p.Name ASc

--13. ������� �������� ��������, ���� � ��������� ���� ��� ����� �������, � ������� ���� ��������� 
-- � ���� ������� �� ����, � ������������� ���������� ������ �� ����������� ����� ������ � �������� ��������� ����. 
SELECT p.Name, p.Color, p.ListPrice FROM [Production].[Product] AS p 
WHERE p.Color is NOT null AND p.ListPrice!=0 ORDER BY p.Color, p.ListPrice desc

-- 14. �������� �������� �������� � ������� ����� ��������� ����������� ����� �������� � 
-- ����������� ����� �������� ��� ��� �������, � ������� ��� ���������� �� ����� ����. 
SELECT p.Name, p.ListPrice-p.StandardCost FROM [Production].[Product] AS p WHERE p.ListPrice!=0 AND p.StandardCost!=0

--15. ����� �������� ������ �������� ������, ������ �� �������������, ��� ��� ���� ������� � ���������� �����. 
SELECT top 1 with ties p.Name, p.ListPrice FROM [Production].[Product] AS p ORDER BY p.ListPrice desc

--16. ����� ������ �������, ������������� � 2011 ����. 
SELECT p.Name FROM [Production].[Product] AS p WHERE datepart(YEAR,p.SellStartDate)=2011