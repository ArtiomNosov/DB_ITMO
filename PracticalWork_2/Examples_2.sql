-- 1. Найти номера первых трех подкатегорий (ProductSubcategoryID) 
-- с наибольшим количеством наименований товаров.
SELECT TOP 3 WITH TIES [ProductSubcategoryID]
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
GROUP BY [ProductSubcategoryID]
ORDER BY COUNT(*) DESC;

-- 2. Разбить продукты по количеству символов в названии, 
-- для каждой группы определить количество продуктов.
SELECT LEN([Name]), COUNT(*)
FROM [Production].[Product]
GROUP BY LEN([Name]);

-- 3. Проверить, есть ли продукты с одинаковым названием, если есть, то вывести эти названия.
SELECT [Name]
FROM [Production].[Product]
GROUP BY [ProductID], [Name]
HAVING COUNT(*)>1;

