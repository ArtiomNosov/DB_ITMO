-- ������� ������ �� ���������� ������.

-- ��������� � ������� ��� ��������� ���������, 
-- ������������ ������� ���������������� ������.

-- ������������� ���� � ���������, ������� �� �������� ������������, 
-- ����� ����������� ����������� ������� ���������. ��������� ����� �����
-- ��������� ������������� ������. ���� ������������� ���� 
-- ������� �� ���������� ���������, �� ���������� ��������� ������.

-- ��������� ���� � ������������� ����, 
-- ������� ������ ��� ���������� ������������� �������� ������ ���������.

-- ������� ���� � ������� ��� ��������� ��������� ������ ���������, 
-- ������� ������������� �������������� ����� ���������� (����� ����, ���� �� ������) ���������. 
-- ������� ����� ��������� ������� ����� ����� �����������.

SELECT p.Name, s.Name
FROM [Production].[Product] p INNER JOIN [Production].[ProductSubcategory] s
ON p.ProductSubcategoryID=s.ProductSubcategoryID;

-- LEFT JOIN
SELECT p.Name, s.Name
FROM [Production].[Product] p LEFT JOIN [Production].[ProductSubcategory] s
ON p.ProductSubcategoryID=s.ProductSubcategoryID;

-- RIGHT JOIN
SELECT p.Name, s.Name
FROM [Production].[Product] p RIGHT JOIN [Production].[ProductSubcategory] s
ON p.ProductSubcategoryID=s.ProductSubcategoryID;

-- FULL JOIN
SELECT [tAvalue], [tBvalue] 
FROM [dbo].[tA] FULL JOIN [dbo].[tB] 
ON tA.[tAvalue]=tB.[tBvalue];

-- CROSS JOIN
SELECT [tAvalue], [tBvalue] FROM
[dbo].[tA] CROSS JOIN [dbo].[tB];

SELECT p1.Name
FROM [Production].[Product] p1 JOIN
[Production].[Product] p2
ON p1.Name=p2.Name AND
p1.ProductID!=p2.ProductID;