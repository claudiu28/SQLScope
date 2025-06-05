create database  medical
go

use medical
go 

create table pacient(
	id int primary key identity(1,1),
	nume varchar(100) not null,
);

create table programari(
	id int primary key identity(1,1),
	nume varchar(100),
	id_pacient int not null,
	constraint fk_pacient foreign key (id_pacient) references pacient(id)
);

select * from pacient;
select * from programari;

insert into pacient values 
('pacient_1'),
('pacient_2'),
('pacient_3'),
('pacient_4'),
('pacient_5'),
('pacient_6');

insert into programari(nume,id_pacient) values 
('programari_1', 1),
('programari_2', 1),
('programari_3', 1),
('programari_4', 1),
('programari_5', 1),
('programari_1', 2),
('programari_5', 2),
('programari_4', 2),
('programari_1', 3),
('programari_5', 3),
('programari_3', 4),
('programari_2', 4);


create index idx on programari(nume, id_pacient);

select p.nume from programari as p where p.nume = 'programari_1'; 