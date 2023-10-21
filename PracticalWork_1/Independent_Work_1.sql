--1. ����� � ������� �� ����� �������� ���������, �� ���� � ������.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p;

--2. ����� � ������� �� ����� ��������, ���� � ������ ����� ���������, 
--� ������� ���� ����� 100.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p WHERE p.ListPrice > 100;

--3. ����� � ������� �� ����� ��������, ���� � ������ ����� ���������, 
--� ������� ���� ����� 100 � ���� Black.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p WHERE p.ListPrice < 100 AND p.Color = 'Black';

--4. ����� � ������� �� ����� ��������, ���� � ������ ����� ���������, 
--� ������� ���� ����� 100 � ���� Black, ���������� ����� �� ����������� ��������� ���������.
SELECT p.Name, p.Color, p.Size FROM Production.Product AS p WHERE p.ListPrice < 100 AND p.Color = 'Black' ORDER BY p.ListPrice;

--5. ����� � ������� �� ����� �������� � ������ ������ ���� ����� ������� ������� � ������ Black.
SELECT TOP 3 WITH TIES p.Name, p.Size FROM Production.Product AS p WHERE p.Color = 'Black' ORDER BY p.ListPrice;

--6. ����� � ������� �� ����� �������� � ���� ����� ���������, ��� ������� ��������� � ����, � ������.
SELECT p.Name, p.Color FROM Production.Product AS p WHERE p.Color IS NOT NULL AND p.Size IS NOT NULL;

--7. ����� � ������� �� ����� �� ������������� ����� ���������, 
--� ������� ���� ��������� � ��������� �� 10 �� 50 ������������.
SELECT DISTINCT p.Color FROM Production.Product AS p WHERE p.ListPrice >= 10 AND p.ListPrice <=50;

--8. ����� � ������� �� ����� ��� ����� ����� ���������, 
--� ������� � ����� ������ ����� �L� � ������ �N�.
SELECT p.Color FROM Production.Product AS p WHERE p.Name like 'L_N%'

--9. ����� � ������� �� ����� �������� ����� ���������, 
--������� ���������� ���� �� ����� �D�, ���� �� ����� �M�, � ��� ���� ����� ����� � ����� ���� ��������.
SELECT p.Name FROM Production.Product AS p WHERE p.Name like '[DM]__%' 

--10. ������� �� ����� �������� ���������, 
--� ������� ���� ������ ������ � �� ������� 2012 ����.
SELECT p.Name FROM Production.Product AS p WHERE datepart(YEAR,p.SellStartDate) <= 2012;

--11. ����� � ������� �� ����� �������� ���� ������������ �������.
SELECT PSC.Name FROM Production.ProductSubcategory AS PSC;

--12. ����� � ������� �� ����� �������� ���� ��������� �������.
SELECT PC.Name FROM Production.ProductCategory AS PC;

--13. ����� � ������� �� ����� ����� ���� �������� �� ������� Person, 
--� ������� ��������� (Title) ������� ��� �Mr.�.
SELECT P.FirstName FROM Person.Person AS P WHERE P.Title like 'Mr.%';

--14. ����� � ������� �� ����� ����� ���� �������� �� ������� Person, 
--��� ������� �� ���������� ��������� (Title).
SELECT P.FirstName FROM Person.Person AS P WHERE P.Title IS NULL;