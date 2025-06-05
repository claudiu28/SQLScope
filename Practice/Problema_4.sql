create database Problema_4
go

use Problema_4
go

create table Autori(
	cod_autor int primary key identity,
	nume varchar(100)
);
create table Categorii(
	cod_categorie int primary key identity,
	nume varchar(100)
);

create table Edituri(
	cod_editura int primary key identity,
	nume varchar(100)
);
create table Carti(
	cod_carte int primary key identity,
	nume varchar(100),
	cod_autor int,
	cod_editura int,
	cod_categorie int,
	an_publicare int,
	constraint fk_cod_editura foreign key (cod_editura) references Edituri(cod_editura),
	constraint fk_cod_categ foreign key (cod_categorie) references Categorii(cod_categorie),
	constraint fk_cod_autor foreign key (cod_autor) references Autori(cod_autor)
);


insert into Autori(nume) values 
('autor_1'),
('autor_2'),
('autor_3'),
('autor_4'),
('autor_5');

insert into Categorii(nume) values
('categorie_1'),
('categorie_2'),
('categorie_3'),
('categorie_4'),
('categorie_5');

insert into Edituri(nume) values
('editura_1'),
('editura_2'),
('editura_3'),
('editura_4'),
('editura_5');

insert into Carti(an_publicare,nume,cod_autor,cod_categorie,cod_editura) values
(2000,'carte_1',1,1,1),
(2001,'carte_2',1,2,1),
(2002,'carte_3',1,3,1),
(2003,'carte_4',1,3,2),
(2004,'carte_5',1,2,2),
(2010,'carte_1',2,1,1),
(2011,'carte_2',2,1,2),
(2011,'carte_5',2,4,1),
(2012,'carte_3',3,3,1),
(2013,'carte_2',3,1,5),
(2013,'carte_4',4,2,4),
(2012,'carte_1',4,2,5),
(2011,'carte_5',5,1,1);

select * from Autori
select * from Carti
select * from Categorii
select * from Edituri;

-- index

create index idx on Carti(an_publicare, nume);
go

select c.nume, c.an_publicare from Carti as c where c.an_publicare = 2011;

go

-- joins

select a.nume, COUNT(c.cod_carte) as number_of_books from Autori as a inner join Carti as c on c.cod_autor = a.cod_autor group by a.nume having COUNT(c.cod_carte) >= 3;

select e.nume, COUNT(c.cod_categorie) as numar_carti from Edituri as e inner join Carti as c on c.cod_editura = e.cod_editura  group by e.nume having COUNT(c.cod_categorie) >= 2;
