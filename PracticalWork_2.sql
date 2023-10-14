-- ������������ ������ 2
/*���� ������: �������� ��������� GROUP BY � ����������� ������*/

SELECT [Name], [ListPrice], [Color] FROM [Production].[Product]
WHERE [Color] IS NOT NULL;

/*
������������ �������:
SUM ( [ ALL | DISTINCT ] expressiON ) � 
����� �������� � �������;
MAX( [ ALL | DISTINCT ] expressiON ) � 
������������ �������� � �������;
MIN ( [ ALL | DISTINCT ] expressiON ) � 
����������� �������� � �������;
AVG ( [ ALL | DISTINCT ] expressiON ) � 
������� �������� � �������;
COUNT ( { [ [ ALL | DISTINCT ] expressiON ] | * } ) � 
���������� ����� � �������, � ������ NULL ��������.
*/

/*����� ���������� ������:*/
SELECT COUNT(DISTINCT [Color]) 
FROM [Production].[Product]
WHERE [Color] IS NOT NULL;