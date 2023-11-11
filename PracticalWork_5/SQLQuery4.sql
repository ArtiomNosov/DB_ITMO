-- 1 Ќайти среднее количество покупок на чек дл€ каждого покупател€ (2 способа).
SELECT SOH.CustomerID, AVG(SOD.OrderQty) FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID;
SELECT * FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
--2 Ќайти дл€ каждого продукта и каждого покупател€ соотношение количества фактов покупки данного товара данным покупателем 
-- к общему количеству фактов покупки товаров данным покупателем
SELECT * FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID

SELECT SOH.CustomerID, SOD.ProductID, COUNT(*) AS c FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID, SOD.ProductID;

WITH tb_1 (CustomerID, ProductID, c_cur) AS
(SELECT SOH.CustomerID, SOD.ProductID, COUNT(*) AS c_cur FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID, SOD.ProductID),
tb_2 (CustomerID, c_all) AS
(SELECT SOH.CustomerID, COUNT(*) AS c_all FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID)
SELECT tb_1.CustomerID, tb_1.ProductID, 1.0*tb_1.c_cur/tb_2.c_all 
FROM tb_1 INNER JOIN tb_2 ON tb_1.CustomerID=tb_2.CustomerID

--3 ¬ывести на экран след€щую информацию: Ќазвание продукта, ќбщее количество фактов покупки этого продукта, ќбщее количество покупателей этого продукта

--4 ¬ывести дл€ каждого покупател€ информацию о максимальной и минимальной стоимости одной покупки, чеке, в виде таблицы: номер покупател€, максимальна€ сумма, минимальна€ сумма.
--5 Ќайти номера покупателей, у которых не было нет ни одной пары чеков с одинаковым количеством наименований товаров.
--6 Ќайти номера покупателей, у которых все купленные ими товары были куплены как минимум дважды, т.е. на два разных чека.