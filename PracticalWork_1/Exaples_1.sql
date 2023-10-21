-- Примеры запросов с решениями
--Описание функций и архитектура приведены в приложении. 

--1. Получить все названия товаров из таблицы Product. 
SELECT p.Name FROM Production.Product AS p;
--В данном случае для таблицы Product из схемы Production введен псевдоним p. 
--Разумное использование псевдонимов позволяет увеличить скорость написания кода в MS SQL Management Studio.

--2. Получить все названия товаров в системе, цена которых (listprice) выше 200. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.ListPrice>200

--3. Получить все названия товаров в системе цена которых (listprice) выше 200 и у которых первая буква в названии “S”. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.ListPrice>200 AND p.Name like 'S%'

--4. Получить все названия товаров в системе, цена которых (listprice) выше 200 и у которых в названии есть сочетание символов “are”. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.ListPrice>200 AND p.Name like '%are%'

--5. Получить все названия товаров в системе, в названии которых третий 
-- символ – либо буква “s”, либо буква “r”. Решить задачу как минимум двумя способами. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.Name like '__s%' or p.Name like '__r%' 
-- или
SELECT p.Name FROM [Production].[Product] AS p WHERE p.Name like '__[sr]%'

--7. Получить все названия товаров в системе, в названии которых ровно 5 символов. 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.Name like '_____' 
-- Или второй вариант 
SELECT p.Name FROM [Production].[Product] AS p WHERE len(p.Name)=5 
-- Во втором примере используется строковая функция len. Строковые функции даны в приложении.

--8. Найти, без повторений, номера товаров, которые были куплены хотя бы один раз. 
SELECT DISTINCT sod.ProductID FROM [Sales].[SalesORDERDetail] AS sod

--9. Найти список всех возможных стилей (style) продукта, без повторений. 
SELECT DISTINCT p.Style FROM [Production].[Product] AS p WHERE p.Style is NOT null

--10.Написать запрос, который возвращает названия товаров, которые были произведены 
-- между мартом 2011 года и мартом 2012 года включительно (необходимо учитывать формат даты) 
SELECT p.Name FROM [Production].[Product] AS p WHERE p.SellStartDate>='2011-01-03' AND p.SellStartDate<='2012-31-03'

--11. Найти максимальную стоимость товара (отпускная цена ListPrice) из тех, которые были произведены, начиная с марта 2011 года. 
SELECT max(p.ListPrice) AS [max price] FROM [Production].[Product] AS p WHERE p.SellStartDate>='2011-01-03'

--12. Вывести название и цвет продукта, отсортированные по названию продукта по возрастанию. 
SELECT p.Name, p.Color FROM [Production].[Product] AS p ORDER BY p.Name ASc

--13. Вывести названия продукта, цвет и отпускную цену для таких товаров, у которых цвет определен 
-- и цена отлична от нуля, и отсортировать полученный список по возрастанию цвета товара и убыванию отпускной цены. 
SELECT p.Name, p.Color, p.ListPrice FROM [Production].[Product] AS p 
WHERE p.Color is NOT null AND p.ListPrice!=0 ORDER BY p.Color, p.ListPrice desc

-- 14. Получить название продукта и разницу между отпускной стандартной ценой продукта и 
-- стандартной ценой продукта для тех товаров, у которых эти показатели не равны нулю. 
SELECT p.Name, p.ListPrice-p.StandardCost FROM [Production].[Product] AS p WHERE p.ListPrice!=0 AND p.StandardCost!=0

--15. Найти название самого дорогого товара, исходя из предположения, что нет двух товаров с одинаковой ценой. 
SELECT top 1 with ties p.Name, p.ListPrice FROM [Production].[Product] AS p ORDER BY p.ListPrice desc

--16. Найти список товаров, произведенных в 2011 году. 
SELECT p.Name FROM [Production].[Product] AS p WHERE datepart(YEAR,p.SellStartDate)=2011