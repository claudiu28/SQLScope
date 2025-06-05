create database system_local
go

use system_local
go

create table users(
	id int primary key identity,
	nume_user varchar(100),
	last_name varchar(100),
	first_name varchar(100),
	email varchar(100)
);

create table locuinte(
	id int primary key identity,
	nume_oras varchar(100),
	nume_strada varchar(100),
	numar_casa int,
	users_id int not null,
	constraint fk_users foreign key (users_id) references users(id)
);

insert into users(nume_user,first_name,last_name,email) values
('user_1', 'user_1', 'user_1', 'email1@gmail.com'),
('user_2', 'user_2', 'user_2', 'email2@gmail.com'),
('user_3', 'user_3', 'user_3', 'email3@gmail.com'),
('user_4', 'user_4', 'user_4', 'email4@gmail.com');

insert into locuinte(nume_oras,numar_casa,nume_strada,users_id) values
('oras_1', 1, 'strada_1', 1),
('oras_1', 2, 'strada_2', 2),
('oras_1', 3, 'strada_3', 3),
('oras_2', 1, 'strada_1', 1),
('oras_3', 2, 'strada_1', 1),
('oras_4', 1, 'strada_4', 2),
('oras_2', 3, 'strada_1', 2),
('oras_3', 1, 'strada_1', 3),
('oras_4', 1, 'strada_2', 4),
('oras_4', 3, 'strada_1', 4);

select * from users
select * from locuinte

create index idx_x on locuinte(nume_oras,numar_casa,users_id);

select l.nume_oras, l.numar_casa, users_id from locuinte as l where l.users_id = 1; 

select u.nume_user, count(l.id) from users as u inner join locuinte as l on u.id = l.users_id group by u.nume_user;
select u.nume_user, count(l.id) from users as u inner join locuinte as l on u.id = l.users_id group by u.nume_user having count(l.id) > 2;
select l.nume_oras, count(l.id) from locuinte as l group by l.nume_oras;
select u.nume_user from users as u inner join locuinte as l on l.users_id = u.id group by u.nume_user having count(distinct l.id) > 2;