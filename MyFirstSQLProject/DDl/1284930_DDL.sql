/*
       SQL Project Name : Collage Management System
          Trainee Name : Sifat Sultana
          Trainee ID : 1284930      
          Batch ID : CS/scsl-M/61/01

 ---------------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------------

Table of Contents: DDL
‣ SECTION 01: Created a Database LMS
‣ SECTION 02: Created Appropriate Tables with column definition related to the project
‣ SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
‣ SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
‣ SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
‣ SECTION 06: CREATE A VIEW & ALTER VIEW
‣ SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
‣ SECTION 08: CREATE FUNCTION(SCALER VALUED FUNCTION & TABLE VALUED FUNCTION)
‣ SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER)
‣ SECTION 10: CREATE TRIGGER (INSTEAD OF TRIGGER)
*/


                        --====== ‣ SECTION 01: Created a Database CollageDB ----






--USE master
--GO
--IF DB_ID('CollegeDB') IS NOT NULL
--DROP DATABASE CollegeDB

--GO

--CREATE DATABASE CollegeDB

--ON(
--name=CollegeDB_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CollegeDB_Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)

--LOG ON(
--name=CollegeDB_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CollegeDB_Log_1.ldf',
--size=2mb,
--maxsize=50mb,
--filegrowth=1mb
--)
--GO
 
-- ‣** SECTION 02: Created Appropriate Tables with column definition related to the project ***

--USE CollegeDB
--GO
       
----Table 1

--CREATE TABLE Teacher(
--TeacherId int primary key not null,
--TeacherName varchar(2) not null
--)

----Table 2

--CREATE TABLE Student(
--StudentId int primary key not null,
--StudentName varchar(2) not null
--)

----Table 3

--CREATE TABLE Semester(
--SemesterId int primary key not null,
--SemesterName varchar(10) not null
--)


----Table 4

--CREATE TABLE Subjects(
--SubjectsId int primary key not null,
--SubjectsName varchar(25) not null
--)


----Table 5

--CREATE TABLE DataRelation(
--TeacherId int REFERENCES Teacher(TeacherId) not null,
--StudentId int REFERENCES Student(StudentId) not null,
--SemesterId int REFERENCES Semester(SemesterId) not null,
--SubjectsId int REFERENCES Subjects(SubjectsId) not null,

--PRIMARY KEY(TeacherId,StudentId,SemesterId,SubjectsId)
--)

                  -- ‣*** SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS ***

CREATE TABLE Parents
(
  ParentsID INT ,
  ParentsName VARCHAR (50)
)
GO
SELECT * FROM Parents

-----Alter Example

GO
ALTER TABLE Parents
ADD ParentZipCode INT not null

----MODIFY Example

GO
ALTER TABLE Parents
ADD DateOfAdmit DATE


-----Drop Example-----

GO
DROP TABLE Parents


                      --====== ‣ SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX --======


-- CLUSTERED INDEX

GO
CREATE CLUSTERED INDEX ix_Teacher_TeacherName ON Teacher(TeacherName)

-- NONCLUSTERED INDEX
GO
CREATE NONCLUSTERED INDEX ix_Student_StudentName ON Student(StudentName)


                        --*** SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE ***


----CREATING SEQUENCE

CREATE SEQUENCE CollageDBSeq
AS INT
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 10000
CYCLE  
GO


----ALTERING SEQUENCE

ALTER SEQUENCE CollageDBSeq
AS INT
RESTART WITH 201
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000
CYCLE
GO

                       --*** SECTION 06: CREATE A VIEW & ALTER VIEW ***

GO
CREATE VIEW vu_StudentInfoWithEncryptionSchemabinding
WITH ENCRYPTION,SCHEMABINDING
AS
SELECT t.TeacherName,s.StudentName,sm.SemesterName,sb.SubjectsName
FROM dbo.DataRelation d
JOIN dbo.Teacher t ON d.TeacherId=t.TeacherId
JOIN dbo.Student s ON d.StudentId=s.StudentId
JOIN dbo.Semester sm ON d.SemesterId=sm.SemesterId
JOIN dbo.Subjects sb ON d.SubjectsId=sb.SubjectsId
WHERE SubjectsName IN ('C#','Web Design')

         
--- **SECTION 07: CREATE STORED PROCEDURE** (Select ,Insert ,Update, Delete ,Output ,Return ,)
USE CollageDB
GO
CREATE PROC spInputOutputReturnType
@Statement varchar(6)='',
@StudentId int,
@StudentName varchar(2),
@Name varchar(2) output
 
 
                             -- **Selecting using stored procedure**
AS
BEGIN
IF @Statement='Select'
BEGIN
SELECT * FROM Student
END

                              -- **Insert using stored procedure **

IF @Statement='Insert'
BEGIN
BEGIN TRAN
BEGIN TRY
INSERT INTO Student(StudentId,StudentName)
VALUES(@StudentId,@StudentName)
COMMIT TRAN
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() AS ErrorMsg,
ERROR_SEVERITY() AS ErrorSeverity FROM Student
ROLLBACK TRAN
END CATCH
END

                          --*** Updating values using stored procedure***

IF @Statement='Update'
BEGIN
UPDATE Student SET StudentName=@StudentName WHERE StudentId=@StudentId
END

                           --*** Deleting values using stored procedure***

IF @Statement='Delete'
BEGIN
DELETE FROM Student WHERE StudentId=@StudentId
END

                             --***Output values using stored procedure***

IF @Statement='Output'
BEGIN
SELECT @Name=StudentName FROM Student WHERE StudentId=@StudentId
END

                            --*** Return values using stored procedure***
IF @Statement='Return'
BEGIN
DECLARE @StudentCount int
SELECT @StudentCount=COUNT(StudentId) FROM Student
RETURN @StudentCount;
END
END

                --*** SECTION 08: CREATE FUNCTION***(SCALER VALUED FUNCTION, TABLE VALUED FUNCTION ,,MULTITABLE FUNCTION)

GO

--Scaler Functions

CREATE FUNCTION fn_GetStudentName(@StudentId int)
RETURNS varchar(2)
BEGIN
RETURN (SELECT StudentName FROM Student WHERE StudentId=@StudentId)
END

---Table Valued Functions

GO
CREATE FUNCTION fn_TableValuedFunctions(@StudentId int)
RETURNS TABLE
RETURN (SELECT * FROM Student WHERE StudentId=@StudentId)

---Multitable Functions

GO
CREATE FUNCTION fn_MultiTableValuedFunction(@number int)
RETURNS @ReturnTable TABLE
(StudentId int,StudentName varchar(2))
BEGIN
INSERT INTO @ReturnTable
SELECT StudentId,StudentName FROM Student
UPDATE @ReturnTable SET StudentId=StudentId+@number
RETURN
END

---Creating a trigger
GO
USE CollegeDB
GO
CREATE TRIGGER tr_Insert_ItemLot
ON Subjects
FOR INSERT
AS
DECLARE @NewSubjectId int
SELECT @NewSubjectId=SubjectsId FROM inserted
IF @NewSubjectId<>10
BEGIN
RAISERROR ('You Cannot Insert Another Subject',1,1)
ROLLBACK
END


                       --** SECTION 09: CREATE TRIGGER ** (FOR/AFTER TRIGGER)


CREATE TRIGGER tr_Update_Student
ON Student
FOR UPDATE
AS
DECLARE @OldId int, @NewId int
SELECT @OldId=StudentId FROM deleted
SELECT @NewId=StudentId FROM inserted
IF @NewId>@OldId+10
BEGIN
RAISERROR ('You cannot inset more than 220 ',11,1)
ROLLBACK
END

                        -- ** SECTION 10: CREATE TRIGGER ** (INSTEAD OF TRIGGER)


CREATE TRIGGER tr_InstedOfTrigger
ON Student
INSTEAD OF Insert
AS
BEGIN
INSERT INTO StudentArchive
SELECT * FROM inserted
INSERT INTO Logs
VALUES
('Student inserted',GETDATE())
END