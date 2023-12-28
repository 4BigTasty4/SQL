use Academy;

go;

create table Departments(
    Id int primary key NOT NULL IDENTITY (1,1),
    Financing money DEFAULT 0 CHECK (Financing > 0) NOT NULL,
    Name nvarchar(100) CHECK (Name <> '') UNIQUE NOT NULL,
    FacultyId int NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

create table Faculties(
    Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(100) CHECK (Name <> '') UNIQUE NOT NULL,
);

create table Groups(
    Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(100) CHECK (Name <> '') UNIQUE NOT NULL,
    Year int CHECK (Year >= 1 and Year <= 5) NOT NULL,
    DepartmentId int NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

create table GroupsLectures(
    Id int primary key NOT NULL IDENTITY (1,1),
    GroupId int NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    LectureId int NOT NULL,
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);

create table Lectures(
    Id int primary key NOT NULL IDENTITY (1,1),
    DayOfWeek int CHECK (DayOfWeek >= 1 and DayOfWeek <= 7) NOT NULL,
    LectureRoom nvarchar(max) CHECK (LectureRoom <> '') NOT NULL,
    SubjectId int NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    TeacherId int NOT NULL,
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

create table Subjects(
    Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(100) CHECK (Name <> '') UNIQUE NOT NULL
);

create table Teachers(
    Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(max) CHECK (Name <> '') NOT NULL,
    Salary money CHECK (Salary > 0) NOT NULL,
    Surname nvarchar(max) CHECK (Surname <> '') NOT NULL
);

go;

select count(*) as NumberOfLectures
from Lectures where TeacherId in (select Id from Teachers
where Name = 'Dave McQueen');

select count(*) as NumberOfLectures
from Lectures where LectureRoom = 'D201';

select LectureRoom, count(*) as NumberOfLectures
from Lectures GROUP BY LectureRoom;

select count(distinct GroupId) as NumberOfStudents
from GroupsLectures where LectureId in
(select Id from Lectures where TeacherId in
(select Id from Teachers where Name = 'Jack Underhill'));

select avg(T.Salary) as AverageSalary
from Teachers T
JOIN
    Departments D ON T.Id = D.Id
JOIN
    Faculties F ON D.Id = F.Id
WHERE
    F.Name = 'Computer Science';

select avg(Financing) as AverageFinancing
from Departments;

select concat(Name,' ',Surname) as FullName,
count(distinct SubjectId) as NumberOfSubjects
from Lectures
join Teachers on Lectures.TeacherId = Teachers.Id
group by Teachers.Id,Name,Surname;

select
    avg(Financing) as AverageFinancing
from
    Departments;

select concat(Name, ' ') as FullName,
       count(distinct L.SubjectId) as DisciplinesCount
from Teachers
join Lectures L on Teachers.Id = L.TeacherId
group by
    Teachers.Id, Name;

select F.Name as FacultyName,
        count(S.Id) AS DisciplineCount
from
    Faculties F
left join
    Departments D ON F.Id = D.FacultyId
left join
    Groups G ON D.Id = G.DepartmentId
left join
    Lectures L ON G.Id = L.Id
left join
    Subjects S ON L.SubjectId = S.Id
group by
    F.Name;

select
    T.Id AS TeacherId,
    T.Name AS TeacherName,
    L.LectureRoom AS Auditorium,
    COUNT(*) AS LectureCount
from
    Lectures L
join
    Teachers T ON L.TeacherId = T.Id
group by
    T.Id, T.Name, L.LectureRoom;

