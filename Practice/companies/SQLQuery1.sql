create database manage
go

use manage
go

create table companies(
	id int primary key identity,
	nume varchar(100),
	number_locations int
);

create table employees(
	id int primary key identity,
	nume varchar(100),
	salary int,
	companies_id int not null,
	constraint fk_companies foreign key (companies_id) references companies(id)
);

insert into companies(nume,number_locations) values
('companies_1',2),
('companies_2',3),
('companies_3',4),
('companies_4',5),
('companies_5',6);

insert into employees(nume, salary, companies_id) values 
('employee_1', 20000, 1),
('employee_2', 30000, 1),
('employee_3', 40000, 1),
('employee_4', 20000, 1),
('employee_3', 50000, 2),
('employee_4', 20000, 2),
('employee_1', 50000, 2),
('employee_4', 60000, 3),
('employee_5', 70000, 3),
('employee_1', 80000, 4),
('employee_2', 90000, 4);

create index idx on employees(nume, companies_id);

select e.nume, e.companies_id from employees as e where e.nume = 'employee_1'; 

select c.nume from companies as c inner join employees as e on c.id = e.companies_id group by c.nume having COUNT(e.companies_id) >= 3; 

select e.nume from employees as e inner join companies as c on c.id  = e.companies_id group by e.nume having COUNT(distinct e.companies_id) >= 2;