USE Academy;
go;
CREATE TABLE Groups (
Id INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(10) UNIQUE NOT NULL,
Rating INT CHECK (Rating >= 0 AND Rating <= 5) NOT NULL,
Year INT CHECK (Year >= 1 AND Year <= 5) NOT NULL );

CREATE TABLE Departments (
Id INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(100) UNIQUE CHECK (Name <> '') NOT NULL,
Financing MONEY DEFAULT 0 CHECK (Financing >= 0) NOT NULL );

CREATE TABLE Faculties (
Id INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(100) UNIQUE CHECK (Name <> '') NOT NULL );

CREATE TABLE Teachers (
Id INT PRIMARY KEY IDENTITY(1,1),
EmploymentDate DATE CHECK (EmploymentDate >= '1990-01-01') NOT NULL,
Name NVARCHAR(50) CHECK (Name <> '') NOT NULL,
Surname NVARCHAR(50) CHECK (Surname <> '') NOT NULL,
Premium MONEY DEFAULT 0 CHECK (Premium >= 0) NOT NULL,
Salary MONEY CHECK (Salary > 0) NOT NULL  );
go;
insert into Groups (Name, Rating, Year) values ('699',2,4);
insert into Groups (Name, Rating, Year) values ('677',5,4);
insert into Groups (Name, Rating, Year) values ('611',4,4);
insert into Departments (Name, Financing) values ('Department of Physics',3500);
insert into Departments (Name, Financing) values ('Department of Inorganic Chemistry',2700);
insert into Departments (Name, Financing) values ('Department of General History',4700);
insert into Faculties (Name) values ('FACULTY OF PHYSICS');
insert into Faculties (Name) values ('CHEMICAL FACULTY');
insert into Faculties (Name) values ('HISTORY DEPARTMENT');
insert into Teachers (EmploymentDate, Name, Surname, Premium, Salary) values ('1997-05-11',N'Axmet', N'Raxmet' ,500,2400);
insert into Teachers (EmploymentDate, Name, Surname, Premium, Salary) values ('1997-05-11',N'Bob', N'Abobus' ,500,2400);
insert into Teachers (EmploymentDate, Name, Surname, Premium, Salary) values ('1997-05-11',N'Natasha', N'Abbasovna' ,500,2400);
go;
select * from Groups;
select * from Departments;
select * from Faculties;
select * from Teachers;
go;
