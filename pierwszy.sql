show databases;
select sysdate();
select curdatedepartmentsdepartmentsdept_empdept_manageremployeestitles(), year(current_date()), month(current_date()), dayofmonth(current_date());
use employees;
select * from employees where `gender` = 'M' order by `birth_date` ASC LIMIT 5;
SELECT `emp_no`,`first_name`, `last_name` FROM employees WHERE `emp_no` > 10000 AND `emp_no` < 10100 AND `gender` = 'M' ORDER BY `last_name` ASC;
SELECT * FROM `departments`;

create database cars;
show databases;
use cars;
-- schema
CREATE TABLE Departments (
    Id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(25) NOT NULL,
    PRIMARY KEY(Id)
);

CREATE TABLE Employees (
    Id INT NOT NULL AUTO_INCREMENT,
    FName VARCHAR(35) NOT NULL,
    LName VARCHAR(35) NOT NULL,
    PhoneNumber VARCHAR(11),
    ManagerId INT,
    DepartmentId INT NOT NULL,
    Salary INT NOT NULL,
    HireDate DATETIME NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY (ManagerId) REFERENCES Employees(Id),
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE Customers (
    Id INT NOT NULL AUTO_INCREMENT,
    FName VARCHAR(35) NOT NULL,
    LName VARCHAR(35) NOT NULL,
    Email varchar(100) NOT NULL,
    PhoneNumber VARCHAR(11),
    PreferredContact VARCHAR(5) NOT NULL,
    PRIMARY KEY(Id)
);

CREATE TABLE Cars (
    Id INT NOT NULL AUTO_INCREMENT,
    CustomerId INT NOT NULL,
    EmployeeId INT NOT NULL,
    Model varchar(50) NOT NULL,
    Status varchar(25) NOT NULL,
    TotalCost INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id)
);

-- data
INSERT INTO Departments
    (Id, Name)
VALUES
    (1, 'HR'),
    (2, 'Sales'),
    (3, 'Tech')
;

INSERT INTO Employees
    (Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, HireDate)
VALUES
    (1, 'James', 'Smith', 1234567890, NULL, 1, 1000, str_to_date('01-01-2002', '%d-%m-%Y')),
    (2, 'John', 'Johnson', 2468101214, '1', 1, 400, str_to_date('23-03-2005', '%d-%m-%Y')),
    (3, 'Michael', 'Williams', 1357911131, '1', 2, 600, str_to_date('12-05-2009', '%d-%m-%Y')),
    (4, 'Johnathon', 'Smith', 1212121212, '2', 1, 500, str_to_date('24-07-2016', '%d-%m-%Y'))
;

INSERT INTO Customers
    (Id, FName, LName, Email, PhoneNumber, PreferredContact)
VALUES
    (1, 'William', 'Jones', 'william.jones@example.com', '3347927472', 'PHONE'),
    (2, 'David', 'Miller', 'dmiller@example.net', '2137921892', 'EMAIL'),
    (3, 'Richard', 'Davis', 'richard0123@example.com', NULL, 'EMAIL')
;

INSERT INTO Cars
    (Id, CustomerId, EmployeeId, Model, Status, TotalCost)
VALUES
    ('1', '1', '2', 'Ford F-150', 'READY', '230'),
    ('2', '1', '2', 'Ford F-150', 'READY', '200'),
    ('3', '2', '1', 'Ford Mustang', 'WAITING', '100'),
    ('4', '3', '3', 'Toyota Prius', 'WORKING', '1254')
;
show tables;

select * from cars where CustomerId = 1;
select * from cars where TotalCost >= 200;

select * from cars where Model LIKE 'Ford%' ;

select * from cars order by Model ASC, TotalCost asc;

select * from customers;
select * from customers where PhoneNumber IS NOT NULL limit 1;

select MAX(TotalCost) from cars; 

select TotalCost, Model from cars where TotalCost in(Select max(TotalCost) from cars);

select * from employees;
select avg(Salary) from employees;
select * from employees where Salary > (select avg(Salary) from employees);

select concat(FName, " - ", LName) as FULLMANE from employees;

select sum(Salary), DepartmentID from employees group by DepartmentId;
