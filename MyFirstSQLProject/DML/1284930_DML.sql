/*

         SQL Project Name : Collage Management System
            Trainee Name : Sifat Sultana  
            Trainee ID : 1284930      
            Batch ID : CS/scsl-M/61/01

     --------------------------------------------------------------------------------------------------
Table of Contents: DML

‣SECTION   01  : INSERT DATA USING INSERT INTO KEYWORD
‣SECTION   02  : SELECT FROM TABLE
‣SECTION 03 : SELECT FROM VIEW
‣SECTION 04 : SELECT INTO
‣SECTION 05 : IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE
‣SECTION 06 : INNER JOIN WITH GROUP BY CLAUSE
‣SECTION 07 : OUTER JOIN
‣SECTION 08 : CROSS JOIN
‣SECTION 09 : TOP DISTINCT CLAUSE WITH TIES
‣SECTION 10 : COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR
‣SECTION 11 : BETWEEN, LIKE, IN, NOT IN, IS NULL, NOT NULL OPERATOR
‣SECTION 12 : OFFSET FETCH
‣SECTION 13 : AGGREGATE FUNCTIONS
‣SECTION 14 : ROLLUP & CUBE OPERATOR
‣SECTION 15 : GROUPING SETS
‣SECTION 16 : SUB-QUERIES (INNER, CORRELATED)
‣SECTION 17 : EXISTS
‣SECTION 18 : CTE
‣SECTION 19 : MERGE
‣SECTION 20 : IIF,CASE,CHOOSE
‣SECTION 21 : COALESCE & ISNULL
‣SECTION 22 : GROPING FUNCTION
‣SECTION 23 : RANKING FUNCTION
‣SECTION 24 : IF ELSE & PRINT
‣SECTION 25 : GOTO
‣SECTION 26 : WAITFOR
‣SECTION 27 : sp_helptext
‣SECTION 28 : Error Handling With TRY & CATCH BLOCK
‣SECTION 29 : ALL ANY SOME
‣SECTION 30 : RANK & DENSERANK
‣SECTION 31 : NTILE FUNCTION
‣SECTION 32 : PERCENTILE RANK
‣SECTION 33 : LAG/LEAD
             ‣SECTION 34 : DATE FUNCTION


 

*/


USE CollegeDB
GO

--insert values in Table 1 Teacher

GO
INSERT INTO Teacher(TeacherId,TeacherName)
VALUES
(101,'A'),
(102,'B'),
(103,'C')

--insert values in Table 2 Student

GO
INSERT INTO Student(StudentId,StudentName)
VALUES
(201,'AA'),
(202,'BB'),
(203,'CC'),
(204,'DD'),
(205,'EE'),
(206,'FF'),
(207,'GG'),
(208,'HH'),
(209,'II')

---insert values in Table 3 Semester

GO
INSERT INTO Semester(SemesterId,SemesterName)
VALUES
(301,'Spring'),
(302,'Summer'),
(303,'Fall'),
(304,'Winter')


---insert values in Table 4 Subjects

GO
INSERT INTO Subjects(SubjectsId,SubjectsName)
VALUES
(1,'C#'),
(2,'Data Base'),
(3,'Web Design'),
(4,'Data Mining'),
(5,'MIS'),
(6,'PHP'),
(7,'Project Management'),
(8,'PCL'),
(9,'Software Engineering')

--insert values in Table 4 DataRelation

GO
INSERT INTO DataRelation(TeacherId,StudentId,SemesterId,SubjectsId)
VALUES
(101,201,301,1),
(101,202,301,1),
(101,204,301,1),

(102,201,301,2),
(102,203,301,2),
(102,209,301,2),

(103,205,301,3),
(103,208,301,3),
(103,202,301,3),
(103,207,301,3),

(101,205,302,1),
(101,207,302,1),

(102,202,302,4),
(102,206,302,4),
(102,208,302,4),

(103,201,302,5),
(103,202,302,5),
(103,203,302,5),


(101,208,303,6),
(101,209,303,6),

(102,205,303,2),
(102,207,303,2),
(102,204,303,2),

(103,209,303,7),
(103,204,303,7),
(103,206,303,7),


(101,203,304,8),
(101,206,304,8),

(102,201,304,9),
(102,202,304,9),
(102,207,304,9),

(103,201,304,3),
(103,203,304,3),
(103,204,304,3)

USE CollegeDB
GO
------------------------------------INSERT INTO A ROW -----------------------------------------

INSERT INTO Student(StudentId,StudentName)
VALUES(211,'LL')

------------------------------------DELETE INTO A ROW -----------------------------------------

DELETE FROM Student WHERE StudentId=211


USE CollegeDB
GO


--** SECTION   02  : SELECT FROM TABLE**


SELECT * FROM Teacher
GO


----** SECTION   03 : SELECT FROM View **

GO
SELECT * FROM vu_StudentInfoWithEncryptionSchemabinding



--** ‣SECTION 04 : SELECT INTO**


SELECT * INTO TeacherCopy FROM Teacher
GO




--** SECTION 05 : IMPLICIT JOIN WITH ORDER BY CLAUSE & WHERE BY CLAUSE**

GO
SELECT DR.SubjectsId ,DR.StudentId FROM DataRelation DR
JOIN Student  P ON DR.StudentId=S.StudentId
ORDER BY Semester
GO
SELECT * FROM DataRelation
WHERE DataRelationID = 301


                          --- ** SECTION 06 : INNER JOIN ***

SELECT StudentName,SubjectsId FROM DataRelation
JOIN Student ON DataRelation.StudentId=Student.StudentId


                          --- ** SECTION 07 : Outer Join**  

SELECT StudentName,SubjectsId,SemesterId FROM DataRelation
LEFT JOIN Student ON DataRelation.StudentId=Student.StudentId

---------------------------------Inner & Outer JOIN------------------------------

SELECT StudentName,SubjectsId,Semester.SemesterName FROM DataRelation
JOIN Student ON DataRelation.StudentId=Student.StudentId
LEFT JOIN Semester ON DataRelation.SemesterId=Semester.SemesterId

     ---*** SECTION 08 Cross join ***


SELECT StudentId,SubjectsName FROM DataRelation
CROSS JOIN Subjects

                                      --** Union **

SELECT SemesterId,SubjectsId FROM DataRelation
WHERE StudentId=203
UNION
SELECT SemesterId,SubjectsId FROM DataRelation
WHERE StudentId=206


  ---*** SECTION 09 TOP DISTINCT CLAUSE ***

GO
SELECT DISTINCT TOP 5   DataRelationID FROM DataRelation


   ---===== ‣SECTION 10 Comparison Operator (AND,OR,NOT)


--AND
GO
SELECT * FROM DataRelation_T
WHERE DataRelationID = 303 AND DataRelationID < 302


--OR
GO
SELECT * FROM DataRelation_T
WHERE DataRelationID < 301 OR DataRelationID < 304


--NOT
GO
SELECT * FROM DataRelation_T
WHERE NOT DataRelationID > 301

 ---*** SECTION 11  BETWEEN, LIKE, IN, NOT IN Operator ***


GO
SELECT * FROM Student
WHERE StudentId BETWEEN 203 AND 204                                              

GO
SELECT * FROM Student
WHERE StudentName LIKE '%m'                                        

GO
SELECT * FROM Student
WHERE StudentName IN ('Sony')

GO
SELECT * FROM Student
WHERE StudentName NOT IN ('B[^P-Z]')


---*** SECTION 12 Fetch and Offset ***

GO
SELECT *
FROM Student
ORDER BY StudentName
OFFSET 0 ROWS
FETCH NEXT 2 ROWS ONLY;


    ---*** SECTION 13 AGGREGATE FUNCTIONS ***


SELECT COUNT(StudentId) AS 'Number of studebt',
MAX(SubjectsId) AS 'Maximum number of subject'
FROM DataRelation

------------------------------------Aggregate function with condition--------------------------------------

SELECT S.StudentName,COUNT(SubjectsId) AS 'Number OF subject'
FROM DataRelation D
JOIN Student S ON D.StudentId=S.StudentId
GROUP BY S.StudentName
HAVING COUNT(*) >= 4

------------------------------Aggregate function to see number of subject per semester ----------------------------------

SELECT SE.SemesterName,
COUNT(SU.SubjectsId) AS 'Number of subject per semester'
FROM DataRelation D
JOIN Subjects SU ON D.SubjectsId=SU.SubjectsId
JOIN Semester SE ON D.SemesterId=SE.SemesterId
GROUP BY SE.SemesterName

                           ---*** SECTION 14 ROLLUP & CUBE ***

--ROLLUP

SELECT StudentName,COUNT(SubjectsId) AS Subjects FROM DataRelation
JOIN Student ON DataRelation.StudentId=Student.StudentId
GROUP BY ROLLUP (StudentName)

--CUBE

SELECT StudentName,COUNT(DataRelation.SemesterId) AS Subjects FROM DataRelation
JOIN Student ON DataRelation.StudentId=Student.StudentId
GROUP BY CUBE (StudentName)

                       ---*** SECTION 15 GROUPING SETS ***

SELECT StudentName,SUM(DataRelation.SemesterId) AS Subjects FROM DataRelation
JOIN Student ON DataRelation.StudentId=Student.StudentId
GROUP BY GROUPING SETS (StudentName)

                         ---*** SECTION : 16 SubQuerie ***

SELECT * FROM Student
WHERE StudentName IN ('DD')
(SELECT  SubjectsName  FROM Subjects)

SELECT StudentId,SubjectsId FROM DataRelation
WHERE SubjectsId IN
(SELECT SubjectsId FROM Subjects
WHERE SubjectsId = 4)

SELECT StudentId,SubjectsId,SemesterId FROM DataRelation
WHERE SubjectsId NOT IN
(SELECT SubjectsId FROM Subjects
WHERE SubjectsId = 4)


      - ---*** SECTION : 17 EXISTS CLAUSE ***

GO
SELECT StudentId, StudentName
FROM Supplier
WHERE EXISTS (
SELECT 1
FROM DataRelation
WHERE DataRelation.StudentId=Supplier.StudentId
 
 
                           ---** SECTION : 18 CTE ***
WITH T1 AS
(
SELECT StudentId,SemesterId,COUNT(SubjectsId) AS Subjects FROM DataRelation D
GROUP BY StudentId,SemesterId
),
T2 AS
(
SELECT SemesterId,MAX(SemesterId) AS MaxSemester FROM T1
GROUP BY SemesterId
)
SELECT * FROM T1
JOIN T2 ON T1.SemesterId=T2.SemesterId


                       ---*** SECTION 20 CAST,IFF,COALCASE,CHOOSE ***

--CAST function

SELECT StudentId,SemesterId,
CASE SemesterId
WHEN 301 THEN 'Start'
WHEN 302 THEN 'Quater'
WHEN 303 THEN 'Midel'
WHEN 304 THEN 'End'
END AS Type
FROM DataRelation

--IIF

SELECT StudentId,SUM(SubjectsId) AS 'Point' ,
IIF(SUM(SubjectsId) < 6 ,'BAD','GOOD') AS 'Range'
FROM DataRelation
GROUP BY StudentId,SubjectsId


--CHOOSE

SELECT SemesterId ,
CHOOSE (SemesterId ,'301','302','303' )
FROM Semester
GO

                    ---*** SECTION 21 COALESCE, ISNULL & IS NOT NULL ***


--COALCACE

SELECT Student.StudentId,StudentName,SemesterId,
COALESCE(CAST(GETDATE() AS VARCHAR),'Paid') AS PaymentDate
FROM DataRelation
JOIN Student ON DataRelation.StudentId=Student.StudentId

--ISNULL

GO
SELECT * FROM Student
WHERE StudentName IS NULL
 
 --IS NOT NULL

GO
SELECT * FROM Student
WHERE StudentName IS NOT NULL

  ---*** SECTION 22 ANY ,SOME ,ALL ***


--ANY
IF 1>ANY (SELECT StudentId FROM Student)
PRINT 'Yes'
ELSE
PRINT 'NO'
GO


--SOME
IF 1>SOME(SELECT StudentId FROM Student)
PRINT 'Yes'
ELSE
PRINT 'NO'
GO


--ALL
IF 1 > ALL ( SELECT StudentId FROM Student )
PRINT 'Yes'
ELSE
PRINT 'NO'
GO


---*** SECTION 22 Wait for clause ***


PRINT 'HELLO'
WAITFOR DELAY '00:00:04'
PRINT 'GOOD DAY'
GO

                         ---*** SECTION 23 RANK FUNCTION ***

SELECT ROW_NUMBER() OVER(ORDER BY StudentId) AS RowNumber,*
FROM DataRelation

SELECT RANK() OVER(ORDER BY SubjectsId) AS RowNumber,*
FROM DataRelation

SELECT DENSE_RANK() OVER(ORDER BY SemesterId) AS RowNumber,*
FROM DataRelation

---*** SECTION 24 IF ELSE & PRINT ***

DECLARE @x INT = 10;
IF @x > 4
    PRINT 'x is greater than 4'


          ---*** SECTION 25 GOTO ***

DECLARE @Counter INT = 0;

PRINT 'Starting loop';

WHILE @Counter < 10
BEGIN
    SET @Counter = @Counter + 1;
    IF @Counter = 4
        GOTO Label1;
    PRINT @Counter;
END

Label1:
PRINT 'Jumped to Label1'



    --** SECTION 26 WAITFOR ***


-- Initial run
SELECT GETDATE() AS 'Run Time', COUNT(*) AS 'Number Of System Processes' FROM DataRelation
GO

-- Wait 1 hour
WAITFOR DELAY '01:00:00'

-- Second run
SELECT GETDATE() AS 'Run Time', COUNT(*) AS 'Number Of System Processes' FROM DataRelation
GO

-- Wait 1 hour
WAITFOR DELAY '01:00:00';

-- Third run
SELECT GETDATE() AS 'Run Time', COUNT(*) AS 'Number Of System Processes' FROM DataRelation
GO


---===== ‣SECTION 27 sp_helptext


--Select statement for view
SELECT * FROM vu_StudentInfoWithEncryptionSchemabinding

--Query to get top patien-----------------------------
SELECT TOP 5 * FROM vu_StudentInfoWithEncryptionSchemabinding


----Select Statement for Procedure
EXEC spInputOutputReturnType 'Select','','',''
EXEC spInputOutputReturnType 'Insert','210','JJ',''
EXEC spInputOutputReturnType 'Update','210','KK',''
EXEC spInputOutputReturnType 'Delete','210','',''


DECLARE @Name varchar(2)
EXEC spInputOutputReturnType 'Output','210','',@Name OUTPUT
PRINT @Name

DECLARE @StudentCount int
EXEC @StudentCount=spInputOutputReturnType 'Return','','',''
PRINT @StudentCount

--Select statement for function
PRINT 'Student Name: ' +dbo.fn_GetStudentName(205)

--Select statement for functionTable
SELECT * FROM fn_TableValuedFunction(209)

--Select statement for functionTable
SELECT * FROM fn_MultiTableValuedFunction(300)

  ---===== ‣SECTION 28   Error Handling With TRY & CATCH BLOCK


BEGIN TRY

DECLARE @a int ,@b int, @c int
set @a = 50
set @b = 0
set @c = @a/@b

PRINT @c
END TRY
BEGIN CATCH
PRINT 'you can not divide any number by zero '
PRINT ERROR_MESSAGE()
PRINT ERROR_SEVERITY()
PRINT ERROR_STATE()
PRINT ERROR_LINE()
RAISERROR(15,5,1)
END CATCH
GO

                           ---*** SECTION 30 NTILE FUNCTION ***

SELECT SemesterId,
NTILE(2) OVER(ORDER BY SemesterId) AS RowNumber2,
NTILE(5) OVER(ORDER BY SemesterId) AS RowNumber5,
NTILE(7) OVER(ORDER BY SemesterId) AS RowNumber8
FROM DataRelation

                         

-- Creating a table for student Archive
CREATE TABLE StudentArchive(
StudentId int not null,
StudentName varchar(2) not null
)


CREATE TABLE Logs(
ActivityId int IDENTITY primary key not null,
Activity varchar(20) not null,
ActivityDate datetime
)
