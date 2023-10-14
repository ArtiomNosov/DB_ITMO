-- 1. ����� ������ ������ ���� ������������ (ProductSubcategoryID) 
-- � ���������� ����������� ������������ �������.
SELECT TOP 3 WITH TIES [ProductSubcategoryID]
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
GROUP BY [ProductSubcategoryID]
ORDER BY COUNT(*) DESC;

-- 2. ������� �������� �� ���������� �������� � ��������, 
-- ��� ������ ������ ���������� ���������� ���������.
SELECT LEN([Name]), COUNT(*)
FROM [Production].[Product]
GROUP BY LEN([Name]);

-- 3. ���������, ���� �� �������� � ���������� ���������, ���� ����, �� ������� ��� ��������.
SELECT [Name]
FROM [Production].[Product]
GROUP BY [ProductID], [Name]
HAVING COUNT(*)>1;

