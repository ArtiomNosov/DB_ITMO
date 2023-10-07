-- ������������ ������ 1
/*���� ������: �������� �������� ���������� ���������� 
SELECT, ��������� WHERE � ORDER BY.*/
--������� ��������� ���������� SELECT

/*���������� ���������� ���� ������ ��������� 
(������, ��� ������� ���� �� ��������������):*/
SELECT 'Mom washed the frame';

/*������ ���������� ������ �������
(������� ����� ������� �� ������):*/
SELECT 'Mom washed the frame' AS ������_�����;

/*���������� ������ ��� ��������� ������ ��������� ���������������:*/
SELECT 'Mom washed the frame' AS [1. ������ �����];

/*������ ������� ����� ����������� �� �������:*/
SELECT *
FROM [Production].[Product];

/*� ����� � �� ��������� [] ������:*/
SELECT *
FROM Production.Product;

/*��������� ������ ������ �������: */
SELECT [Name]
FROM [Production].[Product];

/*��� ���� ������� ��������� �������:*/
SELECT p.[Name]
FROM [Production].[Product] AS p;

/*������� � ����� ���������:*/
SELECT [ProductID], [Name]
FROM [Production].[Product];

/*����������� �������: */
SELECT [ProductID], [Name], [ListPrice]-[StandardCost] AS [discount size]
FROM [Production].[Product];

/*����������� �������� 3 ������� � ������� ���� � ����� 4 �������: */
SELECT [ProductID], [Name], 'empty column', GETDATE()
FROM [Production].[Product];

/*ALL ���� ��� ������, 
���������� ��������� ������������ �� ���������*/
SELECT ALL [Size]
FROM [Production].[Product];

/*��������� ������ ��� ���������� (DISTINCT):*/
SELECT DISTINCT [Size]
FROM [Production].[Product];

/*������ ��� ������������ � ������� ���� �������� 
[Color] � [Size] ��� ����������:*/
SELECT DISTINCT [Color], [Size]
FROM [Production].[Product];

--��������� ORDER BY


/*������������� ����� 
(DESC �� ��������, ASC �� �����������):*/
SELECT [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;
/*���������� ORDER BY ������ �������� ����������� ������ �������*/

/*������������ �� ���������� ��������, � ��������� ����������� ��� ������� �������:*/
SELECT [FirstName], [MiddleName], [LastName]
FROM [Person].[Person]
ORDER BY [FirstName] ASC, [MiddleName] DESC, [LastName] ASC;

/*������������ �� ������� � ������, 
� ������ ������� �� ������� �������:*/
SELECT [Name], [StandardCost] - [ListPrice]
FROM [Production].[Product]
ORDER BY 2;

/*����� �������� ������������� ������� 
��� ��������� ��������� ��������������:*/
SELECT BusINessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY DATEPART(year, HireDate);

/*TOP ������������ ���������� �����*/
SELECT TOP 3 [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

/*WITH TIES ��������� �������� ��� ������, 
�������������� �� ��������� �����:*/
SELECT TOP 3 WITH TIES [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;
/*�������� ������������� � SELECT � ORDER BY*/

/*����� ���� ����� �� ��������������� ������:*/
SELECT TOP 3 PERCENT [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;
/*����� ������� 503, 3% �� ��� 15.12, ��������� ����� 16*/

/*������������� ���������� INTO ��������� ������� ����� ������� 
� ��������� � ��� ��������� �������:*/
SELECT TOP 3 PERCENT [Name], [ListPrice] INTO Tmp
FROM [Production].[Product]
ORDER BY [ListPrice] DESC;

--��������� WHERE


/*������� ������ ������������� ����������� WHERE:*/
SELECT [Name], [ListPrice]
FROM [Production].[Product]
WHERE [ListPrice]=3578.27;

/*����������� ��� ���� ��������:*/
SELECT [Name], [ListPrice]
FROM [Production].[Product]
WHERE [ListPrice]=3578.27 AND [Size]=62;

/*����� �������� ���������� ������� ������:*/
SELECT [Name] FROM [Production].[Product]
WHERE
([ListPrice]>20 AND [Color]='Red')
OR
([ListPrice]>25 AND [Color]='Black');

/*���� ������� ����� � ��������� �� 20 �� 40, 
������� ������� ���������:*/
SELECT [Name] FROM [Production].[Product]
WHERE [ListPrice]>=20 AND [ListPrice]<=40;

/*The same with BETWEEN:*/
SELECT [Name] FROM [Production].[Product]
WHERE [ListPrice] BETWEEN 20 AND 40;

/*IN ���������� �������������� �������� ������ � �������� � ������*/
SELECT [Name] FROM [Production].[Product]
WHERE [Color] IN ('Red','Black','Silver');

/*��� ��������, ������������ �� ����� �D� (LIKE):*/
SELECT [Name] FROM [Production].[Product]
WHERE [Name] LIKE 'D%';
/*
� ��������� �������� ����������� ��������� �������:
% � ����� ������������������;
_ - ����� ������;
[] � ������, ��������� � �������, ����� ����������� �������, 
��� �������� (����� �����) ��������;
[^] � �������� ��������� ������, �� ��������� � ������� �������, 
����� ����������� �������, ��� �������� (����� �����) ��������.
����������� ������������� ESCAPE �������������������:
WHERE ������ LIKE �%[a-f][^xyz]_30!%%� ESCAPE �!�
*/

/*��������� �������� �� NULL ������ � ������� IS!*/
SELECT [Name] FROM [Production].[Product]
WHERE [Color] IS NULL;

/*�����, ��� ���� ��������*/
SELECT [Name] FROM [Production].[Product]
WHERE [Size] IS NOT NULL;
