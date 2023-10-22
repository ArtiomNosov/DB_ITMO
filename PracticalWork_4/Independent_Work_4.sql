--Задания для самостоятельной работы
--1 Найти название самого продаваемого продукта.
SELECT P.Name FROM Production.Product AS P WHERE P.ProductID IN
(SELECT TOP 1 WITH TIES SOD.ProductID FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID
ORDER BY COUNT(*) DESC);
--2 Найти покупателя, совершившего покупку на самую большую сумм, считая сумму покупки исходя из цены товара без скидки (UnitPrice).
SELECT C.CustomerID FROM Sales.Customer AS C WHERE C.CustomerID IN
(SELECT TOP 1 WITH TIES SOH.CustomerID FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
ORDER BY SOD.OrderQty*SOD.UnitPrice DESC);

--3 Найти такие продукты, которые покупал только один покупатель.
SELECT SOD1.ProductID,
(SELECT COUNT(DISTINCT SOH.CustomerID) FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOD.ProductID = SOD1.ProductID)

FROM Sales.SalesOrderDetail AS SOD1 JOIN Sales.SalesOrderHeader
AS SOH1 ON SOD1.SalesOrderID = SOH1.SalesOrderID;

--4 Вывести список продуктов, цена которых выше средней цены товаров в подкатегории, к которой относится товар.
SELECT P.Name
FROM Production.Product AS P
WHERE P.ListPrice > 
(
	SELECT AVG(P2.ListPrice) FROM Production.Product AS P2
	WHERE P.ProductSubcategoryID = P2.ProductSubcategoryID
);
--5 Найти такие товары, которые были куплены более чем одним покупателем, 
-- при этом все покупатели этих товаров покупали товары только одного цвета 
-- и товары не входят в список покупок покупателей, купивших товары только двух цветов.
SELECT SOD1.ProductID

FROM Sales.SalesOrderDetail AS SOD1 JOIN Sales.SalesOrderHeader
AS SOH1 ON SOD1.SalesOrderID = SOH1.SalesOrderID
WHERE (SELECT COUNT(DISTINCT SOH.CustomerID) FROM Sales.SalesOrderDetail AS SOD JOIN Sales.SalesOrderHeader
AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOD.ProductID = SOD1.ProductID) > 1;

SELECT DISTINCT SOD2.ProductID
FROM Sales.SalesOrderDetail AS SOD2 JOIN Sales.SalesOrderHeader
AS SOH2 ON SOD2.SalesOrderID = SOH2.SalesOrderID

SELECT t.ProductID FROM (SELECT DISTINCT SOD2.ProductID
FROM Sales.SalesOrderDetail AS SOD2 JOIN Sales.SalesOrderHeader
AS SOH2 ON SOD2.SalesOrderID = SOH2.SalesOrderID
WHERE SOH2.CustomerID = CID) AS t

(SELECT COUNT(P.Color) FROM Production.Product AS P
WHERE 
P.ProductID = t.ProductID);


--6 Найти такие товары, которые были куплены такими покупателями, у которых они присутствовали в каждой их покупке.
--7 Найти покупателей, у которых есть товар, присутствующий в каждой покупке/чеке.
--8 Найти такой товар или товары, которые были куплены не более чем тремя различными покупателями.
--9 Найти все товары, такие что их покупали всегда с товаром, цена которого максимальна в своей категории.
--10 Найти номера тех покупателей, у которых есть как минимум два чека, и каждый из этих чеков содержит как минимум три товара, каждый из которых как минимум был куплен другими покупателями три раза.
--11 Найти все чеки, в которых каждый товар был куплен дважды этим же покупателем.
--12 Найти товары, которые были куплены минимум три раза различными покупателями.
--13 Найти такую подкатегорию или подкатегории товаров, которые содержат более трех товаров, купленных более трех раз.
--14 Найти те товары, которые не были куплены более трех раз, и как минимум дважды одним и тем же покупателем.