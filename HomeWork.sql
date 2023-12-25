use Academy;

go;

create table Curators(
    Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(max) CHECK (Name <> '') NOT NULL,
    Surname nvarchar(max) CHECK (Name <> '') NOT NULL
);

create table Departments(
    Id int primary key NOT NULL IDENTITY (1,1),
    Financing money DEFAULT 0 CHECK (Financing > 0) NOT NULL,
    Name nvarchar(100) CHECK (Name <> '') UNIQUE NOT NULL,
    FacultyId int NOT NULL,
    foreign key (FacultyId) references Faculties(Id)
);

create table Faculties(
    Id int primary key NOT NULL IDENTITY (1,1),
    Financing money DEFAULT 0 CHECK (Financing > 0) NOT NULL,
    Name nvarchar(100) CHECK (Name <> '') UNIQUE NOT NULL,
);

create table Groups(
    Id int primary key NOT NULL IDENTITY(1,1),
    Name nvarchar(10) CHECK (Name <> '') UNIQUE NOT NULL,
    Year int CHECK (Year >= 1 and Year <= 5) NOT NULL,
    DepartmentId int NOT NULL,
    foreign key (DepartmentId) references Departments(Id)
);

create table GroupsCurators(
    Id int primary key NOT NULL IDENTITY (1,1),
    CuratorId int NOT NULL,
    foreign key (CuratorId) references Curators(Id),
    GroupId int NOT NULL,
    foreign key (GroupId) references Groups(Id)
);

create table GroupsLectures(
    Id int primary key NOT NULL IDENTITY (1,1),
    GroupId int NOT NULL,
    foreign key (GroupId) references Groups(Id),
    LectureId int NOT NULL,
    foreign key (LectureId) references Lectures(Id)
);

create table Lectures(
    Id int primary key NOT NULL IDENTITY (1,1),
    LectureRoom nvarchar(max) CHECK (LectureRoom <> '') NOT NULL,
    SubjectId int NOT NULL,
    foreign key (SubjectId) references Subjects(Id),
    TeacherId int NOT NULL,
    foreign key (TeacherId) references Teachers(Id)
);

create table Subjects(
    Id int primary key NOT NULL IDENTITY(1,1),
    Name nvarchar(100) CHECK (Name <> '') UNIQUE NOT NULL,
);

create table Teachers(
    Id int primary key NOT NULL IDENTITY (1,1),
    Name nvarchar(max) CHECK (name <> '') NOT NULL,
    Salary money CHECK (Salary > 0) NOT NULL,
    Surname nvarchar(max) CHECK (Surname <> '') NOT NULL
);

go;

select F.Name as FacultyName, D.Financing as FacultyFinancing
from Faculties F
inner join Departments D on F.Id = D.FacultyId
where d.Financing > F.Financing;

select C.Surname as CuratorSurname,
       G.Name as GroupName
from Curators C
inner join GroupsCurators GC on C.Id = GC.CuratorId
inner join Groups G on GC.GroupId = G.Id;

select T.Name as TeachersName,
       T.Surname as TeachersSurname
from Teachers T
inner join Lectures L on T.Id = L.TeacherId
inner join GroupsLectures GL on L.Id = GL.LectureId
inner join Groups G on G.Id = GL.GroupId
where G.Name = 'P107';

select T.Surname as TeachersSurname, --????????????????????????
       F.Name as FacultyName
from Teachers T
join Lectures L on T.Id = L.TeacherId
join Faculties F on L.Id = F.Id;

select D.Name as DepartmentsName,
       G.Name as GroupsName
from Departments D
inner join Groups G on D.Id = G.DepartmentId;

select S.Name SubjectName
from Subjects S
inner join Teachers T on S.Id = T.Id
where T.Name = 'Samantha Adams';

select D.Name as DepartmentName
from Departments D
join Subjects S on D.Id = S.Id
join Lectures L on S.Id = L.SubjectId
where S.Name = 'Database Theory';

select G.Name as GroupName
from Groups G
join Departments D on G.DepartmentId = D.Id
join Faculties F on D.FacultyId = F.Id
where D.Name = 'Computer Science';

select G.Name as GroupName,
       F.Name as FacultyName
from Groups G
join Departments D on D.Id = G.DepartmentId
join Faculties F on D.FacultyId = F.Id
where
    G.Year = 5;

select
    concat(Teachers.Name, ' ') as TeacherFullName,
    S.Name as DisciplineName,
    G.Name as GroupName,
    L.LectureRoom
from Teachers
join Lectures L on Teachers.Id = L.TeacherId
join Subjects S on L.SubjectId = S.Id
join Groups G on L.SubjectId = G.Id
where
    L.LectureRoom = 'B103'