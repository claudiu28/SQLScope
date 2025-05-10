use SGBD_LAB_4
go

set transaction isolation level repeatable read 
-- solution : reapeatable read 
-- see bug : read uncommitted
print 'T1: Start'
begin transaction
print 'Medicamente 1'
select * from MEDICAMENTE;
print 'Delay'
waitfor delay '00:00:10';
print 'Medicamente 2'
select * from MEDICAMENTE;
print 'Commit'
commit transaction