-- ������������ ������ 2
-- ���� ������: �������� ��������� GROUP BY � ����������� ������

SELECT [Name], [ListPrice], [Color] FROM [Production].[Product]
WHERE [Color] IS NOT NULL;

SELECT COUNT(DISTINCT [Color]) FROM [Production].[Product]
WHERE [Color] IS NOT NULL;

SELECT COUNT([Color]) FROM [Production].[Product]
WHERE [Color] IS NOT NULL;

SELECT COUNT(*) FROM [Production].[Product]
WHERE [Color] IS NOT NULL;

SELECT MAX([ListPrice]) FROM [Production].[Product]
WHERE [Color]='Red';

SELECT [Color], COUNT(*) AS 'Amount'
FROM [Production].[Product]
WHERE [Color] IS NOT NULL
GROUP BY [Color];

-- Error
SELECT [Name], [Color], COUNT(*) AS 'Amount'
FROM [Production].[Product]
WHERE [Color] IS NOT NULL
GROUP BY [Color];

SELECT [Color], [Style], COUNT(*) AS 'Amount'
FROM [Production].[Product]
WHERE [Color] IS NOT NULL AND [Style] IS NOT NULL
GROUP BY [Color], [Style];

SELECT [Color], COUNT(*) AS 'Amount'
FROM [Production].[Product]
WHERE [Color] IS NOT NULL
GROUP BY [Color]
HAVING COUNT(*)>10;

SELECT [Color], COUNT(*) AS 'Amount'
FROM [Production].[Product]
WHERE [Color] IS NOT NULL
GROUP BY [Color]
HAVING COUNT(*)>10 AND MAX([ListPrice])>3000;

SELECT [Color], COUNT(*) AS 'Amount'
FROM [Production].[Product]
GROUP BY [Color]
HAVING [Color] IS NOT NULL;

-- ���������� ����������� GROUP BY ROLLUP, 
-- ������� �������� � ����� � ������������� ����� �����������. ������� ��������� ����� �����:
-- SELECT �������1, �������2, �������3, COUNT(*)
-- FROM �������
-- GROUP BY ROLLUP (�������1, �������2, �������3)

SELECT [Color], [Style], [Class], COUNT(*)
FROM [Production].[Product]
GROUP BY [Color], [Style], [Class];

SELECT [Color], [Style], [Class], COUNT(*)
FROM [Production].[Product]
GROUP BY ROLLUP ([Color], [Style], [Class]);

SELECT COUNT(*)
FROM [Production].[Product]
GROUP BY GROUPING SETS (([Color]),([Size]));