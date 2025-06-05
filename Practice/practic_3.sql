create database practic3
go

use practic3
go

create table producator(
	id int primary key identity(1,1),
	nume varchar(100)
);

create table biscuiti(
	id int primary key identity(1,1),
	nume varchar(100),
	numar_biscuiti int,
	producator_id int,
	constraint fk_producator foreign key (producator_id) references producator(id)
);

insert into producator(nume) values
('producator_1'),
('producator_2'),
('producator_3'),
('producator_4'),
('producator_5');

insert into biscuiti(nume,numar_biscuiti,producator_id) values 
('biscuiti_1', 18, 1),
('biscuiti_2', 20, 1),
('biscuiti_3', 16, 1),
('biscuiti_4', 12, 1),
('biscuiti_5', 12, 1),
('biscuiti_1', 24, 2),
('biscuiti_2', 30, 2),
('biscuiti_3', 32, 2),
('biscuiti_4', 40, 3),
('biscuiti_5', 32, 3),
('biscuiti_1', 32, 4);
go

select * from biscuiti
select * from producator

--- index
create nonclustered index idx on biscuiti(nume) include (numar_biscuiti, producator_id)
go

select b.nume, b.numar_biscuiti, b.producator_id from biscuiti as b where b.nume = 'biscuiti_1'; 

-- joins

select p.nume, b.nume from producator as p left join biscuiti as b on b.producator_id = p.id;

select p.nume, b.nume from producator as p left join biscuiti as b on b.producator_id = p.id where b.nume is null;

select p.nume, COUNT(b.id) from producator as p inner join biscuiti as b on b.producator_id = p.id group by p.nume having COUNT(b.id) > 3;


select p.nume, b.nume, b.numar_biscuiti from producator as p inner join biscuiti as b on b.producator_id = p.id group by p.nume,b.nume,b.producator_id,b.numar_biscuiti
having b.numar_biscuiti = (select MAX(bb.numar_biscuiti) from biscuiti as bb where b.producator_id = bb.producator_id);

