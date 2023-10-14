-- 1 Ќайти и вывести на экран название продуктов и название категорий товаров, 
-- к которым относитс€ этот продукт, с учетом того, 
-- что в выборку попадут только товары с цветом Red и ценой не менее 100.
SELECT P.Name, PC.Name
FROM Production.Product AS P 
JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID 
JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
WHERE P.Color = 'Red' and P.ListPrice >= 100;

-- 2 ¬ывести на экран названи€ подкатегорий с совпадающими именами.
SELECT PSC_1.Name
FROM Production.ProductSubcategory AS PSC_1,
Production.ProductSubcategory AS PSC_2
WHERE PSC_1.ProductSubcategoryID != PSC_2.ProductSubcategoryID 
AND PSC_1.Name = PSC_2.Name;

-- 3 ¬ывести на экран название категорий и количество товаров в данной категории.
SELECT PC.Name, COUNT(P.Name)
FROM Production.Product AS P 
JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID 
JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.ProductCategoryID, PC.Name;

SELECT COUNT(*)
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL;

-- 4 ¬ывести на экран название подкатегории, а также количество товаров 
-- в данной подкатегории с учетом ситуации, что могут существовать подкатегории с одинаковыми именами.
SELECT PSC.Name, COUNT(P.Name)
FROM Production.Product AS P 
JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID 
GROUP BY PSC.ProductSubcategoryID, PSC.Name;

-- 5 ¬ывести на экран название первых трех подкатегорий с небольшим количеством товаров.
SELECT TOP 3 PSC.Name, COUNT(P.Name) AS Count
FROM Production.Product AS P 
JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID 
GROUP BY PSC.ProductSubcategoryID, PSC.Name
ORDER BY Count desc;

-- 6 ¬ывести на экран название подкатегории и максимальную цену продукта с цветом Red в этой подкатегории.
SELECT PSC.Name, MAX(P.ListPrice)
FROM Production.Product AS P 
JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID 
WHERE P.Color = 'Red'
GROUP BY PSC.ProductSubcategoryID, PSC.Name;

-- 7 ¬ывести на экран название поставщика и количество товаров, которые он поставл€ет.
SELECT SUM(Count) FROM (SELECT V.Name, COUNT(P.ProductID) AS Count
FROM Production.Product AS P 
JOIN Purchasing.ProductVendor AS PV
ON P.ProductID = PV.ProductID
JOIN Purchasing.Vendor AS V
ON PV.BusinessEntityID = V.BusinessEntityID
GROUP BY V.BusinessEntityID, V.Name) AS t;

-- 8 ¬ывести на экран название товаров, которые поставл€ютс€ более чем одним поставщиком.
SELECT P.Name, COUNT(PV.BusinessEntityID) AS Count
FROM Production.Product AS P 
JOIN Purchasing.ProductVendor AS PV
ON P.ProductID = PV.ProductID
GROUP BY P.ProductID, P.Name
HAVING COUNT(PV.BusinessEntityID) > 1;

-- 9 ¬ывести на экран название самого продаваемого товара. (если много раз в SalesOrderDetail)
SELECT TOP 1 P.Name, COUNT(SOD.ProductID) AS Count
FROM Production.Product AS P 
JOIN Sales.SalesOrderDetail AS SOD 
ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID, P.Name
ORDER BY Count desc;

-- 10 ¬ывести на экран название категории, товары из которой продаютс€ наиболее активно.
SELECT TOP 1 PC.Name, COUNT(SOD.ProductID) AS Count
FROM Production.Product AS P 
JOIN Sales.SalesOrderDetail AS SOD 
ON P.ProductID = SOD.ProductID
JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID 
JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.ProductCategoryID, PC.Name
ORDER BY Count desc;

-- 11 ¬ывести на экран названи€ категорий, количество подкатегорий и количество товаров в них.
SELECT COUNT(*) FROM Production.ProductSubcategory;

SELECT t_1.Name, SubcategoryCount, ProductCount
FROM 
(SELECT PC.Name, COUNT(PC.Name) AS SubcategoryCount
FROM Production.ProductSubcategory AS PSC
JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.ProductCategoryID, PC.Name) AS t_1
JOIN
(SELECT PC.Name, COUNT(P.Name) AS ProductCount
FROM Production.Product AS P 
JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID 
JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.ProductCategoryID, PC.Name) AS t_2
ON t_1.Name = t_2.Name;

-- 12 ¬ывести на экран номер кредитного рейтинга и количество товаров, 
-- поставл€емых компани€ми, имеющими этот кредитный рейтинг.
SELECT [CreditRatINg], COUNT(DISTINCT PV.ProductID)
FROM [PurchASINg].[ProductVendor] AS PV INNER JOIN
[PurchASINg].[Vendor] AS V
ON PV.BusINessEntityID=V.BusINessEntityID
GROUP BY [CreditRatINg];

