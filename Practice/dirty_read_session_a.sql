use practic_1
go

begin transaction
update briosa set briosa.nume = 'dirty_read' where briosa.id = 14;
rollback