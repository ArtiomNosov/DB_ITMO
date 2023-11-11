SELECT SOH.CustomerID, AVG(SOD.OrderQty) FROM Sales.SalesOrderHeader AS SOH 
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID;