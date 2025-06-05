use practic3
go

begin transaction
set transaction isolation level serializable;

select * from biscuiti where biscuiti.numar_biscuiti < 10;

rollback;