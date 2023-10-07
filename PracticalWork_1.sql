-- Практическая работа 1
/*Цель работы: Изучение базового синтаксиса инструкции 
SELECT, выражения WHERE и ORDER BY.*/
--Базовый синтаксис инструкции SELECT

/*Инструкция следующего вида вполне допустима 
(отмечу, что русский язык не поддерживается):*/
SELECT 'Mom washed the frame';

/*Теперь проименуем данный столбец
(столбец сожно назвать по русски):*/
SELECT 'Mom washed the frame' AS Просто_текст;

/*Квадратные скобки для нарушения правил написания идентификаторов:*/
SELECT 'Mom washed the frame' AS [1. просто текст];

/*Пример выборки всего содержимого из таблицы:*/
SELECT *
FROM [Production].[Product];

/*А можно и не указывать [] скобки:*/
SELECT *
FROM Production.Product;

/*Получение данных одного столбца: */
SELECT [Name]
FROM [Production].[Product];

/*Еще один вариант написания запроса:*/
SELECT p.[Name]
FROM [Production].[Product] AS p;

/*Таблица с двумя столбцами:*/
SELECT [ProductID], [Name]
FROM [Production].[Product];

/*Вычисляемый столбец: */
SELECT [ProductID], [Name], [ListPrice]-[StandardCost] AS [discount size]
FROM [Production].[Product];

/*Константное значение 3 столбец и текущая дата и время 4 столбец: */
SELECT [ProductID], [Name], 'empty column', GETDATE()
FROM [Production].[Product];

/*ALL берёт все записи, 
опускается поскольку используется по умолчанию*/
SELECT ALL [Size]
FROM [Production].[Product];

/*Получение данных без повторений (DISTINCT):*/
SELECT DISTINCT [Size]
FROM [Production].[Product];

/*Вернет все существующие в таблице пары значений 
[Color] и [Size] без повторений:*/
SELECT DISTINCT [Color], [Size]
FROM [Production].[Product];

--Выражение ORDER BY


/*Упорядоченный вывод 
(DESC по убыванию, ASC по возрастанию):*/
SELECT [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;
/*Инструкция ORDER BY всегда является завершающей частью запроса*/

/*Упорядочение по нескольким столбцам, с указанием направления для каждого столбца:*/
SELECT [FirstName], [MiddleName], [LastName]
FROM [Person].[Person]
ORDER BY [FirstName] ASC, [MiddleName] DESC, [LastName] ASC;

/*Упорядочение по позиции в выводе, 
в данном примере по второму столбцу:*/
SELECT [Name], [StandardCost] - [ListPrice]
FROM [Production].[Product]
ORDER BY 2;

/*Также возможно использование функции 
для получения параметра упорядочивания:*/
SELECT BusINessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY DATEPART(year, HireDate);

/*TOP ограничивает количество строк*/
SELECT TOP 3 [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

/*WITH TIES позволяет выводить все строки, 
«соперничающие за последнее место»:*/
SELECT TOP 3 WITH TIES [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;
/*работает исключительно с SELECT и ORDER BY*/

/*Вывод доли строк из результирующего набора:*/
SELECT TOP 3 PERCENT [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;
/*всего записей 503, 3% от них 15.12, следующее целое 16*/

/*Использование инструкции INTO позволяет создать новую таблицу 
и поместить в нее результат выборки:*/
SELECT TOP 3 PERCENT [Name], [ListPrice] INTO Tmp
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

--Выражение WHERE


/*Простой пример использования предложения WHERE:*/
SELECT [Name], [ListPrice]
FROM [Production].[Product]
WHERE [ListPrice]=3578.27;

/*Ограничения для двух столбцов:*/
SELECT [Name], [ListPrice]
FROM [Production].[Product]
WHERE [ListPrice]=3578.27 AND [Size]=62;

/*Можно написать достаточно сложный запрос:*/
SELECT [Name] FROM [Production].[Product]
WHERE
([ListPrice]>20 AND [Color]='Red')
OR
([ListPrice]>25 AND [Color]='Black');

/*цена которых лежит в диапазоне от 20 до 40, 
включая границы диапазона:*/
SELECT [Name] FROM [Production].[Product]
WHERE [ListPrice]>=20 AND [ListPrice]<=40;

/*The same with BETWEEN:*/
SELECT [Name] FROM [Production].[Product]
WHERE [ListPrice] BETWEEN 20 AND 40;

/*IN определяет принадлежность значения одному и значений в списке*/
SELECT [Name] FROM [Production].[Product]
WHERE [Color] IN ('Red','Black','Silver');

/*все продукты, начинающиеся на букву ‘D’ (LIKE):*/
SELECT [Name] FROM [Production].[Product]
WHERE [Name] LIKE 'D%';
/*
В строковых шаблонах допускаются следующие символы:
% – любая последовательность;
_ - любой символ;
[] – символ, указанный в скобках, можно перечислить символы, 
или диапазон (через дефис) символов;
[^] – заменяет одиночный символ, не указанный в угловых скобках, 
можно перечислить символы, или диапазон (через дефис) символов.
Допускается использование ESCAPE последовательностей:
WHERE СТРОКА LIKE ‘%[a-f][^xyz]_30!%%’ ESCAPE ‘!’
*/

/*Проверять является ли NULL только с помощью IS!*/
SELECT [Name] FROM [Production].[Product]
WHERE [Color] IS NULL;

/*Имена, где цвет определён*/
SELECT [Name] FROM [Production].[Product]
WHERE [Size] IS NOT NULL;
