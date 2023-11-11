-- Примеры запросов с решениями
-- 1 Найти покупателя, который каждый раз имел разный список товаров в чеке (по номенклатуре)
SELECT tmp.c
FROM
(SELECT soh.CustomerID AS c
, soh.SalesORDERID AS o
, CHECKSUM_AGG(sod.ProductID) AS ch
FROM [Sales].[SalesORDERDetail] AS sod JOIN
[Sales].[SalesORDERHeader] AS soh
ON sod.SalesORDERID=soh.SalesORDERID
GROUP BY soh.CustomerID, soh.SalesORDERID) tmp
GROUP BY tmp.c
HAVING count(tmp.ch)=count(DISTINCT tmp.ch)
AND count(tmp.ch)>1
-- 2 Найти пары таких покупателей, что список названий товаров, которые они когда-либо покупали, не пересекается ни в одной позиции.
SELECT top 3 t1.c, t2.c
FROM
(SELECT soh.CustomerID AS c,
sod.ProductID AS p
FROM [Sales].[SalesORDERDetail] AS sod JOIN
[Sales].[SalesORDERHeader] AS soh
ON sod.SalesORDERID=sod.SalesORDERID) t1,
(SELECT soh.CustomerID AS c,
sod.ProductID AS p
FROM [Sales].[SalesORDERDetail] AS sod JOIN
[Sales].[SalesORDERHeader] AS soh
ON sod.SalesORDERID=sod.SalesORDERID) t2
WHERE t1.p!=all(SELECT sod.ProductID AS p
FROM [Sales].[SalesORDERDetail] AS sod JOIN
[Sales].[SalesORDERHeader] AS soh
ON sod.SalesORDERID=sod.SalesORDERID
WHERE soh.CustomerID=t2.c)
--3 Вывести номера продуктов, таких, что их цена выше средней цены продукта в подкатегории, к которой относится продукт. Запрос реализовать двумя способами. В одном из решений допускается использование обобщенного табличного выражения.
-- Вариант 1
SELECT p1.ProductID
FROM [Production].[Product] AS p1
WHERE p1.ListPrice>
(
SELECT avg(p2.[ListPrice])
FROM [Production].[Product] AS p2
WHERE p2.ProductSubcategoryID=p1.ProductSubcategoryID
)
-- Вариант 2
with tmp (pscid, acgLP) AS
(SELECT p.ProductSubcategoryID, avg([ListPrice])
FROM [Production].[Product] AS p
GROUP BY p.ProductSubcategoryID)
SELECT p.ProductID
FROM [Production].[Product] AS p JOIN
tmp ON p.ProductSubcategoryID=tmp.pscid
WHERE [ListPrice]>tmp.acgLP
