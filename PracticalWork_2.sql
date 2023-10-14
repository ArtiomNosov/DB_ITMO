-- ѕрактическа€ работа 2
/*÷ель работы: »зучение выражени€ GROUP BY Ц группировка данных*/

SELECT [Name], [ListPrice], [Color] FROM [Production].[Product]
WHERE [Color] IS NOT NULL;

/*
јгрегирующие функции:
SUM ( [ ALL | DISTINCT ] expressiON ) Ц 
сумма значений в столбце;
MAX( [ ALL | DISTINCT ] expressiON ) Ц 
максимальное значение в столбце;
MIN ( [ ALL | DISTINCT ] expressiON ) Ц 
минимальное значение в столбце;
AVG ( [ ALL | DISTINCT ] expressiON ) Ц 
среднее значение в столбце;
COUNT ( { [ [ ALL | DISTINCT ] expressiON ] | * } ) Ц 
количество строк в столбце, с учетом NULL значений.
*/

/*„исло уникальных цветов:*/
SELECT COUNT(DISTINCT [Color]) 
FROM [Production].[Product]
WHERE [Color] IS NOT NULL;