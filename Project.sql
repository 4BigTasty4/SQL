
use Ecommerce;

go;

create table Cars(
    Car_Id int primary key not null identity (1,1),
    Brand nvarchar(max) check (Brand <> '') not null,
    Model nvarchar(max) check (Model <> '') not null,
    Year int not null,
    Fuel_Type_Id int not null,
    foreign key (Fuel_Type_Id) references FuelTypes(Fuel_Type_Id),
    Body_Type_Id int not null,
    foreign key (Body_Type_Id) references BodyTypes(Body_Type_Id),
    Color_Id int not null,
    foreign key (Color_Id) references Colors(Color_Id),
    Image_Link nvarchar(max)
);

create table Users(
    User_Id int primary key not null identity (1,1),
    Username nvarchar(max) check (Username <> '') not null,
    Password nvarchar(max) check (Password <> '') not null,
    Email nvarchar(50) not null unique check(Email like '%_@_%._%')
);

create table ProductList(
    Product_Id int primary key not null identity (1,1),
    Car_Id int not null,
    foreign key (Car_Id) references Cars(Car_Id),
    Seller_Id int not null,
    foreign key (Seller_Id) references Users(User_Id),
    Price money not null,
    Quantity int not null
);

create table ManufacturingCountries(
    Country_Id int primary key not null identity (1,1),
    Country_Name nvarchar(max) check (Country_Name <> '') not null
);

create table FuelTypes(
    Fuel_Type_Id int primary key not null identity (1,1),
    Fuel_Type nvarchar(max) check (Fuel_Type <> '') not null
);

create table BodyTypes(
    Body_Type_Id int primary key not null identity (1,1),
    Body_Type nvarchar(max) check (Body_Type <> '') not null
);

create table Colors(
    Color_Id int primary key not null identity (1,1),
    Color_Name nvarchar(max) check (Color_Name <> '') not null
);

create table Sellers(
    Seller_Id int primary key not null identity (1,1),
    User_Id int not null,
    foreign key (User_Id) references Users(User_Id),
    Company_Name nvarchar(max) check (Company_Name <> '') not null,
    Contact_Number nvarchar(max) check (Company_Name <> '') not null,
    Country_Id int not null,
    foreign key (Country_Id) references ManufacturingCountries(Country_Id),
    Rating int not null
);

