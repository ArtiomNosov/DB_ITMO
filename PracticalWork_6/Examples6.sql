--1 Ќайти долю затрат каждого покупател€ на каждый купленный им продукт среди общих его затрат в данной сети магазинов. 
--ћожно использовать обобщенное табличное выражение.
SELECT [SalesORDERID], p.[ProductID],
[ProductSubcategoryID],
[ORDERQty]*[UnitPrice],
[ORDERQty]*[UnitPrice]/sum([ORDERQty]*[UnitPrice])
OVER(partitiON BY [SalesORDERID]
, [ProductSubcategoryID])
FROM [Sales].[SalesORDERDetail] AS SOD INner JOIN
[Production].[Product] AS p
ON SOD.ProductID=p.ProductID

--2 ƒл€ одного выбранного покупател€ вывести, дл€ каждой покупки (чека), разницу в деньгах между этой и следующей покупкой.
--¬ариант 1
with tmp (customer, ORDERid, total) AS
(SELECT soh.CustomerID, soh.SalesORDERID,
sum(sod.[ORDERQty]*[UnitPrice]) AS total
FROM [Sales].[SalesORDERHeader] AS SOH INner JOIN
[Sales].[SalesORDERDetail] AS SOD
ON soh.SalesORDERID=sod.SalesORDERID
GROUP BY soh.CustomerID, soh.SalesORDERID)
SELECT customer, ORDERid, total,
total-LEAD(total,1,0)
OVER(partitiON BY customer ORDER BY ORDERid)
FROM tmp;

--3 ¬ывести следующую информацию: номер покупател€, номер чека этого покупател€, отсортированные по покупател€м, 
--номерам чека (по возрастанию). “реть€ колонка должна содержать в каждой своей строке сумму текущего чека покупател€ 
--со всеми предыдущими чеками этого покупател€.
--¬ариант 1
with tmp (cus, ord, ORDERsum)
AS (SELECT oh.CustomerID, od.SalesORDERID,
sum(od.[UnitPrice]*[ORDERQty])
FROM [Sales].[SalesORDERDetail] AS OD
INner JOIN
[Sales].[SalesORDERHeader] AS OH
ON od.SalesORDERID=oh.SalesORDERID
GROUP BY oh.CustomerID, od.SalesORDERID)
SELECT
cus, ord, ORDERsum,
sum(ORDERsum)
OVER(partitiON BY cus ORDER BY ord desc
RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM tmp;