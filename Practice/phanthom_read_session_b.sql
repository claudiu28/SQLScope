use practic3
go

begin transaction;
insert into biscuiti(nume,numar_biscuiti,producator_id) values ('biscuiti_phantom', 4, 1);

commit;