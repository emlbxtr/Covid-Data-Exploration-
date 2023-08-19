SELECT JobTitle,AVG(Salary)
FROM EmployeeDemographic
JOIN EmployeeSalary 
on EmployeeDemographic.EmloyeeID = EmployeeSalary.EmployeeID
Group by JobTitle 
Having AVG(Salary)>40000
Order by AVG(Salary)



SELECT *
FROM EmployeeDemographic
INNER JOIN EmployeeSalary 
ON EmployeeDemographic.EmloyeeID = EmployeeSalary. EmployeeID
INSERT INTO EmployeeDemographic VALUES 

(1001,'NULL','Austen','Female',29)
UPDATE EmployeeDemographic
SET FirstName = 'Jain' 
WHERE Lastname = 'Austen'

DELETE FROM EmployeeDemographic 
WHERE EmloyeeID = 1001


SELECT FirstName + ' ' + Lastname AS FullName
FROM [EmployeeDemographic]

SELECT DEMO.EmloyeeID, Sal.Salary
FROM [EmployeeDemographic] AS Demo 
JOIN [EmployeeSalary] AS Sal
ON Demo.EmloyeeID = Sal.EmployeeID


SELECT FirstName,LastName,Gender,Salary 
, Count (Gender) Over (PARTITION BY GENDER) AS TotalGender 
FROM EmployeeDemographic Dem 
Join EmployeeSalary Sel
ON Dem.EmloyeeID = Sel.EmployeeID



SELECT FirstName,LastName,Gender,Salary, Count (Gender)
FROM EmployeeDemographic Dem 
Join EmployeeSalary Sel
ON Dem.EmloyeeID = Sel.EmployeeID
GROUP BY FirstName,LastName,Gender,Salary 

WITH CTE_Employee as
(SELECT FirstName,LastName,Gender,Salary 
, Count (Gender) Over (PARTITION BY GENDER) AS TotalGender 
, AVG(Salary) Over (PARTITION BY GENDER) AS AvarageSalary
FROM EmployeeDemographic emp
Join EmployeeSalary Sal
ON emp.EmloyeeID = Sal.EmployeeID
WHERE Salary >'4500' 
)

Select* 
FROM CTE_Employee





CREATE TABLE #temp_Employee(
EmployeeID int,
JobTitle varchar (100),
Salary int)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES 
(1001,'HR',45000)

INSERT INTO #temp_Employee 
SELECT *
FROM EmployeeSalary

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2
(JobTitle varchar (50),
EmployeesPerJob int,
Avgage int,
Avgsalary int)

INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT ( JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographic emp
Join EmployeeSalary Sal
ON emp.EmloyeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT * 
FROM #temp_Employee



CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

SELECT EmployeeID , TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors


SELECT EmployeeID , LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors


SELECT EmployeeID , RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT LastName , REPLACE(LastName,'- Fired','') as LastNameFixed
FROM EmployeeErrors

SELECT SUBSTRING(FirstName,1,3)
FROM EmployeeErrors

SELECT SUBSTRING(err.FirstName,1,3), SUBSTRING(demo.FirstName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographic demo
ON SUBSTRING(err.FirstName,1,3)= SUBSTRING(demo.FirstName,1,3)


SELECT LOWER(FirstName)
FROM EmployeeErrors

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographic


EXEC TEST


CREATE PROCEDURE Temp_Employee3
AS 
CREATE table #temp_employee (
JobTitle varchar (100),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_Employee
SELECT JobTitle, COUNT ( JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographic emp
Join EmployeeSalary Sal
ON emp.EmloyeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT * 
FROM #temp_Employee

EXEC Temp_Employee 





SELECT EmployeeID, Salary, ( SELECT AVG(SALARY) FROM EmployeeSalary)
FROM EmployeeSalary


Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographic
	where Age > 30)