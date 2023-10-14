-- ¬ыборка данных из нескольких таблиц.

-- —уперключ Ц атрибут или множество атрибутов, 
-- единственным образом идентифицирующие кортеж.

-- ѕотенциальный ключ Ц суперключ, который не содержит подмножества, 
-- также €вл€ющегос€ суперключом данного отношени€. ќтношение может иметь
-- несколько потенциальных ключей. ≈сли потенциальный ключ 
-- состоит из нескольких атрибутов, он называетс€ составным ключом.

-- ѕервичный ключ Ц потенциальный ключ, 
-- который выбран дл€ уникальной идентификации кортежей внутри отношени€.

-- ¬нешний ключ Ц атрибут или множество атрибутов внутри отношени€, 
-- которое соответствует потенциальному ключу некоторого (может быть, того же самого) отношени€. 
-- ¬нешние ключи позвол€ют описать св€зь между отношени€ми.

SELECT p.Name, s.Name
FROM [Production].[Product] p INNER JOIN [Production].[ProductSubcategory] s
ON p.ProductSubcategoryID=s.ProductSubcategoryID;

-- LEFT JOIN
SELECT p.Name, s.Name
FROM [Production].[Product] p LEFT JOIN [Production].[ProductSubcategory] s
ON p.ProductSubcategoryID=s.ProductSubcategoryID;

-- RIGHT JOIN
SELECT p.Name, s.Name
FROM [Production].[Product] p RIGHT JOIN [Production].[ProductSubcategory] s
ON p.ProductSubcategoryID=s.ProductSubcategoryID;

-- FULL JOIN
SELECT [tAvalue], [tBvalue] 
FROM [dbo].[tA] FULL JOIN [dbo].[tB] 
ON tA.[tAvalue]=tB.[tBvalue];

-- CROSS JOIN
SELECT [tAvalue], [tBvalue] FROM
[dbo].[tA] CROSS JOIN [dbo].[tB];

SELECT p1.Name
FROM [Production].[Product] p1 JOIN
[Production].[Product] p2
ON p1.Name=p2.Name AND
p1.ProductID!=p2.ProductID;