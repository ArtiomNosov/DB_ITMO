-- Практическая работа 2
-- Цель работы: Изучение выражения GROUP BY – группировка данных

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

-- Рассмотрим конструкцию GROUP BY ROLLUP, 
-- которая выводить и общие и промежуточные итоги группировки. Частный синтаксис будет такой:
-- SELECT столбец1, столбец2, столбец3, COUNT(*)
-- FROM таблица
-- GROUP BY ROLLUP (столбец1, столбец2, столбец3)

SELECT [Color], [Style], [Class], COUNT(*)
FROM [Production].[Product]
GROUP BY [Color], [Style], [Class];

SELECT [Color], [Style], [Class], COUNT(*)
FROM [Production].[Product]
GROUP BY ROLLUP ([Color], [Style], [Class]);

SELECT COUNT(*)
FROM [Production].[Product]
GROUP BY GROUPING SETS (([Color]),([Size]));