create database streaming
go

use streaming
go


create table actor(
	id int primary key identity,
	nume varchar(100) not null,
	age int not null 
);
create table filme(
	id int primary key identity,
	nume varchar(100) not null,
	actor_id int not null,
	durata time not null,
	website varchar(100),
	constraint fk_actor foreign key (actor_id) references actor(id)
);

insert into actor(nume,age) values 
('actor_1', 20),
('actor_2', 21),
('actor_3', 20),
('actor_4', 22),
('actor_5', 25);

insert into filme (nume, durata, website, actor_id) values
('film_1', '02:30:45', 'website_1', 1),
('film_2', '02:24:45', 'website_2', 1),
('film_3', '02:30:30', 'website_3', 1),
('film_4', '01:30:20', 'website_4', 1),
('film_5', '01:30:45', 'website_5', 1),
('film_1', '01:30:20', 'website_4', 2),
('film_2', '02:50:56', 'website_5', 2),
('film_5', '01:30:45', 'website_2', 2),
('film_3', '02:30:45', 'website_3', 3),
('film_4', '01:30:45', 'website_4', 4),
('film_1', '02:30:45', 'website_1', 3),
('film_5', '02:30:45', 'website_5', 4),
('film_4', '01:30:45', 'website_1', 5);

select * from filme
select * from actor

create index idx on filme(nume, website);
select f.website, f.nume from filme as f where f.website = 'website_1';

select a.nume, COUNT(f.id) from actor as a inner join filme as f on f.actor_id = a.id group by a.nume;

select a.nume from actor as a inner join filme as f on f.actor_id = a.id group by a.nume having MIN(f.durata) > '02:30:00'