SELECT SalesORDERID, ProductID, ORDERQty ,
SUM(ORDERQty) OVER(PARTITION BY SalesORDERID) AS Total
,AVG(ORDERQty) OVER(PARTITION BY SalesORDERID) AS "Avg"
,COUNT(ORDERQty) OVER(PARTITION BY SalesORDERID) AS "Count"
,MIN(ORDERQty) OVER(PARTITION BY SalesORDERID) AS "MIN"
,MAX(ORDERQty) OVER(PARTITION BY SalesORDERID) AS "Max"
FROM Sales.SalesORDERDetail
WHERE SalesORDERID IN(43659,43664)

SELECT * FROM Sales.SalesORDERDetail

SELECT SalesORDERID, ProductID, ORDERQty
,SUM(ORDERQty) OVER(PARTITION BY SalesORDERID) AS Total
,CAST(1. * ORDERQty / SUM(ORDERQty) OVER(PARTITION BY SalesORDERID)
*100 AS DECIMAL(5,2))AS "Percent BY ProductID"
FROM Sales.SalesORDERDetail
WHERE SalesORDERID IN(43659,43664)

SELECT BusINessEntityID, TerritoryID
,CONVERT(varchar(20),SalesYTD,1) AS SalesYTD
,DATEPART(yy,ModifiedDate) AS SalesYear
,CONVERT(varchar(20),SUM(SalesYTD) OVER (PARTITION BY TerritoryID
ORDER BY DATEPART(yy,ModifiedDate)
ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING ),1) AS CumulativeTotal
FROM Sales.SalesPerson
WHERE TerritoryID IS NULL OR TerritoryID < 5

SELECT Name, ListPrice,
FIRST_VALUE(Name) OVER (ORDER BY ListPrice ASC) AS LeAStExpensive
FROM Production.Product
WHERE ProductSubcategoryID = 37

SELECT * 
FROM Production.Product
WHERE ProductSubcategoryID = 37

SELECT Department, LastName, Rate, HireDate,
LAST_VALUE(HireDate) OVER (PARTITION BY Department ORDER BY Rate) AS LAStValue
FROM HumanResources.vEmployeeDepartmentHistory AS edh
INNER JOIN HumanResources.EmployeePayHistory AS eph
ON eph.BusINessEntityID = edh.BusINessEntityID
INNER JOIN HumanResources.Employee AS e
ON e.BusINessEntityID = edh.BusINessEntityID
WHERE Department IN (N'INformatiON Services',N'Document CONtrol')

SELECT BusINessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota,
LAG(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS PreviousQuota
FROM Sales.SalesPersonQuotaHistory
WHERE BusINessEntityID = 275 AND YEAR(QuotaDate) IN ('2011','2012')

SELECT BusINessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota,
LEAD(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS NextQuota
FROM Sales.SalesPersonQuotaHistory
WHERE BusINessEntityID = 275 AND YEAR(QuotaDate) IN ('2011','2012')

SELECT p.FirstName, p.LastName
,ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"
,NTILE(2) OVER (ORDER BY a.PostalCode) AS Quartile
,s.SalesYTD
,a.PostalCode
FROM Sales.SalesPerson AS s
INNER JOIN Person.Person AS p
ON s.BusINessEntityID = p.BusINessEntityID
INNER JOIN Person.Address AS a
ON a.AddressID = p.BusINessEntityID
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0