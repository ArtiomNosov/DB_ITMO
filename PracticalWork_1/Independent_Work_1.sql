--1. Найти и вывести на экран названия продуктов, их цвет и размер.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p;

--2. Найти и вывести на экран названия, цвет и размер таких продуктов, 
--у которых цена более 100.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p WHERE p.ListPrice > 100;

--3. Найти и вывести на экран название, цвет и размер таких продуктов, 
--у которых цена менее 100 и цвет Black.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p WHERE p.ListPrice < 100 AND p.Color = 'Black';

--4. Найти и вывести на экран название, цвет и размер таких продуктов, 
--у которых цена менее 100 и цвет Black, упорядочив вывод по возрастанию стоимости продуктов.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p WHERE p.ListPrice < 100 AND p.Color = 'Black' ORDER BY p.ListPrice;

--5. Найти и вывести на экран название и размер первых трех самых дорогих товаров с цветом Black.
SELECT TOP 3 WITH TIES p.Name, p.Size FROM Production.Product AS p WHERE p.Color = 'Black' ORDER BY p.ListPrice;

--6. Найти и вывести на экран название и цвет таких продуктов, для которых определен и цвет, и размер.
SELECT p.Name, p.Color FROM Production.Product AS p WHERE p.Color IS NOT NULL AND p.Size IS NOT NULL;

--7. Найти и вывести на экран не повторяющиеся цвета продуктов, 
--у которых цена находится в диапазоне от 10 до 50 включительно.
SELECT DISTINCT p.Color FROM Production.Product AS p WHERE p.ListPrice >= 10 AND p.ListPrice <=50;

--8. Найти и вывести на экран все цвета таких продуктов, 
--у которых в имени первая буква ‘L’ и третья ‘N’.
SELECT p.Color FROM Production.Product AS p WHERE p.Name like 'L_N%'

--9. Найти и вывести на экран названия таких продуктов, 
--которых начинаются либо на букву ‘D’, либо на букву ‘M’, и при этом длина имени – более трех символов.
SELECT p.Name FROM Production.Product AS p WHERE p.Name like '[DM]__%' 

--10. Вывести на экран названия продуктов, 
--у которых дата начала продаж – не позднее 2012 года.
SELECT p.Name FROM Production.Product AS p WHERE datepart(YEAR,p.SellStartDate) <= 2012;

--11. Найти и вывести на экран названия всех подкатегорий товаров.
SELECT PSC.Name FROM Production.ProductSubcategory AS PSC;

--12. Найти и вывести на экран названия всех категорий товаров.
SELECT PC.Name FROM Production.ProductCategory AS PC;

--13. Найти и вывести на экран имена всех клиентов из таблицы Person, 
--у которых обращение (Title) указано как «Mr.».
SELECT P.FirstName FROM Person.Person AS P WHERE P.Title like 'Mr.%';

--14. Найти и вывести на экран имена всех клиентов из таблицы Person, 
--для которых не определено обращение (Title).
SELECT P.FirstName FROM Person.Person AS P WHERE P.Title IS NULL;