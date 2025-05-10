use SGBD_LAB_4
go

SET DEADLOCK_PRIORITY LOW;

declare @retry int = 3;
declare @success bit = 0;

while @retry > 0 and @success = 0
begin
	begin try
		print 'T2: Start...'
		begin transaction
		update CATEGORIE set NumeCategorie = 'algo' where CategorieId = 1;
		waitfor delay '00:00:05'
		update MEDICAMENTE set Stoc = 50 where MedicamentId = 2;
		commit transaction
		set @success = 1;
	end try
	begin catch
		if ERROR_NUMBER() = 1205
		begin
			set @retry = @retry - 1
			rollback transaction;
			waitfor delay '00:00:01'
			SELECT 'Deadlock detectat, retry'
		end
	end catch
	if @success = 1 begin
		print 'A fost reincaract si executat cu succes!' end
end
select * from CATEGORIE
select * from MEDICAMENTE