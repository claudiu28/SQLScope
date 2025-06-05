create database practic1
go

use practic1
go

create table cofetarie(
	id int primary key identity(1,1),
	nume varchar(100)
);

create table briosa(
	id int primary key identity(1,1),
	nume varchar(100),
	pret decimal(10,2),
	cofetarie_id int,
	constraint fk_cofetarie foreign key (cofetarie_id) references cofetarie(id)
);

select * from cofetarie;
select * from briosa;

go
-- populate bd
insert into cofetarie(nume) values 
('cofetarie_1'),
('cofetarie_2'),
('cofetarie_3'),
('cofetarie_4'),
('cofetarie_5');


insert into briosa(nume,pret,cofetarie_id)
values
('briosa_1', 100.00, 1),
('briosa_2', 90.00, 1),
('briosa_3', 70.00, 1),
('briosa_4', 120.50, 1),
('briosa_1', 90.00, 2),
('briosa_2', 89.00, 2),
('briosa_4', 111.10, 2),
('briosa_2', 89.00, 3),
('briosa_3', 80.00, 3),
('briosa_4', 30.00, 3),
('briosa_2', 100.00, 4),
('briosa_4', 100.00, 4);

go

-- index
create nonclustered index idx on briosa(nume) include (pret, cofetarie_id);
go

select b.nume, b.pret, cofetarie_id as nuamrul_coftariei from briosa as b where b.nume = 'briosa_1';

go
-- joins

select b.nume as nume_briosa, c.nume as cofetarie_nume from briosa as b 
inner join cofetarie as c on c.id = b.cofetarie_id;

select c.nume, COUNT(b.id) as numar_briose from cofetarie as c
inner join briosa as b on b.cofetarie_id = c.id
group by c.nume; 


select c.nume from cofetarie as c inner join briosa as b on b.cofetarie_id = c.id
group by c.nume ,b.nume having b.nume = 'briosa_2';

select b.nume, b.pret,
case when c.nume = 'cofetarie_3' then 'YES' else 'NO' end
from briosa as b
inner join cofetarie as c on c.id = b.cofetarie_id;


select c.nume, b.nume, b.pret from cofetarie as c inner join briosa as b on b.cofetarie_id = c.id 
group by c.nume,b.nume,b.pret, b.cofetarie_id having b.pret = (select (MAX(b2.pret)) from briosa as b2 where b2.cofetarie_id = b.cofetarie_id);

select c.nume from cofetarie as c left join briosa as b on b.cofetarie_id = c.id and b.nume = 'briosa_3' where b.cofetarie_id is null;

