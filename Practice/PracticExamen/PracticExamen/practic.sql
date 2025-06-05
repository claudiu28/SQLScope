create database practic
go

use practic
go

create table facultate(
	id int primary key identity,
	nume varchar(100),
	acronim varchar(100),
	oras varchar(100),
	strada varchar(100),
	numar int,
	numar_studenti int
);

create table profesor(
	id int primary key identity,
	nume varchar(100),
	prenume varchar(100),
	grad varchar(100),
	facultate_id int not null,
	data_angajare datetime,
	constraint fk_facultate foreign key (facultate_id) references facultate(id)
);

insert into facultate(nume, acronim, oras, strada, numar, numar_studenti) values 
('facultate_1', 'fct_1', 'oras_1', 'strada_1', 1, 2000),
('facultate_2', 'fct_2', 'oras_2', 'strada_2', 2, 1000),
('facultate_3', 'fct_3', 'oras_3', 'strada_3', 3, 3000),
('facultate_4', 'fct_4', 'oras_1', 'strada_1', 4, 500);

insert into profesor(nume,prenume,grad,facultate_id, data_angajare) values
('prof_1', 'prf_1', 'profesor', 1, '2025-06-14'),
('prof_2', 'prf_2', 'profesor', 1, '2025-03-12'),
('prof_3', 'prf_3', 'profesor', 1, '2025-04-11'),
('prof_4', 'prf_4', 'laborant', 2, '2025-05-10'),
('prof_5', 'prf_5', 'laborant', 3, '2025-01-05'),
('prof_6', 'prf_6', 'seminarist', 2, '2025-06-20');

insert into profesor(nume,prenume,grad,facultate_id, data_angajare) values
('prof_7', 'prf_7', 'profesor', 1, '2023-06-14');


insert into profesor(nume,prenume,grad,facultate_id, data_angajare) values
('prof_8', 'prf_8', 'profesor', 4, '2023-06-14');
select * from facultate;
select * from profesor;

create index idx on profesor(nume, facultate_id)
go


select f.nume, p.grad, COUNT(p.id) as numar_profi from facultate as f inner join profesor as p on p.facultate_id = f.id group by f.nume, p.grad having COUNT(p.id) >= 3 and grad = 'profesor';

select COUNT(p.facultate_id) as numar_profi from facultate as f inner join profesor as p on p.facultate_id = f.id where p.nume like '%p%' and f.numar_studenti > 1000;



