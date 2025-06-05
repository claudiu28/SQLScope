create database CoursesVideo
go

use CoursesVideo
go

create table instructor(
	id int primary key identity(1,1),
	nume varchar(100),
	pret decimal(10,2)
);

create table courses(
	id int primary key identity(1,1),
	nume varchar(100),
	durata time,
	instructor_id int not null,
	constraint fk_instructor foreign key (instructor_id) references courses(id)
);

insert into instructor(nume,pret) values 
('instructor_1',100),
('instructor_2',80),
('instructor_3',70),
('instructor_4',60),
('instructor_5',40),
('instructor_6',50),
('instructor_7',30),
('instructor_8',110),
('instructor_9',120),
('instructor_10',130);


insert into courses(nume,durata,instructor_id) values
('course_1','01:45:00',1),
('course_2','01:45:00',1),
('course_3','01:45:00',1),
('course_4','01:45:00',1),
('course_1','01:45:00',2),
('course_3','01:45:00',2),
('course_6','01:45:00',3),
('course_5','01:45:00',3),
('course_2','01:45:00',3),
('course_4','01:45:00',3),
('course_1','01:45:00',4),
('course_2','01:45:00',4),
('course_5','01:45:00',4),
('course_6','01:45:00',5),
('course_2','01:45:00',5);

select * from courses;
select * from instructor;

create index idx on courses(nume, durata);
select distinct c.nume, c.durata from courses as c where c.nume = 'course_1'
