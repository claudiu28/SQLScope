use SGBD_LAB_3
go

if object_id('ValidareText', 'FN') is not null
    drop function ValidareText;
go

create function ValidareText(@Text varchar(Max), @MaxLength Int, @MinLength int = 1)
returns bit as begin
	return case 
		when @Text is null then 0
		when LEN(@Text) > @MaxLength then 0
		when LEN(@Text) < @MinLength then 0
		else 1
	end;
end
go

if object_id('ValidareNumericInt', 'FN') is not null
    drop function ValidareNumericInt;
go

create function ValidareNumericInt(@Numeric int, @MinValue int = 0)
returns bit as begin
	return case 
		when @Numeric is null then 0
		when @Numeric < @MinValue then 0
		else 1
	end;
end
go

if object_id('ValidareNumericFloat', 'FN') is not null
    drop function ValidareNumericFloat;
go

create function ValidareNumericFloat(@Numeric float, @MinValue float = 0)
returns bit as begin
	return case 
		when @Numeric is null then 0
		when @Numeric < @MinValue then 0
		else 1
	end;
end
go

if object_id('scenariu_inserare_totala', 'P') is not null
    drop procedure scenariu_inserare_totala;
go

create procedure scenariu_inserare_totala
    @NumeMedicament varchar(50),
    @DescriereMedicament varchar(500),
    @Pret float,
    @Stoc int,
    @NumeFarmacie varchar(50),
    @NumeCategorie varchar(100)
as begin
    set nocount on;
    
    begin try
        begin transaction;

        if dbo.ValidareText(@NumeMedicament, 50, 1) = 0
            raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Nume medicament invalid.","Field":"Nume"}', 16, 1);

        if dbo.ValidareText(@DescriereMedicament, 500, 1) = 0
            raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Descriere invalida.","Field":"Descriere"}', 16, 1);

        if dbo.ValidareNumericFloat(@Pret, 0) = 0
            raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Pret invalid.","Field":"Pret"}', 16, 1);

        if dbo.ValidareNumericInt(@Stoc, 0) = 0
            raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Stoc invalid.","Field":"Stoc"}', 16, 1);

        if dbo.ValidareText(@NumeFarmacie, 50, 1) = 0
            raiserror('{"Table":"FARMACIE_DETALII","Action":"VALIDATION","Error":"Nume farmacie invalid.","Field":"Nume"}', 16, 1);

        if dbo.ValidareText(@NumeCategorie, 100, 1) = 0
            raiserror('{"Table":"CATEGORIE","Action":"VALIDATION","Error":"Nume categorie invalid.","Field":"NumeCategorie"}', 16, 1);
        
        declare @farmacieId int;
        select @farmacieId = FarmacieId from FARMACIE_DETALII where Nume = @NumeFarmacie;

        if @farmacieId is null
            raiserror('{"Table":"FARMACIE_DETALII","Action":"LOOKUP","Error":"Farmacia nu exista.","Field":"Nume"}', 16, 1);

        declare @medicamentId int;
        select @medicamentId = MedicamentId from MEDICAMENTE where Nume = @NumeMedicament and Descriere = @DescriereMedicament and Pret = @Pret and Stoc = @Stoc and FarmacieId = @FarmacieId;

        declare @categorieId int;
        select @categorieId = CategorieId from CATEGORIE where NumeCategorie = @NumeCategorie;
        
        if @categorieId is null
			begin
            
				insert into CATEGORIE(NumeCategorie) values (@NumeCategorie);
				set @categorieId = SCOPE_IDENTITY();

				declare @LogInsertCategorieJson nvarchar(max) ='{"Table":"CATEGORIE","Action":"INSERT","Fields":{"CategorieId":' + cast(@categorieId as nvarchar) + ',"NumeCategorie":"' + @NumeCategorie + '"}}';
				insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INSERT', 'CATEGORIE', @LogInsertCategorieJson, 0, NULL);
			end
        else 
			begin
				declare @LogInfoCategorieJson nvarchar(max) = '{"Table":"CATEGORIE","Action":"INFO","Fields":{"CategorieId":' + cast(@categorieId as nvarchar) + ',"NumeCategorie":"' + @NumeCategorie + '"}}'; 
				insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INFO', 'CATEGORIE', @LogInfoCategorieJson, 0, NULL);
			end

        if @medicamentId is null
			begin
				insert into MEDICAMENTE(Nume, Descriere, Pret, Stoc, FarmacieId) values (@NumeMedicament, @DescriereMedicament, @Pret, @Stoc, @FarmacieId);
				set @medicamentId = SCOPE_IDENTITY();
            
				declare @LogInsertMedicamenteJson nvarchar(max) = '{"Table":"MEDICAMENTE","Action":"INSERT","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"Nume":"' + @NumeMedicament + '","Pret":' + cast(@Pret as nvarchar) + ',"Stoc":' + cast(@Stoc as nvarchar) + ',"FarmacieId":' + cast(@FarmacieId as nvarchar) + '}}';
				insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INSERT', 'MEDICAMENTE', @LogInsertMedicamenteJson, 0, NULL);
			end
        else
			begin
				declare @LogInfoMedJson nvarchar(max) ='{"Table":"MEDICAMENTE","Action":"INFO","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"Nume":"' + @NumeMedicament + '","Pret":' + cast(@Pret as nvarchar) + ',"Stoc":' + cast(@Stoc as nvarchar) + ',"FarmacieId":' + cast(@FarmacieId as nvarchar) + '}}';
				insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INFO', 'MEDICAMENTE', @LogInfoMedJson, 0, NULL);
			end

        if @medicamentId is null or @categorieId is null
            raiserror('{"Table":"MEDS_CATEGORIE","Action":"VALIDATION","Error":"ID-uri invalide pentru inserarea în relație.","Field":"MedicamentId,CategorieId"}', 16, 1);

        if exists (select 1 from MEDS_CATEGORIE where MedicamentId = @medicamentId and CategorieId = @categorieId)
			begin
				declare @LogInfoRelatieJson nvarchar(max) = '{"Table":"MEDS_CATEGORIE","Action":"INFO","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"CategorieId":' + cast(@categorieId as nvarchar) + '}}';
            
				insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INFO', 'MEDS_CATEGORIE', @LogInfoRelatieJson, 0, NULL);
			end
        else
        begin
            insert into MEDS_CATEGORIE(MedicamentId, CategorieId) values (@medicamentId, @categorieId);
            
            declare @LogMedsCategorieJson nvarchar(max) = '{"Table":"MEDS_CATEGORIE","Action":"INSERT","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"CategorieId":' + cast(@categorieId as nvarchar) + '}}';   
            insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INSERT', 'MEDS_CATEGORIE', @LogMedsCategorieJson, 0, NULL);
        end

        commit;
    end try
    begin catch
        if @@TRANCOUNT > 0
            rollback;
            
        declare @JsonMsg nvarchar(max) = ERROR_MESSAGE();
        declare @ActionType nvarchar(20) = ISNULL(JSON_VALUE(@JsonMsg, '$.Action'), 'UNKNOWN');
        declare @Entity nvarchar(50) = ISNULL(JSON_VALUE(@JsonMsg, '$.Table'), 'UNKNOWN');
        declare @ErrorText nvarchar(max) = ISNULL(JSON_VALUE(@JsonMsg, '$.Error'), 'Error unknown');

        insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values (@ActionType, @Entity, @JsonMsg, 1, @ErrorText);
    end catch;
end
go

select * from LogActions
select * from MEDICAMENTE
select * from CATEGORIE
select * from MEDS_CATEGORIE
select * from FARMACIE_DETALII

delete from MEDS_CATEGORIE;
delete from MEDICAMENTE;
delete from CATEGORIE;
delete from LogActions;

dbcc CHECKIDENT ('MEDICAMENTE', RESEED, 0);
dbcc CHECKIDENT ('CATEGORIE', RESEED, 0);
dbcc CHECKIDENT ('LogActions', RESEED, 0);

-- test cu success
exec scenariu_inserare_totala @NumeMedicament = 'Nurofen Junior', @DescriereMedicament = 'Pentru febra si durere la copii.', @Pret = 17.5,@Stoc = 90, @NumeFarmacie = 'Farmacia Catena', @NumeCategorie = 'Pediatrie';
-- test rollback apare eroare
exec scenariu_inserare_totala @NumeMedicament = '', @DescriereMedicament = 'Descriere valida.', @Pret = 10.5,@Stoc = 30, @NumeFarmacie = 'Farmacia Tei', @NumeCategorie = 'Antibiotice';
-- test rollback apare eroare
exec scenariu_inserare_totala @NumeMedicament = 'Antibiotic X', @DescriereMedicament = 'Tratament pentru infectii bacteriene.', @Pret = -15.0, @Stoc = 50, @NumeFarmacie = 'Farmacia Sensiblu', @NumeCategorie = 'Antibiotice';
-- test farmacie null
exec scenariu_inserare_totala @NumeMedicament = 'Parasinus Plus', @DescriereMedicament = 'Pentru raceala severa.', @Pret = 12.0, @Stoc = 45, @NumeFarmacie = 'Farmacia Inexistenta', @NumeCategorie = 'Raceala';
-- test duplicat
exec scenariu_inserare_totala @NumeMedicament = 'Nurofen Junior', @DescriereMedicament = 'Pentru febra si durere la copii.', @Pret = 17.5,@Stoc = 90, @NumeFarmacie = 'Farmacia Catena', @NumeCategorie = 'Pediatrie';
go