-- 1. Найти и вывести на экран количество товаров каждого цвета, 
-- исключив из поиска товары, цена которых меньше 30.
SELECT P.Color, COUNT(*) AS Count
FROM Production.Product AS P
WHERE P.ListPrice < 30
GROUP BY P.Color;

-- 2. Найти и вывести на экран список, состоящий из цветов товаров, 
-- таких, что минимальная цена товара данного цвета более 100.
SELECT P.Color, COUNT(*) AS Count
FROM Production.Product AS P
WHERE P.ListPrice > 100
GROUP BY P.Color;

-- 3. Найти и вывести на экран номера подкатегорий товаров 
-- и количество товаров в каждой категории.
SELECT P.ProductSubcategoryID, COUNT(*)
FROM Production.Product AS P
GROUP BY P.ProductSubcategoryID;

-- 4. Найти и вывести на экран номера товаров 
-- и количество фактов продаж данного товара 
-- (используется таблица SalesORDERDetail)
SELECT P.ProductID, COUNT(*)
FROM Sales.SalesORDERDetail AS SOD
JOIN Production.Product AS P
ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID;

-- 5. Найти и вывести на экран номера товаров, 
-- которые были куплены более пяти раз.
SELECT P.ProductID, COUNT(*)
FROM Sales.SalesORDERDetail AS SOD
JOIN Production.Product AS P
ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID
HAVING COUNT(*) > 5;

-- 6. Найти и вывести на экран номера покупателей, CustomerID, 
-- у которых существует более одного чека, SalesORDERID, 
-- с одинаковой датой
SELECT C.CustomerID
FROM Sales.Customer AS C
JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID
HAVING COUNT(*) > 1;
-- 7. Найти и вывести на экран все номера чеков, 
-- на которые приходится более трех продуктов.
SELECT SOH.SalesOrderID
FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.SalesOrderID
HAVING COUNT(*) > 1;

-- 8. Найти и вывести на экран все номера продуктов, 
-- которые были куплены более трех раз.
SELECT P.ProductID
FROM Sales.SalesOrderDetail AS SOD
JOIN Production.Product AS P
ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID
HAVING COUNT(*) > 3;

-- 9. Найти и вывести на экран все номера продуктов, 
-- которые были куплены или три или пять раз.
SELECT P.ProductID
FROM Sales.SalesOrderDetail AS SOD
JOIN Production.Product AS P
ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID
HAVING COUNT(*) = 3 OR COUNT(*) = 5;

-- 10. Найти и вывести на экран все номера подкатегорий, 
-- в которым относится более десяти товаров.
SELECT P.ProductSubcategoryID
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID
HAVING COUNT(*) > 10;

-- 11. Найти и вывести на экран номера товаров, 
-- которые всегда покупались в одном экземпляре за одну покупку.
SELECT DISTINCT SOD.ProductID 
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.SalesOrderID IN (SELECT SOD.SalesOrderID
FROM Sales.SalesOrderDetail AS SOD
GROUP BY SOD.SalesOrderID
HAVING COUNT(SOD.ProductID) = 1);

-- 12 Найти и вывести на экран номер чека, SalesORDERID, 
-- на который приходится с наибольшим разнообразием товаров 
-- купленных на этот чек.
SELECT DISTINCT SOD.SalesORDERID
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.SalesOrderID IN (SELECT TOP 1 SOD.SalesOrderID
FROM Sales.SalesOrderDetail AS SOD
GROUP BY SOD.SalesOrderID
ORDER BY COUNT(*) DESC);

-- 13 Найти и вывести на экран номер чека, SalesORDERID 
-- с наибольшей суммой покупки, исходя из того, 
-- что цена товара – это UnitPrice, а количество конкретного 
-- товара в чеке – это ORDERQty
SELECT TOP 1 SOD.SalesOrderDetailID
FROM Sales.SalesOrderDetail AS SOD
ORDER BY SOD.UnitPrice*SOD.OrderQty DESC;

-- 14 Определить количество товаров в каждой подкатегории, 
-- исключая товары, для которых подкатегория не определена, 
-- и товары, у которых не определен цвет.
SELECT P.ProductSubcategoryID
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL AND P.Color IS NULL
GROUP BY P.ProductSubcategoryID;

-- 15 Получить список цветов товаров в порядке 
-- убывания количества товаров данного цвета
SELECT P.Color
FROM Production.Product AS P
GROUP BY P.Color
ORDER BY COUNT(*) DESC;

-- 16 Вывести на экран ProductID тех товаров, что всегда 
-- покупались в количестве более 1 единицы на один чек, 
-- при этом таких покупок было более двух.
SELECT DISTINCT SOD.ProductID 
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.SalesOrderID IN (SELECT SOD.SalesOrderID
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.OrderQty > 1
GROUP BY SOD.SalesOrderID
HAVING COUNT(SOD.ProductID) > 2);
