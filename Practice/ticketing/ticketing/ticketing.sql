create database ticketing;
go

use ticketing
go


create table clienti(
	id int primary key identity,
	nume_client varchar(100),
	varsta_client varchar(100)
);

create table ticket(
	id int primary key identity,
	nume_ticket varchar(100),
	pret_ticket decimal(10,2),
	eveniment varchar(100),
	locuri int,
	client_id int not null,
	constraint fk_client foreign key (client_id) references clienti(id)
);

insert into clienti(nume_client,varsta_client) values 
('client_1', 20),
('client_2', 18),
('client_3', 19),
('client_4', 30),
('client_5', 20);

insert into ticket(nume_ticket,pret_ticket,eveniment,locuri, client_id)
values 
('ticket_1', 100, 'eveniment_1', 5, 1),
('ticket_2', 120, 'eveniment_2', 3, 1),
('ticket_3', 110, 'eveniment_3', 2, 1),
('ticket_4', 80, 'eveniment_4', 1, 1),
('ticket_5', 90, 'eveniment_5', 7, 2),
('ticket_1', 70, 'eveniment_1', 10, 2),
('ticket_5', 88, 'eveniment_2', 11, 2),
('ticket_3', 90, 'eveniment_3', 12, 3),
('ticket_2', 99.99, 'eveniment_4', 13, 3),
('ticket_4', 130, 'eveniment_4', 4, 4),
('ticket_5', 140, 'eveniment_1', 12, 4),
('ticket_1', 150, 'eveniment_3', 15, 5),
('ticket_3', 110, 'eveniment_5', 5, 5);

select * from ticket
select * from clienti

create index idx_c on ticket(nume_ticket,client_id);

select t.nume_ticket, client_id from ticket as t where t.nume_ticket = 'ticket_1';


select c.nume_client, count(t.id) from Clienti as c
inner join ticket as t on t.client_id = c.id group by c.nume_client;

select c.nume_client from clienti as c inner join ticket as t on t.client_id = c.id
group by c.nume_client having sum(t.pret_ticket) >= 300;

select t.eveniment, count(c.id) from ticket as t inner join clienti as c on t.client_id = c.id
group by t.eveniment;

select c.nume_client from clienti as c inner join ticket as t on t.client_id = c.id group by 
c.nume_client having COUNT(t.id) = 2;

select c.nume_client,SUM(t.locuri) from clienti as c inner join ticket as t on t.client_id = c.id group by c.nume_client;