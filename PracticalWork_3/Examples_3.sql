-- 1. Найти название продуктов и название подкатегорий этих продуктов, 
-- у которых отпускная цена больше 100, не включая случаи, 
-- когда продукт не относится ни к какой подкатегории.
SELECT P.Name, PSC.Name
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
WHERE [ListPrice]>100;

-- 2. Найти название продуктов и название подкатегорий этих продуктов, 
-- у которых отпускная цена больше 100, включая случаи, 
-- когда продукт не относится ни к какой категории.
SELECT P.Name, PSC.Name
FROM [Production].[Product] AS P LEFT JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
WHERE [ListPrice]>100;

-- 3 Найти название продуктов и название категорий из таблицы ProductCategory, 
-- с которой связан этот продукт, не включая случаи, 
-- когда у продукта нет подкатегории.
SELECT P.Name, PC.Name
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID;

-- 4 Найти название продукта, отпускную цену продукта, 
-- а также последнюю отпускную цену этого продукта (LAStReceiptCost), 
-- которую можно узнать из таблицы ProductVendor.
SELECT P.Name, P.ListPrice, PV.LAStReceiptCost
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID;

-- 5 Найти название продукта, отпускную цену продукта, 
-- а также последнюю отпускную цену этого продукта (LAStReceiptCost), 
-- которую можно узнать из таблицы ProductVendor, для таких продуктов, 
-- у которых отпускная цена оказалась ниже последней отпускной цены у поставщика, 
-- исключив те товары, для которых отпускная цена равна нулю.
SELECT P.Name, P.ListPrice, PV.LAStReceiptCost
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID
WHERE P.ListPrice!=0 AND P.ListPrice<PV.LAStReceiptCost;

-- 6 Найти количество товаров, которые поставляют поставщики 
-- с самым низким кредитным рейтингом 
-- (CreditRatINg принимает целые значение от минимального, равного 1, до максимального, равного 5).
SELECT COUNT(DISTINCT PV.ProductID)
FROM [PurchASINg].[ProductVendor] AS PV INNER JOIN
[PurchASINg].[Vendor] AS V
ON PV.BusINessEntityID=V.BusINessEntityID
WHERE [CreditRatINg]=1;

-- 7 Найти, сколько товаров приходится на каждый кредитный рейтинг, 
-- т.е. сформировать таблицу, первая колонка, 
-- которой будет содержать номер кредитного рейтинга, вторая – количество товаров, 
-- поставляемых всеми поставщиками, имеющими соответствующий кредитный рейтинг. 
-- Необходимо сформировать универсальный запрос, 
-- который будет валидным и в случае появления новых значений кредитного рейтинга.
SELECT [CreditRatINg], COUNT(DISTINCT PV.ProductID)
FROM [PurchASINg].[ProductVendor] AS PV INNER JOIN
[PurchASINg].[Vendor] AS V
ON PV.BusINessEntityID=V.BusINessEntityID
GROUP BY [CreditRatINg];

-- 8 Найти номера первых трех подкатегорий (ProductSubcategoryID) 
-- с наибольшим количеством наименований товаров.
SELECT TOP 3 [ProductSubcategoryID], COUNT(*) AS Count
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
GROUP BY [ProductSubcategoryID]
ORDER BY COUNT(*) DESC;

-- 9 Получить названия первых трех подкатегорий с наибольшим количеством наименований товаров.
SELECT TOP 3 PC.ProductCategoryID, COUNT(*)
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID
GROUP BY PC.ProductCategoryID
ORDER BY COUNT(*) DESC;
SELECT top 3 psc.name, count(*)
FROM [Production].[Product] AS p INner JOIN
[Production].[ProductSubcategory] AS psc
ON p.ProductSubcategoryID=psc.ProductSubcategoryID
WHERE p.ProductSubcategoryID is NOT null
GROUP BY p.ProductSubcategoryID, psc.Name
ORDER BY count(*) desc;

-- 10 Высчитать среднее количество товаров, приходящихся на одну подкатегорию, с точностью минимум до одной десятой.
-- Вариант 1
SELECT 1.0*COUNT(*)/COUNT(DISTINCT [ProductSubcategoryID])
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
-- Вариант 2
SELECT CAST(COUNT(*) AS FLOAT)/COUNT(DISTINCT [ProductSubcategoryID])
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
-- Вариант 3
SELECT cASt((cASt(count(p.ProductID) AS float)/count(DISTINCT p.ProductSubcategoryID))
AS decimal(6,3))
FROM [Production].[Product] AS p
WHERE p.ProductSubcategoryID is NOT null;

-- 11 Вычислить среднее количество товаров, приходящихся на одну категорию, в целых числах.
SELECT COUNT(*)/COUNT(DISTINCT PC.ProductCategoryID)
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
RIGHT JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID;

-- 12 Найти количество цветов товаров, приходящихся на каждую категорию, 
-- без учета товаров, для которых цвет не определен.
SELECT COUNT(DISTINCT [Color])
FROM [Production].[Product] AS P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
RIGHT JOIN [Production].[ProductCategory] AS PC
ON PSC.ProductCategoryID=PC.ProductCategoryID
GROUP BY PC.ProductCategoryID;

-- 13 Найти средний вес продуктов. Просмотреть таблицу продуктов и убедиться, 
-- что есть продукты, для которых вес не определен. Модифицировать запрос так, 
-- чтобы при нахождении среднего веса продуктов те продукты, 
-- для которых вес не определен, считались как продукты с весом 10.
SELECT AVG(ISNULL([Weight],10))
FROM [Production].[Product];

-- 14 Вывести названия продуктов и период их активных продаж 
-- (период между SellStartDate и SellEndDate) в днях, отсортировав по уменьшению времени продаж. 
-- Если продажи идут до сих пор и SellEndDate не определен, 
-- то считать периодом продаж число дней с начала продаж и по текущие сутки.
SELECT [Name], [SellStartDate], [SellEndDate],
DATEDIFF(D,[SellStartDate],ISNULL([SellEndDate],GETDATE())) AS diff
FROM [Production].[Product]
WHERE [SellStartDate] IS NOT NULL
ORDER BY diff desc;

-- 15 Разбить продукты по количеству символов в названии, 
-- и для каждой группы определить количество продуктов.
SELECT LEN([Name]), COUNT(*)
FROM [Production].[Product]
GROUP BY LEN([Name]);

-- 16 Найти для каждого поставщика количество подкатегорий продуктов, 
-- к которым относится продукты, поставляемые им, без учета ситуации, 
-- когда продукт не относится ни к какой подкатегории.
SELECT PV.BusINessEntityID, COUNT(DISTINCT P.ProductSubcategoryID)
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY PV.BusINessEntityID;

-- 17 Проверить, есть ли продукты с одинаковым названием, если есть, то вывести эти названия.
-- Вариант 1
SELECT P1.Name
FROM [Production].[Product] AS P1,
[Production].[Product] AS P2
WHERE P1.ProductID!=P2.ProductID AND
P1.Name=P2.Name; 
-- Вариант 2
SELECT [Name]
FROM [Production].[Product]
GROUP BY [ProductID], [Name]
HAVING COUNT(*)>1; 

-- 18 Найти первые 10 самых дорогих товаров, с учетом ситуации, 
-- когда цена цены у некоторых товаров могут совпадать. (WITH TIES) !!!
SELECT TOP 10 WITH TIES [Name]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

-- 19 Найти первые 10 процентов самых дорогих товаров, с учетом ситуации, 
-- когда цены у некоторых товаров могут совпадать.
SELECT TOP 10 PERCENT WITH TIES [Name]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

-- 20 Найти первых трех поставщиков, отсортированных по количеству поставляемых товаров, 
-- с учетом ситуации, что количество поставляемых товаров может совпадать для разных поставщиков.
SELECT TOP 3 WITH TIES PV.BusINessEntityID
FROM [Production].[Product] AS P INNER JOIN
[PurchASINg].[ProductVendor] AS PV
ON P.ProductID=PV.ProductID
GROUP BY PV.BusINessEntityID
ORDER BY COUNT(P.ProductID) DESC;
