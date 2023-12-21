
use Academy;

go;

create table Departments(
    Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(100) UNIQUE CHECK (Name <> '') NOT NULL,
    Financing money DEFAULT 0 CHECK (Financing >= 0) NOT NULL
);

create table Faculties(
    Id int primary key NOT NULL IDENTITY (1,1),
    Dean nvarchar(Max) CHECK (Dean <> '') NOT NULL,
    Name nvarchar(100) UNIQUE CHECK (Name <> '') NOT NULL,
);

create table Groups(
  Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(10) CHECK (Name <> '') UNIQUE NOT NULL,
    Rating int CHECK (Rating >= 0 and Rating <= 5) NOT NULL,
    Year int CHECK (Year >= 1 and Year <= 5) NOT NULL
);

create table Teachers(
    Id int primary key NOT NULL IDENTITY (1,1),
    EmploymentDate date CHECK (EmploymentDate >= '01-01-1990') NOT NULL,
    IsAssistant bit DEFAULT 0 NOT NULL,
    IsProfessor bit DEFAULT 0 NOT NULL,
    Name nvarchar(MAX) CHECK (Name <> '') NOT NULL,
    Surname nvarchar(MAX) CHECK (Surname <> '') NOT NULL,
    Position nvarchar(MAX) CHECK (Position <> '') NOT NULL,
    Premium money DEFAULT 0 CHECK (Premium >= 0) NOT NULL,
    Salary money CHECK (Salary > 0) NOT NULL
);

go;

select Id,Financing,Name
FROM Departments;
select Name As "Group Name", Rating AS "Group Rating"
From Groups;
select Surname, Salary / Premium * 100, Salary / (Salary + Premium) * 100
FROM Teachers;
select 'The dean of faculty' + Name + 'is' + Dean
FROM Faculties;
select Surname FROM Teachers WHERE IsProfessor = 1 and Salary > 1050;
select Name FROM Departments WHERE Financing < 1100 or Financing > 25000;
select Name From Faculties WHERE Name <> 'Computer Science';
select Surname, Position From Teachers WHERE IsProfessor = 0;
select Surname,Position,Salary,Premium FROM Teachers WHERE IsAssistant = 1 and Premium >= 160 and Premium <= 550;
select Surname,Salary FROM Teachers WHERE IsAssistant = 1;
select Surname,Position FROM Teachers Where EmploymentDate < '01-01-2000';
select Name As "Name of Department" From Departments WHERE Name < 'Software Development' ORDER BY Name;
select Surname From Teachers WHERE IsAssistant = 1 and (Salary + Premium) <= 1200;
select Name From Groups WHERE Rating = 5 and Rating >= 2 and Rating <= 4;
select Surname FROM Teachers WHERE IsAssistant = 1 and (Salary > 550 or Premium < 200);

go;